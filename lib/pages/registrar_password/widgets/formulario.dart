import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  final Function onChange;
  final TextEditingController controller;
  final Map validacion;

  const Formulario({Key key, this.onChange, this.controller, this.validacion})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            input: 'titulo',
            texto: "Titulo",
            validacion: validacion['titulo']['validacion'],
            onChange: onChange,
          ),
          Input(
            input: 'password',
            texto: "Password",
            validacion: validacion['password']['validacion'],
            controller: controller,
            onChange: onChange,
          ),
          /* Input(
            input: 'cantidad',
            texto: "Cantidad de caracteres",
            onChange: onChange,
          ), */
        ],
      ),
    );
  }
}
