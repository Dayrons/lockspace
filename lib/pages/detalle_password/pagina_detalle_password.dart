import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaginaDetallePassword extends StatelessWidget {
  final String password;

  const PaginaDetallePassword({Key key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
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
      body: Center(
        child: QrImage(
          data: password,
          backgroundColor: Colors.white,
          version: QrVersions.auto,
          size: 200.0,
        ),
      ),
    );
  }
}

//https://pub.dev/packages/qr_flutter