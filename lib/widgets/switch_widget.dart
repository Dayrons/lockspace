import 'package:flutter/material.dart';

class SwitchWidget extends StatelessWidget {
  final String text;
  final double width;
  final Function onChanged;
  final bool value;
  final String input;

  SwitchWidget({this.width, this.text, this.onChanged, this.value, this.input, Key key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0XFF2b2e3d).withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            text,
            style: TextStyle(
                color: Color(0XFF2CDA9D),
                fontWeight: FontWeight.bold,
                fontSize: 12),
          ),
          Switch(
            value: value,
            activeColor: Color(0XFF2CDA9D),
            onChanged: (bool newValue) {
              onChanged(input,newValue);
            },
          ),
        ],
      ),
    );
  }
}
