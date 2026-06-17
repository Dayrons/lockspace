import 'package:app/widgets/boton.dart';
import 'package:flutter/material.dart';

class BarraInferio extends StatelessWidget {
  final VoidCallback? onTap;

  const BarraInferio({super.key, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Boton(
      texto: "Registrar contraseña",
      onTap: onTap,
    );
  }
}
