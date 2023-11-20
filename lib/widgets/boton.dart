import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final Function onTap;
  final String texto;
  final Color textColor;

  final Color color;

  const Boton({Key key, this.onTap, this.texto, this.color =Colors.white, this.textColor = Colors.black}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric( vertical: 10.00),
      child: MaterialButton(
        padding: EdgeInsets.all(18.00),
        minWidth: double.infinity,
        color: color,
        onPressed:onTap,
        child: Text(
          texto.toUpperCase(),
          style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}
