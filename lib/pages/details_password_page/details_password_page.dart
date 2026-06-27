import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/slider_widget.dart';
import 'package:app/widgets/switch_widget.dart';
import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailPasswordPage extends StatefulWidget {
  const DetailPasswordPage({super.key});

  @override
  State<DetailPasswordPage> createState() => _DetailPasswordPageState();
}

class _DetailPasswordPageState extends State<DetailPasswordPage> {
  final TextEditingController _textTitleController = TextEditingController();
  final TextEditingController _textPasswordController = TextEditingController();
  late Password password;

  final Map<String, dynamic> _values = {
    'capital_letters': false,
    'numbers': false,
    'special_characters': false,
    'max_length': 8.00,
  };
  final Map<String, dynamic> newPasswordValues = {};
  @override
  void initState() {
    super.initState();
    password = BlocProvider.of<PasswordBloc>(context).state.password;
    _textTitleController.text = password.title;
    _textPasswordController.text = password.password;
  }

  bool validate = false;
  bool _isQrVisible = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return BlocBuilder<PasswordBloc, PasswordState>(
      builder: (context, state) {
        password = state.password;
        return Scaffold(
            backgroundColor: const Color(0XFF1c1d22),
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              backgroundColor: const Color(0XFF1c1d22),
              elevation: 0,
              title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(),
                    Container(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 10,
                            height: 10,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: _detailDateTime(password)["color"],
                              shape: BoxShape.circle,
                            ),
                          ),
                          Text(
                            "Actualizacion hace: ${_detailDateTime(password)["date"]} a las ${_detailDateTime(password)["hour"]}",
                            style: TextStyle(
                                color: _detailDateTime(password)["color"],
                                fontSize: 12),
                          )
                        ],
                      ),
                    )
                  ]),
              leading: IconButton(
                iconSize: 40,
                icon: const Icon(
                  Icons.navigate_before,
                  color: Color(0XFF2CDA9D),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: BlocListener<PasswordBloc, PasswordState>(
              listener: (context, state) {
                if (state.updateSuccess) {
                  Fluttertoast.showToast(
                    msg: "Contraseña actualizada",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 3,
                    backgroundColor: const Color(detalles),
                    textColor: Colors.white,
                    fontSize: 12,
                  );
                }
                if (state.updateError) {
                  Fluttertoast.showToast(
                    msg: "Error al actualziar contraseña",
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
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _isQrVisible = !_isQrVisible;
                                      });
                                    },
                                    child: Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: QrImageView(
                                            data: password.password,
                                            backgroundColor: Colors.white,
                                            version: QrVersions.auto,
                                            size: 160.0,
                                          ),
                                        ),
                                        if (!_isQrVisible)
                                          Container(
                                            width: 160.0,
                                            height: 160.0,
                                            decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withValues(alpha: 0.95),
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Icon(
                                                Icons.visibility,
                                                color: Colors.white,
                                                size: 40,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 20.00),
                                  Input(
                                    input: 'title',
                                    texto: "Titulo",
                                    validacion: true,
                                    controller: _textTitleController,
                                    onChange: (value, input) {
                                      newPasswordValues[input] = value;
                                    },
                                  ),
                                  Input(
                                      input: 'password',
                                      texto: "Nueva contraseña",
                                      validacion: true,
                                      controller: _textPasswordController,
                                      onChange: (value, input) {
                                        newPasswordValues[input] = value;
                                      }),
                                  SliderWidget(
                                    text: "Cantidad maxima de caracteres",
                                    width: size.width,
                                    input: 'max_length',
                                    onChanged: _onChanged,
                                    value: _values['max_length'] as double,
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
                                        value: _values['special_characters'] as bool,
                                      ),
                                      SwitchWidget(
                                        width: size.width * 0.42,
                                        text: "Mayusculas",
                                        onChanged: _onChanged,
                                        input: 'capital_letters',
                                        value: _values['capital_letters'] as bool,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SwitchWidget(
                                        width: size.width * 0.42,
                                        text: "Numeros",
                                        onChanged: _onChanged,
                                        input: 'numbers',
                                        value: _values['numbers'] as bool,
                                      ),
                                      Boton(
                                        width: size.width * 0.42,
                                        color: const Color(0XFF2CDA9D),
                                        textColor: Colors.white,
                                        texto: "Generar",
                                        onTap: _generatePassword,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                ])),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Boton(
                            width: size.width,
                            texto: "Actualizar contraseña",
                            onTap: () {
                              password.title = _textTitleController.text;
                              password.password = _textPasswordController.text;
                              BlocProvider.of<PasswordBloc>(context).updatePassword(state.password);
                              FlutterClipboard.copy(password.password);
                            }),
                      )
                    ],
                  )),
            ));
      },
    );
  }

  void _onChanged(dynamic input, dynamic newValue) {
    setState(() {
      _values[input as String] = newValue;
    });
  }

  void _generatePassword() {
    final String newPassword = generarPassword(_values);
    _textPasswordController.text = newPassword;
    newPasswordValues['password'] = newPassword;
  }

  Map _detailDateTime(Password password) {
    DateTime date = password.updatedAt;

    final DateTime now = DateTime.now();
    final Duration difference = now.difference(date);

    Color color;
    if (difference.inDays <= 90) {
      color = const Color(detalles);
    } else if (difference.inDays > 90 && difference.inDays <= 150) {
      color = Colors.amber;
    } else {
      color = Colors.red[400]!;
    }

    return {
      "date": "${date.day}-${date.month}-${date.year}",
      "hour":
          "${date.hour > 12 ? date.hour - 12 : date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}",
      "color": color
    };
  }
}
