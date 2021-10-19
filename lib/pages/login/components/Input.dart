import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text;

  const Input({Key key, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.00),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
      child: TextFormField(
        style: TextStyle(fontSize: 14.00, fontWeight: FontWeight.bold),
        cursorColor: Color(0XFF2CDA9D),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key_sharp,
            color: Colors.black38,
            size: 18.00,
          ),
          border: InputBorder.none,
          hintText: '$text',
          contentPadding: EdgeInsets.all(20.00),
        ),
      ),
    );
  }
}
