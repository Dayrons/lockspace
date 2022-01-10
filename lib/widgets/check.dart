import 'package:flutter/material.dart';

class Check extends StatelessWidget {
  final double width;
  final bool value;
  final String texto;
  final String input;
  final Function onChanged;

  const Check(
      {Key key, this.width, this.value, this.onChanged, this.texto, this.input})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.00),
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.00),
        color: Color(0XFF2b2e3d).withOpacity(0.5),
      ),
      child: CheckboxListTile(
        activeColor: const Color(0XFF2CDA9D),
        onChanged: (
          bool value,
        ) {
          onChanged(value, input);
        },
        value: value,
        title: Text(
          texto,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
