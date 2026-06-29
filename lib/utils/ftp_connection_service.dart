import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:app/models/Password.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';

/// Servicio singleton que mantiene el estado de la conexión FTP con el Desktop.
/// Sync por evento:
/// - Al escanear QR: sync completo (upload + download + merge)
/// - Al crear/editar password en Flutter: upload + download (para recibir cambios del desktop)
/// - Timer ligero cada 30s: solo download (para recibir passwords creados en el desktop)
class FtpConnectionService {
  static final FtpConnectionService _instance = FtpConnectionService._internal();
  factory FtpConnectionService() => _instance;
  FtpConnectionService._internal();

  bool _isConnected = false;
  String _host = '';
  int _port = 2121;
  String _username = '';
  String _password = '';

  final _controller = StreamController<bool>.broadcast();
  final _syncCompletedController = StreamController<Map<String, int>?>.broadcast();

  /// Timer para descargar cambios del desktop periódicamente
  Timer? _pollTimer;

  bool get isConnected => _isConnected;
  Stream<bool> get onConnectionChanged => _controller.stream;
  Stream<Map<String, int>?> get onSyncCompleted => _syncCompletedController.stream;

  void connect({
    required String host,
    int port = 2121,
    required String username,
    required String password,
  }) {
    _host = host;
    _port = port;
    _username = username;
    _password = password;
    _isConnected = true;
    _controller.add(true);

    // Iniciar poll cada 30s: solo descargar cambios del desktop
    _startPoll();
  }

  void disconnect() {
    _isConnected = false;
    _controller.add(false);
    _stopPoll();
  }

  void _startPoll() {
    _stopPoll();
    _pollTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      downloadAndMerge();
    });
  }

  void _stopPoll() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  /// Sube todos los passwords locales al Desktop via FTP.
  Future<void> uploadSync() async {
    if (!_isConnected) return;
    try {
      final ftpConnect = FTPConnect(_host, port: _port, user: _username, pass: _password);
      await ftpConnect.connect();
      await _uploadLocalPasswords(ftpConnect);
      await ftpConnect.disconnect();
    } catch (e) {
      print('[SYNC] uploadSync error: $e');
    }
  }

  /// Descarga sync_down.json del Desktop y aplica merge.
  Future<Map<String, int>?> downloadAndMerge() async {
    if (!_isConnected) return null;
    try {
      final ftpConnect = FTPConnect(_host, port: _port, user: _username, pass: _password);
      await ftpConnect.connect();
      final results = await _downloadAndApplySyncDown(ftpConnect);
      await ftpConnect.disconnect();
      if (results != null && (results['created']! > 0 || results['updated']! > 0)) {
        _syncCompletedController.add(results);
      }
      return results;
    } catch (e) {
      print('[SYNC] downloadAndMerge error: $e');
      return null;
    }
  }

  /// Sync completo: sube cambios locales y descarga/aplica cambios remotos.
  Future<void> fullSync() async {
    if (!_isConnected) return;
    try {
      final ftpConnect = FTPConnect(_host, port: _port, user: _username, pass: _password);
      await ftpConnect.connect();
      await _uploadLocalPasswords(ftpConnect);
      final results = await _downloadAndApplySyncDown(ftpConnect);
      await ftpConnect.disconnect();
      if (results != null) {
        _syncCompletedController.add(results);
      }
    } catch (e) {
      print('[SYNC] fullSync error: $e');
    }
  }

  Future<void> _uploadLocalPasswords(FTPConnect ftpConnect) async {
    try {
      final _userPreferences = UserSharedPrefs();
      await _userPreferences.init();
      final user = _userPreferences.getUser();
      if (user == null) return;

      final passwordModel = Password();
      final passwords = await passwordModel.getAll(decrypt: false);
      final passwordMaps = List.generate(passwords.length, (i) {
        final pwdMap = passwords[i].toMap();
        pwdMap["created_at"] = pwdMap["created_at"].toString();
        pwdMap["updated_at"] = pwdMap["updated_at"].toString();
        return pwdMap;
      });

      final data = {
        "user": user.toMap(),
        "passwords": passwordMaps,
      };

      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/data.txt');
      file.writeAsStringSync(json.encode(data));
      await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
    } catch (e) {
      print('[SYNC] upload error: $e');
    }
  }

  Future<Map<String, int>?> _downloadAndApplySyncDown(FTPConnect ftpConnect) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final syncDownFile = File('${directory.path}/sync_down.json');

      bool downloadOk = await ftpConnect.downloadFileWithRetry(
        'sync_down.json',
        syncDownFile,
        pRetryCount: 2,
      );

      if (downloadOk && syncDownFile.existsSync()) {
        final String content = syncDownFile.readAsStringSync();
        if (content.isNotEmpty) {
          final List<dynamic> remotePasswords = json.decode(content);
          final remoteList = remotePasswords.cast<Map<String, dynamic>>();
          final results = await Password.mergeFromRemote(remoteList);

          if (results['created']! > 0 || results['updated']! > 0) {
            print('[SYNC] Merge: ${results["created"]} created, ${results["updated"]} updated');
          }
          syncDownFile.deleteSync();
          return results;
        }
      }
    } catch (e) {
      print('[SYNC] download/merge error: $e');
    }
    return null;
  }
}
