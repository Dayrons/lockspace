import 'dart:async';
import 'dart:convert';

import 'package:app/models/Password.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

/// Servicio de sincronización via WebSocket con el Desktop.
class SyncService {
  static final SyncService _instance = SyncService._internal();
  factory SyncService() => _instance;
  SyncService._internal();

  WebSocketChannel? _channel;
  bool _isConnected = false;
  StreamSubscription? _subscription;

  final _connectionController = StreamController<bool>.broadcast();
  final _syncCompletedController = StreamController<Map<String, int>?>.broadcast();

  bool get isConnected => _isConnected;
  Stream<bool> get onConnectionChanged => _connectionController.stream;
  Stream<Map<String, int>?> get onSyncCompleted => _syncCompletedController.stream;

  Future<void> connect(String token) async {
    try {
      final parts = token.split('.');
      if (parts.length != 3) throw Exception('Token inválido');
      final payload = utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
      final data = json.decode(payload) as Map<String, dynamic>;

      print('[WS] JWT payload: $data');

      final host = data['host'] as String;
      final port = (data['port'] as num).toInt();

      final uri = Uri.parse('ws://$host:$port?token=$token');
      print('[WS] Conectando a: $uri');

      _channel = WebSocketChannel.connect(uri);
      await _channel!.ready;
      print('[WS] Conexión establecida');

      _isConnected = true;
      _connectionController.add(true);

      _subscription = _channel!.stream.listen(
        _handleMessage,
        onError: (error) {
          print('[WS] Error: $error');
          disconnect();
        },
        onDone: () {
          print('[WS] Conexión cerrada');
          disconnect();
        },
      );

      // Enviar sync_request con datos del usuario y passwords
      final _userPreferences = UserSharedPrefs();
      await _userPreferences.init();
      final user = _userPreferences.getUser();

      final passwordModel = Password();
      final localPasswords = await passwordModel.getAll(decrypt: false);
      final passwordMaps = List.generate(localPasswords.length, (i) {
        final pwdMap = localPasswords[i].toMap();
        pwdMap["created_at"] = pwdMap["created_at"].toString();
        pwdMap["updated_at"] = pwdMap["updated_at"].toString();
        return pwdMap;
      });

      _send({
        'type': 'sync_request',
        'user': user?.toMap(),
        'passwords': passwordMaps,
      });
    } catch (e) {
      print('[WS] Error conectando: $e');
      disconnect();
    }
  }

  void disconnect() {
    _subscription?.cancel();
    _subscription = null;
    _channel?.sink.close();
    _channel = null;
    if (_isConnected) {
      _isConnected = false;
      _connectionController.add(false);
    }
  }

  void sendPasswordCreated(Password password) {
    if (!_isConnected || _channel == null) return;
    _send({
      'type': 'password_created',
      'password': _passwordToMap(password),
    });
  }

  void sendPasswordUpdated(Password password) {
    if (!_isConnected || _channel == null) return;
    _send({
      'type': 'password_updated',
      'password': _passwordToMap(password),
    });
  }

  void _send(Map<String, dynamic> msg) {
    _channel!.sink.add(json.encode(msg));
  }

  Future<void> _handleMessage(dynamic data) async {
    try {
      final msg = json.decode(data as String) as Map<String, dynamic>;
      final type = msg['type'] as String;

      switch (type) {
        case 'sync_response':
          final passwords = (msg['passwords'] as List).cast<Map<String, dynamic>>();
          final results = await Password.mergeFromRemote(passwords);
          if (results['created']! > 0 || results['updated']! > 0) {
            _syncCompletedController.add(results);
          }
          break;

        case 'password_created':
        case 'password_updated':
          final pwd = msg['password'] as Map<String, dynamic>;
          final results = await Password.mergeFromRemote([pwd]);
          if (results['created']! > 0 || results['updated']! > 0) {
            _syncCompletedController.add(results);
          }
          break;
      }
    } catch (e) {
      print('[WS] Error procesando mensaje: $e');
    }
  }

  Map<String, dynamic> _passwordToMap(Password password) {
    String? createdAt;
    String? updatedAt;
    try {
      createdAt = password.createdAt.toIso8601String();
    } catch (_) {}
    try {
      updatedAt = password.updatedAt.toIso8601String();
    } catch (_) {}

    return {
      'uuid': password.uuid,
      'title': password.title,
      'password': password.password,
      'expiration': password.expiration,
      'expiration_unit': password.expirationUnit,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
