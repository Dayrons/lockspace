import 'package:app/bloc/AuthBloc/auth_bloc.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:app/pages/sign_in_page/widgets/Input.dart';
import 'package:app/pages/sign_in_page/widgets/boton.dart';
import 'package:flutter/material.dart';

//QUE MUESTRE UNA PANTALLA LA PRIMERA VEZ QUE SE INICIE LA APP
//https://es.stackoverflow.com/questions/3243/saber-cuando-la-app-es-lanzada-por-primera-vez-en-android

class SignInPage extends StatelessWidget {
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  text: "Usuario",
                  changePassword: changePassword,
                ),
                Input(
                  text: "Contraseña",
                  changePassword: changePassword,
                ),
                Boton(
                  onTap: _signIn,
                ),
              ],
            ),
          ),
        ),
      );
  }

  void _signIn(context) {
  //  BlocProvider.of<AuthBloc>(context).signIn();
  }

  void changePassword(text) {
    password = text;
  }
}
