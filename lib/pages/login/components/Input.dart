import 'package:flutter/material.dart';

class Input extends StatelessWidget {
  const Input({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.00),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 15.00),
      child: TextFormField(
        decoration: InputDecoration(border: InputBorder.none),
      ),
    );
  }
}
