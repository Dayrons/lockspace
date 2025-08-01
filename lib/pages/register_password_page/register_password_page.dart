import 'dart:math';
import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/utils/functions.dart';

import 'package:app/utils/ui.dart';
import 'package:app/widgets/%20expiration_selector_widget.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/slider_widget.dart';
import 'package:app/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app/widgets/input.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPasswordPage extends StatefulWidget {
  @override
  _RegisterPasswordPageState createState() => _RegisterPasswordPageState();
}

class _RegisterPasswordPageState extends State<RegisterPasswordPage> {
  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _expirationController = TextEditingController();

  final Map<String, dynamic> _values = {
    'capital_letters': false,
    'numbers': false,
    'special_characters': false,
    'max_length': 8.00,
    'expiration_unit': 'never',
    'expiration': 0,
  };

  final Map<String, dynamic> registerValues = {};

  bool validate = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color(0XFF1c1d22),
        resizeToAvoidBottomInset: false,
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
          title: Text(
            "Nueva contraseña",
            style: TextStyle(fontSize: 18),
          ),
        ),
        body: BlocListener<PasswordBloc, PasswordState>(
          listener: (context, state) {
            if (state.registerSuccess) {
              Fluttertoast.showToast(
                msg: "Contraseña registrada",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: const Color(detalles),
                textColor: Colors.white,
                fontSize: 12,
              );
            }
            if (state.registerError) {
              Fluttertoast.showToast(
                msg: "Error al registrar contraseña",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 3,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 12,
              );
            }
          },
          child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: getHorizontalSpace(context), vertical: 20.00),
              child: Stack(
                children: [
                  Container(
                    height: size.height * 0.75,
                    child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Input(
                                input: 'title',
                                texto: "Titulo",
                                validacion: true,
                                controller: _textTitleController,
                                onChange: (value, input) {
                                  // _validate();
                                  registerValues[input] = value;
                                },
                              ),
                              Input(
                                  input: 'password',
                                  texto: "Contraseña",
                                  validacion: true,
                                  controller: _passwordController,
                                  onChange: (value, input) {
                                    registerValues[input] = value;
                                  }),
                              SizedBox(height: 16),
                              ExpirationSelectorWidget(
                                  text: "Expiración",
                                  valueExpiration: _values["expiration"],
                                  valueExpirationUnit:
                                      _values["expiration_unit"],
                                  inputExpiration: "expiration",
                                  inputExpirationUnit: "expiration_unit",
                                  onChanged: _onChanged,
                                  controller: _expirationController),
                              SizedBox(height: 16),
                              SliderWidget(
                                text: "Cantidad maxima de caracteres",
                                width: size.width,
                                input: 'max_length',
                                onChanged: _onChanged,
                                value: _values['max_length'],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SwitchWidget(
                                    width: size.width * 0.42,
                                    text: "Caracteres",
                                    onChanged: _onChanged,
                                    input: 'special_characters',
                                    value: _values['special_characters'],
                                  ),
                                  SwitchWidget(
                                    width: size.width * 0.42,
                                    text: "Mayusculas",
                                    onChanged: _onChanged,
                                    input: 'capital_letters',
                                    value: _values['capital_letters'],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SwitchWidget(
                                    width: size.width * 0.42,
                                    text: "Numeros",
                                    onChanged: _onChanged,
                                    input: 'numbers',
                                    value: _values['numbers'],
                                  ),
                                  Boton(
                                    width: size.width * 0.42,
                                    color: Color(0XFF2CDA9D),
                                    textColor: Colors.white,
                                    texto: "Generar",
                                    onTap: _generatePassword,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                            ])),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Boton(
                      width: size.width,
                      texto: "Registrar contraseña",
                      onTap: () {
                        BlocProvider.of<PasswordBloc>(context).addPassword(
                          Password(
                            title: registerValues['title'],
                            password: registerValues['password'],
                            expiration: registerValues['expiration'],
                            expirationUnit: registerValues["expiration_unit"]
                          ),
                        );
                      },
                    ),
                  )
                ],
              )),
        ));
  }

  void _validar(valor, input) {}

  void _onChanged(input, newValue) {
    setState(() {
      _values[input] = newValue;
    });
  }

  void _generatePassword() {
    final String randomPassword = generarPassword(_values);
    _passwordController.text = randomPassword;
    registerValues['password'] = randomPassword;
  }
}
