import 'package:app/models/Usuario.dart';
import 'package:app/pages/login/components/Input.dart';
import 'package:app/pages/login/components/boton.dart';
import 'package:flutter/material.dart';

class PaginaLogin extends StatelessWidget {
  @override
  
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xFF000000),
      body: Center(
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/logo.png", height: 180.00, width: 180.00,),
              Text(
                "Manten tus contraseñas en un solo lugar, encriptadas y seguras",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 18.00),
              ),
              SizedBox(height: 20.00,),
              Input(
                text: "Contraseña",
              ),
              Boton(),
            ],
          ),
        ),
      ),
    );
  }


 
}
