import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Cuerpo extends StatelessWidget {
  String password;
  String titulo;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Input(
            texto: "Titulo",
            onChange: onChageTitulo,
          ),
          Input(
            texto: "Password",
            onChange: onChagePassword,
          ),
          SizedBox(
            height: 10.00,
          ),
          Boton(
            texto: "Registrar contraseña",
            onTap: registrarPassword,
          )
        ],
      ),
    );
  }

  void registrarPassword(context) {
    BlocProvider.of<GestionpasswordBloc>(context).add(RegistrarPassword(
        password: Password(password: password, titulo: titulo)));
  }

  void onChagePassword(text) {
    password = text;
  }

  void onChageTitulo(text) {
    titulo = text;
  }
}
