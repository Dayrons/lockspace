import 'package:flutter/material.dart';

class SwitchWidget extends StatefulWidget {
  final String text;
  final double width;

  SwitchWidget({this.width, this.text, Key key}) : super(key: key);

  @override
  State<SwitchWidget> createState() => _SwitchWidgetState();
}

class _SwitchWidgetState extends State<SwitchWidget> {
  bool value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Color(0XFF2b2e3d).withOpacity(0.5),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            widget.text,
            style: TextStyle(color: Color(0XFF2CDA9D), fontWeight: FontWeight.bold, fontSize: 12),
          ),
          Switch(
            value: value,
            activeColor: Color(0XFF2CDA9D),
            onChanged: (bool newValue) {
              setState(() {
          value = newValue;
              });
            },
          ),
        ],
      ),
    );
  }
}
