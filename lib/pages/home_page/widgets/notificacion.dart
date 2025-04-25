import 'package:flutter/material.dart';

class Notificacion extends StatelessWidget {
  final double opacidad;
  const Notificacion({Key key, this.opacidad}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 400),
      opacity: opacidad,
      child: Container(
        decoration: BoxDecoration(
            color: Color(0XFFfca06d).withOpacity(0.7),
            borderRadius: BorderRadius.circular(10.00)),
        child: Row(
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
