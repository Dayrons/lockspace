import 'package:app/models/Password.dart';
import 'package:app/pages/home_page/home_page.dart';
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
  const ScannerSyncPage();

  @override
  State<ScannerSyncPage> createState() => _ScannerSyncPageState();
}

class _ScannerSyncPageState extends State<ScannerSyncPage> {
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
    List passwords = await password.obtener();
    return List.generate(passwords.length, (i) {
      final Password password = passwords[i];
      return password.toMap();
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

  void _connectFtp({jwt, BuildContext context}) async {
    final jwtDecode = JwtDecoder.decode(jwt);

    // final xx = test(jwtDecode["username"], 'secretkey:hapilyeverafter1234567');

    final data = await _getPassowrds();
    FTPConnect ftpConnect = FTPConnect(jwtDecode["host"],
        port: 2121, user: jwtDecode["username"], pass: jwtDecode["password"]);
    final path = await _localPath;
    File file = File('$path/password.txt');
    file.writeAsString(json.encode(data));
    await ftpConnect.connect();
    bool response = await ftpConnect.uploadFileWithRetry(file, pRetryCount: 2);
    await ftpConnect.disconnect();
    if (response) {
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (BuildContext context) => PaginaInicio()),
        (Route<dynamic> route) => false,
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
        QRView(
          key: qrKey,
          onQRViewCreated: _onQRViewCreated,
          overlay: QrScannerOverlayShape(
              borderLength: 20,
              borderWidth: 10.0,
              borderRadius: 5.00,
              borderColor: const Color(0XFF2CDA9D)),
        ),
        stanbay
            ? Positioned(
                bottom: size.height / 8,
                left: 0,
                right: 0,
                child: SizedBox(
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(detalles)),
                    ),
                  ),
                ),
              )
            : SizedBox()
      ],
    );
  }

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: _onQRViewCreated,
      );

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        stanbay = true;
      });

      _connectFtp(jwt: scanData.code, context: context);
      Vibration.vibrate(duration: 150);
    });
  }
}
