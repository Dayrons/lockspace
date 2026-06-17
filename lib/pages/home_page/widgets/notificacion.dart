import 'package:flutter/material.dart';

class Notificacion extends StatelessWidget {
  final double opacidad;
  const Notificacion({super.key, required this.opacidad});
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: opacidad,
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0XFFfca06d).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.00)),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.check,
              size: 16,
              color: Colors.black,
            ),
            Text(
              'copiado',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
