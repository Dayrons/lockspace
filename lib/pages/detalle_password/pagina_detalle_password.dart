import 'package:flutter/material.dart';

class PaginaDetallePassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      appBar: AppBar(
        backgroundColor: Color(0XFF1c1d22),
        elevation: 0,
        leading: IconButton(
          iconSize: 40,
          icon: Icon(
            Icons.navigate_before,
            color: const Color(0XFF2CDA9D),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
