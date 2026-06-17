import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String text;
  final double width;
  final dynamic Function(String, dynamic) onChanged;
  final bool value;
  final String input;

  SwitchWidget({super.key, required this.width, required this.text, required this.onChanged, required this.value, required this.input});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: const Color(0XFF2b2e3d).withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            text,
            style: const TextStyle(
                color: Color(0XFF2CDA9D),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Switch(
            value: value,
            activeColor: const Color(0XFF2CDA9D),
            onChanged: (bool newValue) {
              onChanged(input, newValue);
            },
          ),
        ],
      ),
    );
  }
}
