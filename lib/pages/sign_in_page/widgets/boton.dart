import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final Function onTap;

  const Boton({Key key, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.00),
      child: MaterialButton(
        padding: EdgeInsets.all(18.00),
        minWidth: double.infinity,
        color: Color(0XFF2CDA9D),
        onPressed: () {
          onTap(context);
        },
        child: Text(
          "INICIAR SESION",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
