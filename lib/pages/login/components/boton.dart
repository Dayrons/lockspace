import 'package:app/bloc/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Boton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.00),
      child: FlatButton(
        padding: EdgeInsets.all(18.00),
        minWidth: double.infinity,
        color: Color(0XFF2CDA9D),
        onPressed: () {

            BlocProvider.of<LoginBloc>(context).add(Sigin());
        },
        child: Text(
          "INICIAR SESION",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
