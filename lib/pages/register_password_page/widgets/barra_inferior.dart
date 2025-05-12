import 'package:app/widgets/boton.dart';
import 'package:flutter/material.dart';

class BarraInferio extends StatelessWidget {
  final Function onTap;

  const BarraInferio({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Boton(
      texto: "Registrar contraseña",
      onTap: onTap,
    );
  }
}
