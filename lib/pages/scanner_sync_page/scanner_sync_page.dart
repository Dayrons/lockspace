import 'package:app/models/Password.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'dart:convert';
import 'dart:io';

class ScannerSyncPage extends StatefulWidget {
  final PageController controller;
  const ScannerSyncPage({
    super.key,
    required this.controller,
  });

  @override
  State<ScannerSyncPage> createState() => _ScannerSyncPageState();
}

class _ScannerSyncPageState extends State<ScannerSyncPage> {
  final _userPreferences = UserSharedPrefs();
  bool stanbay = false;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<Map>> _getPassowrds() async {
    Password password = Password();
    List<Password> passwords = await password.getAll(decrypt: false);
    return List.generate(passwords.length, (i) {
      final pwdMap = passwords[i].toMap();
      pwdMap["created_at"] = pwdMap["created_at"].toString();
      pwdMap["updated_at"] = pwdMap["updated_at"].toString();
      return pwdMap;
    });
  }

  Future _connectFtp({String? jwt, BuildContext? context}) async {
    if (jwt == null) return;

    try {
      await Vibration.vibrate(duration: 150);
    } catch (_) {}

    final jwtDecode = JwtDecoder.decode(jwt);
    await _userPreferences.init();
    final user = _userPreferences.getUser();
    if (user == null) return;

    final passwords = await _getPassowrds();
    final String uuid = getDeviceId();

    FTPConnect ftpConnect = FTPConnect(jwtDecode["host"] as String,
        port: 2121, user: jwtDecode["username"] as String, pass: jwtDecode["password"] as String);
    final path = await _localPath;

    File file = File('$path/data.txt');
    final Map<String, dynamic> data = {
      "user": user.toMap(),
      "uuid": uuid,
      "passwords": passwords,
    };

    file.writeAsString(json.encode(data));
    await ftpConnect.connect();
    bool response = await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
    await ftpConnect.disconnect();
    if (response) {
      widget.controller.animateToPage(
        1,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }

    setState(() {
      stanbay = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        stanbay
            ? Positioned(
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(const Color(detalles)),
                    ),
                  ),
                ),
              )
            : MobileScanner(
                onDetect: (capture) async {
                  final barcode = capture.barcodes.firstOrNull;
                  if (barcode?.rawValue != null) {
                    setState(() {
                      stanbay = true;
                    });
                    await _connectFtp(
                        jwt: barcode!.rawValue, context: context);
                  }
                },
              )
      ],
    );
  }
}
