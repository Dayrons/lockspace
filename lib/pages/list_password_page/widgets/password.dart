import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/pages/details_password_page/details_password_page.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PasswordWidget extends StatelessWidget {
  Password password;

  PasswordWidget({Key key, this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _auth(context),
      child: Container(
        margin: EdgeInsets.only(bottom: 10.00),
        padding: EdgeInsets.symmetric(horizontal: 15.00, vertical: 5.00),
        decoration: BoxDecoration(
          color: Color(0XFF2b2e3d).withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // IconButton(
            //   splashRadius: 20.00,
            //   iconSize: 16.00,
            //   color: const Color(0XFF2CDA9D),
            //   icon: Icon(
            //     Icons.more_vert,
            //   ),
            //   onPressed: () {},
            // ),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "${password.title}",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.00),
              ),
              SizedBox(
                height: 5.00,
              ),
              Text(
                "password".toUpperCase(),
                style: TextStyle(color: Colors.white, fontSize: 10.00),
              ),
            ]),
            Row(
              children: [
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 16.00,
                  color: const Color(0XFF2CDA9D),
                  icon: Icon(
                    Icons.copy,
                  ),
                  onPressed: () => _copyPassword(context),
                ),
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 18.00,
                  color: const Color(0XFF2CDA9D),
                  icon: Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () => _deletePassword(context),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _deletePassword(context) async {
    final LocalAuthentication auth = LocalAuthentication();
    final isAuth = await auth.authenticate(
        authMessages: [
          AndroidAuthMessages(signInTitle: "Autenticacion", biometricHint: "")
        ],
        localizedReason: 'Por favor autenticate para eliminar contraseña',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
        ));
    if (isAuth)
      BlocProvider.of<GestionpasswordBloc>(context)
          .add(EliminarPassword(id: password.id));
  }

  void _copyPassword(BuildContext context) {
    FlutterClipboard.copy(password.decryptFernet(password.password))
        .then((value) {
      Fluttertoast.showToast(
        msg: "Copiado en portapaples",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
        backgroundColor: const Color(detalles),
        textColor: Colors.white,
        fontSize: 12,
      );
    });
  }

  void _auth(context) async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      final isLogin = await auth.authenticate(
          authMessages: [
            AndroidAuthMessages(signInTitle: "Autenticacion", biometricHint: "")
          ],
          localizedReason:
              'Por favor autenticate para ver la informacion de la contraseña',
          options: const AuthenticationOptions(
            useErrorDialogs: false,
          ));
      if (isLogin) {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => DetailPasswordPage(
              password: password,
            ),
          ),
        );
      }
      ;
    } on PlatformException {}
  }
}
