import 'package:app/widgets/check.dart';
import 'package:flutter/material.dart';

class Generador extends StatelessWidget {
  final dynamic Function(String, dynamic) onChanged;
  final List<bool> values;
  final VoidCallback? onPressed;

  const Generador({super.key, required this.onChanged, required this.values, this.onPressed});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 20.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generar Contraseña'.toUpperCase(),
              style:
                  const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'mayuscula',
              value: values[0],
              onChanged: onChanged,
              texto: 'Mayuscula',
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'numero',
              value: values[1],
              onChanged: onChanged,
              texto: 'Numeros',
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'caracteres',
              value: values[2],
              onChanged: onChanged,
              texto: 'Caracteres especiales',
            ),
            MaterialButton(
              color: const Color(0XFF2CDA9D),
              onPressed: onPressed,
              child: const Text(
                'Generar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
