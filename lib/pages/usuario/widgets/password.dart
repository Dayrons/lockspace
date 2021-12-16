import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  final String password;
  final String titulo;

  const Password({Key key, this.password, this.titulo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 10.00),
      padding: EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
      decoration: BoxDecoration(
        color: Color(0XFF2b2e3d),
        borderRadius: BorderRadius.circular(15),
        /* border: Border(
            bottom: BorderSide(
                width: 2.00,
                style: BorderStyle.solid,
                color: Color(0XFF393939)),
          ) */
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.lock,
            color: Colors.white,
          ),
          Column(children: [
            Text(
              "$titulo",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.00),
            ),
            SizedBox(
              height: 5.00,
            ),
            Text(
              "password",
              style: TextStyle(color: Colors.white, fontSize: 10.00),
            ),
          ]),
          Icon(
            Icons.lock,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
