import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/pages/details_password_page/details_password_page.dart';
import 'package:app/utils/ui.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PasswordWidget extends StatelessWidget {
  final Password password;

  const PasswordWidget({super.key, required this.password});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _auth(context, () {
          _viewPassword(context);
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10.00),
        padding: const EdgeInsets.symmetric(horizontal: 15.00, vertical: 5.00),
        decoration: BoxDecoration(
          color: const Color(0XFF2b2e3d).withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                password.title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.00),
              ),
              const SizedBox(height: 5.00),
              Text(
                "password".toUpperCase(),
                style: const TextStyle(color: Colors.white, fontSize: 10.00),
              ),
            ]),
            Row(
              children: [
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 16.00,
                  color: const Color(0XFF2CDA9D),
                  icon: const Icon(Icons.copy),
                  onPressed: () => _copyPassword(context),
                ),
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 18.00,
                  color: const Color(0XFF2CDA9D),
                  icon: const Icon(Icons.delete_outline),
                  onPressed: () => _auth(context, () {
                    _deletePassword(context);
                  }),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _viewPassword(BuildContext context) {
    BlocProvider.of<PasswordBloc>(context).selectPassword(password);
    Navigator.of(context).push(
      CupertinoPageRoute(
        builder: (context) => const DetailPasswordPage(),
      ),
    );
  }

  void _deletePassword(BuildContext context) {
    BlocProvider.of<PasswordBloc>(context).removePassword(password);
  }

  void _copyPassword(BuildContext context) {
    FlutterClipboard.copy(password.password).then((value) {
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

  void _auth(BuildContext context, VoidCallback function) async {
    try {
      final LocalAuthentication auth = LocalAuthentication();
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool isDeviceSupported = await auth.isDeviceSupported();

      if (canAuthenticateWithBiometrics || isDeviceSupported) {
        final isAuth = await auth.authenticate(
          authMessages: const [
            AndroidAuthMessages(signInTitle: "Authentication", signInHint: "")
          ],
          localizedReason: 'Por favor autentica para continuar',
        );
        if (isAuth) {
          function();
        }
      } else {
        // Si no hay biometría disponible, permite la acción
        // (el usuario ya se autenticó con contraseña al hacer login)
        function();
      }
    } catch (e) {
      // Si hay algún error con la biometría, permite la acción
      // (el usuario ya se autenticó con contraseña al hacer login)
      function();
    }
  }
}
