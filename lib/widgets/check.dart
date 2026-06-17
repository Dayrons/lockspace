import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  final double width;
  final bool value;
  final String texto;
  final String input;
  final dynamic Function(String, dynamic) onChanged;

  const Check({
    super.key,
    this.width = 200,
    this.value = false,
    required this.onChanged,
    required this.texto,
    required this.input,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10.00),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.00),
        color: const Color(0XFF2b2e3d).withOpacity(0.5),
      ),
      child: CheckboxListTile(
        activeColor: const Color(0XFF2CDA9D),
        onChanged: (bool? value) {
          onChanged(input, value);
        },
        value: value,
        title: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
