import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/pages/registrar_password/widgets/barra_inferior.dart';
import 'package:app/pages/registrar_password/widgets/formulario.dart';
import 'package:app/pages/registrar_password/widgets/generador.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaRegistrarPassword extends StatefulWidget {
  @override
  _PaginaRegistrarPasswordState createState() =>
      _PaginaRegistrarPasswordState();
}

class _PaginaRegistrarPasswordState extends State<PaginaRegistrarPassword> {
  Map values = {
    'mayuscula': false,
    'numero': false,
    'caracteres': false,
    'password': '',
    'titulo': ''
  };
  final TextEditingController _textPasswordController = TextEditingController();

  String password;
  String titulo;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
      body: Stack(children: [
        ListView(
          children: [
            Formulario(
              onChange: _onChanged,
              controller: _textPasswordController,
            ),
            Generador(
                onPressed: _generarPassword,
                onChanged: _onChanged,
                values: [
                  values['mayuscula'],
                  values['numero'],
                  values['caracteres']
                ])
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Align(
              alignment: Alignment.bottomCenter,
              child: BarraInferio(
                onTap: _registrar,
              )),
        )
      ]),
    );
  }

  void _onChanged(value, input) {
    setState(() {
      values[input] = value;
    });
  }

  void _registrar() {
    /* BlocProvider.of<GestionpasswordBloc>(context).add(RegistrarPassword(
        password: Password(password: password, titulo: titulo))); */
  }

  void _generarPassword() {
    setState(() {});
  }
}
