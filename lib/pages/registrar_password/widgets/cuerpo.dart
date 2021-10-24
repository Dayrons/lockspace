import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';

class Cuerpo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Input(texto: "Titulo"),
          Input(texto: "Password"),
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

  void registrarPassword(context) {}
}
