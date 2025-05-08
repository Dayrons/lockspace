import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
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

class Password extends StatelessWidget {
  final int id;
  final String password;
  final String title;
  final List<Function> funciones;

  const Password({Key key, this.id, this.password, this.title, this.funciones})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () async {
        final LocalAuthentication auth = LocalAuthentication();
        try {
          final bool canAuthenticateWithBiometrics =
              await auth.canCheckBiometrics;
          final bool canAuthenticate =
              canAuthenticateWithBiometrics || await auth.isDeviceSupported();
          final isLogin = await auth.authenticate(
              authMessages: [
                AndroidAuthMessages(
                    signInTitle: "Autenticacion", biometricHint: "")
              ],
              localizedReason:
                  'Por favor autenticate para ver la informacion de la contraseña',
              options: const AuthenticationOptions(
                useErrorDialogs: false,
              ));
          if (isLogin) {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              builder: (BuildContext context) {
                return Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: size.height * 0.8,
                  decoration: BoxDecoration(
                    color: Color(fondo),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(20),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                          top: 10,
                          left: 0,
                          child: Container(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 10,
                                  height: 10,
                                  margin: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.amber,
                                      shape: BoxShape.circle),
                                ),
                                Text(
                                  "Actualizacion hace: ${"3 meses"} ",
                                  style: TextStyle(color: Colors.amber),
                                )
                              ],
                            ),
                          )),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 20.00,
                            ),
                            Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: QrImage(
                                data: password,
                                backgroundColor: Colors.white,
                                version: QrVersions.auto,
                                size: 160.0,
                              ),
                            ),
                            SizedBox(
                              height: 20.00,
                            ),
                            Input(
                              input: 'password',
                              texto: "Nueva contraseña",
                              validacion: true,
                              // controller: controller,
                              onChange: () {},
                            ),
                            Boton(
                              width: size.width,
                              texto: "Actualizar contraseña",
                              onTap: () {},
                            ),
                          ])
                    ],
                  ),
                );
              },
            );
          }
        } on PlatformException {}
      },
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
                "$title",
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
                  onPressed: () {
                    FlutterClipboard.copy(password).then((value) {
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
                  },
                ),
                IconButton(
                  splashRadius: 20.00,
                  iconSize: 18.00,
                  color: const Color(0XFF2CDA9D),
                  icon: Icon(
                    Icons.delete_outline,
                  ),
                  onPressed: () async {
                    final LocalAuthentication auth = LocalAuthentication();
                    final isAuth = await auth.authenticate(
                        authMessages: [
                          AndroidAuthMessages(
                              signInTitle: "Autenticacion", biometricHint: "")
                        ],
                        localizedReason:
                            'Por favor autenticate para eliminar contraseña',
                        options: const AuthenticationOptions(
                          useErrorDialogs: false,
                        ));
                    if (isAuth)
                      BlocProvider.of<GestionpasswordBloc>(context)
                          .add(EliminarPassword(id: id));
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
