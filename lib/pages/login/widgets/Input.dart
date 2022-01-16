import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  final String text;
  final Function changePassword;

  const Input({Key key, this.text, this.changePassword}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0XFF2b2e3d).withOpacity(0.5),
        borderRadius: BorderRadius.circular(4.00),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
      child: TextFormField(
        onChanged: (text) {
          changePassword(text);
        },
        style: TextStyle(
            fontSize: 14.00, fontWeight: FontWeight.bold, color: Colors.white),
        cursorColor: Color(0XFF2CDA9D),
        decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.vpn_key_sharp,
            color: Colors.white,
            size: 18.00,
          ),
          border: InputBorder.none,
          hintStyle: TextStyle(color: Colors.white),
          hintText: '$text',
          contentPadding: EdgeInsets.all(20.00),
        ),
      ),
    );
  }
}
