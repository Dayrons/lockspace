import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String texto;
  final String input;
  final bool obscureText;
  final bool validacion;
  final Function(String, String)? onChange;
  final TextEditingController? controller;
  const Input({
    super.key,
    required this.texto,
    required this.onChange,
    required this.input,
    this.controller,
    this.obscureText = false,
    this.validacion = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.00),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              texto,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14.00),
            ),
            const SizedBox(height: 10.00),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5.00),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.00),
                color: validacion
                    ? const Color(0XFF2b2e3d).withOpacity(0.5)
                    : const Color(0XFFff6b6b).withOpacity(0.3),
              ),
              child: TextFormField(
                obscureText: obscureText,
                style: const TextStyle(color: Colors.white),
                controller: controller,
                cursorColor: const Color(0XFF2CDA9D),
                decoration: const InputDecoration(border: InputBorder.none),
                onChanged: (value) {
                  onChange?.call(value, input);
                },
              ),
            ),
          ]),
    );
  }
}
