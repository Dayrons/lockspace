import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  final Function onChange;
  final TextEditingController controller;

  const Formulario({Key key, this.onChange, this.controller}) : super(key: key);

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
            onChange: onChange,
          ),
          Input(
            input: 'password',
            texto: "Password",
            controller: controller,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}
