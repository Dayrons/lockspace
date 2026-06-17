import 'package:app/widgets/input.dart';
import 'package:flutter/material.dart';

class Formulario extends StatelessWidget {
  final Function(String, String)? onChange;
  final TextEditingController? controller;
  final Map<String, dynamic> validacion;

  const Formulario({super.key, this.onChange, this.controller, required this.validacion});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Input(
            input: 'title',
            texto: "title",
            validacion: validacion['title']?['validacion'] ?? true,
            onChange: onChange,
          ),
          Input(
            input: 'password',
            texto: "Password",
            validacion: validacion['password']?['validacion'] ?? true,
            controller: controller,
            onChange: onChange,
          ),
        ],
      ),
    );
  }
}
