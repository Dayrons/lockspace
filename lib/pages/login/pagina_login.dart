import 'package:app/pages/login/components/Input.dart';
import 'package:app/pages/login/components/boton.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Input(),
              Input(),
              Boton(),
            ],
          ),
        ),
      ),
    );
  }
}
