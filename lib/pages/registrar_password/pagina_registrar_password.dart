import 'dart:math';

import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/pages/login/widgets/Input.dart';
import 'package:app/pages/registrar_password/RegistrarPasswordBloc/registrarpassword_bloc.dart';
import 'package:app/pages/registrar_password/widgets/barra_inferior.dart';
import 'package:app/pages/registrar_password/widgets/formulario.dart';
import 'package:app/pages/registrar_password/widgets/generador.dart';
import 'package:app/utils/ui.dart';
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
    'title': '',
    'cantidad': 0
  };
  final TextEditingController _textPasswordController = TextEditingController();

  String password;
  String title;
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
      body: BlocBuilder<RegistrarpasswordBloc, RegistrarpasswordState>(
        builder: (context, state) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: padding),
            child: Stack(children: [
              ListView(
                children: [
                  Formulario(
                      onChange: _validar,
                      controller: _textPasswordController,
                      validacion: state.inputs),
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
              ),
              Align(
                alignment: Alignment.topCenter,
                child: AnimatedContainer(
                    duration: Duration(
                      milliseconds: 500,
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: 20.00, vertical: 10.00),
                    padding: EdgeInsets.all(8.00),
                    height: 40.00,
                    width: state.width,
                    decoration: BoxDecoration(
                        color: Color(0xff2ecc71).withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5.00)),
                    child: Center(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 30.00,
                              width: 30.00,
                              decoration: BoxDecoration(
                                  color: Color(detalles).withOpacity(0.3),
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 20.00,
                              ),
                            ),
                            SizedBox(
                              width: 10.00,
                            ),
                            Text(
                              'Contraseña registrada',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    )),
              ),
            ]),
          );
        },
      ),
    );
  }

  void _validar(valor, input) {
    BlocProvider.of<RegistrarpasswordBloc>(context).add(Validar(
      valor: valor,
      input: input,
    ));
  }

  void _onChanged(valor, input) {
    setState(() {
      values[input] = valor;
    });
  }

  void _registrar() {
    BlocProvider.of<RegistrarpasswordBloc>(context)
        .add(Registrar(context: context));
  }

  void _generarPassword() {
    //https://stackoverflow.com/questions/11674820/how-do-i-generate-random-numbers-in-dart
    //https://api.dart.dev/stable/2.15.1/dart-math/Random-class.html
    //https://protocoderspoint.com/generate-random-number-dart-program/

    String passwordRandom = '';

    List caracteres = [
      'a',
      'b',
      'c',
      'd',
      'e',
      'f',
      'g',
      'h',
      'i',
      'j',
      'k',
      'l',
      'm',
      'n',
      'o',
      'p',
      'q',
      'r',
      's',
      't',
      'u',
      'v',
      'w',
      'x',
      'y',
      'z'
    ];

    const List mayusculas = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
      'P',
      'Q',
      'R',
      'S',
      'T',
      'U',
      'V',
      'W',
      'X',
      'Y',
      'Z'
    ];
    const List caracteres_especiales = [
      '!',
      '@',
      '#',
      '\$',
      '%',
      '^',
      '&',
      '*',
      '(',
      ')',
      '+',
      '{',
      '}',
      '[',
      ']'
    ];
    const List numeros = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

    if (values['mayuscula']) {
      caracteres.addAll(mayusculas);
    }
    if (values['numero']) {
      caracteres.addAll(numeros);
    }
    if (values['caracteres']) {
      caracteres.addAll(caracteres_especiales);
    }

    var random = Random();

    for (var i = 0; i < 12; i++) {
      final numeroRandom = random.nextInt(caracteres.length);

      passwordRandom += caracteres[numeroRandom];
    }

    _textPasswordController.text = passwordRandom;
    _validar(passwordRandom, 'password');
  }
}
