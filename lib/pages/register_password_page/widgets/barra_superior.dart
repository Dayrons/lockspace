import 'package:flutter/material.dart';

class BarraSuperiro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60.00,
      color: Color(0XFF23272A),
      child: Row(
        children: [
          IconButton(
            splashRadius: 30.00,
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_outlined,
              size: 32.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
