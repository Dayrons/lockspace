import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final VoidCallback? onTap;
  final String texto;
  final Color textColor;
  final double width;
  final Color color;

  const Boton({super.key, this.onTap, required this.texto, this.color = Colors.white, this.textColor = Colors.black, this.width = 200});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.00),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(5.00),
          width: width,
          height: 55,
          decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10))
          ),
          child: Center(child: Text(
            texto.toUpperCase(),
            style: TextStyle(color: textColor, fontWeight: FontWeight.bold, fontSize: 14),
          )),
        ),
        onTap: onTap,
      ),
    );
  }
}
