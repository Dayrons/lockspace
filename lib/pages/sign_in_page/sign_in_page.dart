import 'package:app/bloc/AuthBloc/auth_bloc.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/check.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

//QUE MUESTRE UNA PANTALLA LA PRIMERA VEZ QUE SE INICIE LA APP
//https://es.stackoverflow.com/questions/3243/saber-cuando-la-app-es-lanzada-por-primera-vez-en-android

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final Map values = {
    'name': '',
    'password': '',
    'sesion': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSignInState) {
            if (state.isLoading == false && !state.isError) {
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(
                      builder: (BuildContext context) => HomePage()),
                  (Route<dynamic> route) => false);
            }
            if (state.isError) {
              Fluttertoast.showToast(
                msg: state.errorMessage,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 12,
              );
            }
          }
        },
        child: Center(
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: padding),
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
                    texto: 'Usuario',
                    input: 'name',
                    obscureText: false,
                    validacion: true,
                    onChange: _onChanged,
                  ),
                  Input(
                    texto: 'Password',
                    input: 'password',
                    obscureText: true,
                    validacion: true,
                    onChange: _onChanged,
                  ),
                  Check(
                    texto: 'Mantener sesion activa',
                    input: 'sesion',
                    value: values['sesion'],
                    onChanged: _onChanged,
                  ),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      if (state is AuthSignInState) {
                        if (state.isLoading) {
                          return CircularProgressIndicator();
                        }
                      }
                      return Boton(
                        texto: 'Iniciar',
                        color: Color(detalles),
                        textColor: Colors.white,
                        onTap: _signIn,
                      );
                    },
                  )
                ],
              )),
        ),
      ),
    );
  }

  void _onChanged(value, input) {
    setState(() {
      values[input] = value;
    });
  }

  void _signIn() {
    BlocProvider.of<AuthBloc>(context).signIn(values);
  }
}
