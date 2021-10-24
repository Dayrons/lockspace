import 'package:flutter/material.dart';

class Password extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
            width: 2.00, style: BorderStyle.solid, color: Color(0XFF393939)),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            Icons.lock,
            color: Colors.white,
          ),
          Text(
            "password",
            style: TextStyle(color: Colors.white),
          ),
          Icon(
            Icons.lock,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
