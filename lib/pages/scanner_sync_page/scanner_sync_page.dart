import 'package:app/models/Password.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/ui.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:crypto/crypto.dart';
import 'dart:convert';
import 'dart:io';

class ScannerSyncPage extends StatefulWidget {
  final PageController controller;
  const ScannerSyncPage({
    Key key,
    this.controller,
  }) : super(key: key);

  @override
  State<ScannerSyncPage> createState() => _ScannerSyncPageState();
}

class _ScannerSyncPageState extends State<ScannerSyncPage> {
  final _userPreferences = UserSharedPrefs();

  final qrKey = GlobalKey(debugLabel: "QR");
  QRViewController controller;
  Barcode result;
  bool stanbay = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<List<Map>> _getPassowrds() async {
    Password password = Password();
    List<Password> passwords = await password.getAll(decrypt: false);
    return List.generate(passwords.length, (i) {
      final password  = passwords[i].toMap();
      password["created_at"] = password["created_at"].toString();
      password["updated_at"] = password["updated_at"].toString();
      return password;
    });
  }

  String test(String texto, String llave) {
    final plainText = 'f8:b1:56:af:0f:51';

    final key = encrypt.Key.fromUtf8(llave);

    // Este iv es diferente al que encripta en nodejs
    final iv = encrypt.IV.fromLength(16);

    final test = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = test.encrypt(plainText, iv: iv);

    final decrypted = test.decrypt(encrypt.Encrypted.fromBase64(texto), iv: iv);

    return decrypted;
  }

  Future _connectFtp({jwt, BuildContext context}) async {


    Vibration.vibrate(duration: 150);
    final jwtDecode = JwtDecoder.decode(jwt);
    await _userPreferences.init();
    final user = _userPreferences.getUser();
    // final xx = test(jwtDecode["name"], 'secretkey:hapilyeverafter1234567');

    final passwords = await _getPassowrds();

    final String uuid = await getDeviceId();
    
    FTPConnect ftpConnect = FTPConnect(jwtDecode["host"],
        port: 2121, user: jwtDecode["username"], pass: jwtDecode["password"]);
    final path = await _localPath;

    File file = File('$path/data.txt');
    final Map data = {
      "user": user.toMap(),
      "uuid": uuid,
      "passwords": passwords
    };

    print("DATA A ENVIAR $data");

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
    final Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        stanbay
            ? Positioned(
                // bottom: size.height / 8,
                bottom: 0,
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(detalles)),
                    ),
                  ),
                ),
              )
            : QRView(
                key: qrKey,
                onQRViewCreated: _onQRViewCreated,
                overlay: QrScannerOverlayShape(
                    borderLength: 20,
                    borderWidth: 10.0,
                    borderRadius: 5.00,
                    borderColor: const Color(0XFF2CDA9D)),
              )
      ],
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;

    controller.scannedDataStream.listen((scanData) async {
      setState(() {
        stanbay = true;
      });
      await _connectFtp(jwt: scanData.code, context: context);
    });
  }
}
