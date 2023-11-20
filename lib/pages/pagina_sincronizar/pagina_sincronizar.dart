import 'package:app/models/Password.dart';
import 'package:app/pages/inicio/pagina_usuario.dart';
import 'package:app/utils/ui.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vibration/vibration.dart';
import 'package:ftpconnect/ftpconnect.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class PaginaSincronizar extends StatefulWidget {
  const PaginaSincronizar();

  @override
  State<PaginaSincronizar> createState() => _PaginaSincronizarState();
}

class _PaginaSincronizarState extends State<PaginaSincronizar> {
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

  void _connectFtp({server, BuildContext context}) async {
    final data = await _getPassowrds();
    FTPConnect ftpConnect =
        FTPConnect(server, port: 2121, user: 'user', pass: 'password');
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0XFF1c1d22),
        elevation: 0,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.navigate_before,
            color: const Color(0XFF2CDA9D),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
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
      ),
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
      _connectFtp(server: scanData.code, context: context);
      Vibration.vibrate(duration: 300);
    });
  }
}
