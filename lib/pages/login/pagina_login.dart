import 'package:app/bloc/AuthBloc/login_bloc.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/pages/login/widgets/Input.dart';
import 'package:app/pages/login/widgets/boton.dart';
import 'package:flutter/material.dart';

//QUE MUESTRE UNA PANTALLA LA PRIMERA VEZ QUE SE INICIE LA APP
//https://es.stackoverflow.com/questions/3243/saber-cuando-la-app-es-lanzada-por-primera-vez-en-android

class PaginaLogin extends StatelessWidget {
  String password;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is Logeado) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => PaginaInicio()),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0XFF1c1d22),
        body: Center(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/logo.png",
                  height: 180.00,
                  width: 180.00,
                ),
                Text(
                  "Manten tus contraseñas en un solo lugar, encriptadas y seguras",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.00),
                ),
                SizedBox(
                  height: 20.00,
                ),
                Input(
                  text: "Contraseña",
                  changePassword: changePassword,
                ),
                Boton(
                  onTap: siging,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void siging(context) {
    BlocProvider.of<LoginBloc>(context).add(Sigin(password: password));
  }

  void changePassword(text) {
    password = text;
  }
}
