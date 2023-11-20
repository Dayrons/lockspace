import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:local_auth/local_auth.dart';

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
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: getHorizontalSpace(context)),
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          SizedBox(
            height: 20.00,
          ),
          QrImage(
            data: password,
            backgroundColor: Colors.white,
            version: QrVersions.auto,
            size: 160.0,
          ),
          SizedBox(
            height: 20.00,
          ),
          Input(
            input: 'password',
            texto: "Actualizar contraseña",
            validacion: true,
            // controller: controller,
            onChange: () {},
          ),
          Boton(
            texto: "Actualizar contraseña",
            onTap: () {},
          ),
        ]),
      ),
    );
  }
}

//https://pub.dev/packages/qr_flutter