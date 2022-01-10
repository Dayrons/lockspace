import 'package:flutter/material.dart';

class Boton extends StatelessWidget {
  final Function onTap;
  final String texto;

  const Boton({Key key, this.onTap, this.texto}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.00),
      child: FlatButton(
        padding: EdgeInsets.all(18.00),
        minWidth: double.infinity,
        color: Colors.white,
        onPressed: () {
          onTap();
        },
        child: Text(
          texto,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
