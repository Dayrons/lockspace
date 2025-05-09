import 'package:app/models/Password.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/input.dart';
import 'package:app/widgets/slider_widget.dart';
import 'package:app/widgets/switch_widget.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class DetailPasswordPage extends StatefulWidget {
  final Password password;
  const DetailPasswordPage({Key key, this.password}) : super(key: key);

  @override
  State<DetailPasswordPage> createState() => _DetailPasswordPageState();
}

class _DetailPasswordPageState extends State<DetailPasswordPage> {
  final TextEditingController _textTitleController = TextEditingController();

  bool _isQrVisible = false;
  @override
  void initState() {
    _textTitleController.text = widget.password.title;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Color(0XFF1c1d22),
        elevation: 0,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          SizedBox(),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                      color: Colors.amber, shape: BoxShape.circle),
                ),
                Text(
                  "Actualizacion hace: ${"3 meses"} ",
                  style: TextStyle(color: Colors.amber, fontSize: 12),
                )
              ],
            ),
          )
        ]),
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
      body: Container(
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
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: QrImage(
                                    data: widget.password.decryptFernet(
                                        widget.password.password),
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
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
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
                          SizedBox(
                            height: 20.00,
                          ),
                          Input(
                            input: 'title',
                            texto: "Titulo",
                            validacion: true,
                            controller: _textTitleController,
                            onChange: () {},
                          ),
                          Input(
                            input: 'password',
                            texto: "Nueva contraseña",
                            validacion: true,
                            // controller: controller,
                            onChange: () {},
                          ),
                          SliderWidget(
                            text: "Cantidad maxima de caracteres",
                            width: size.width,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SwitchWidget(
                                width: size.width * 0.42,
                                text: "Caracteres",
                              ),
                              SwitchWidget(
                                width: size.width * 0.42,
                                text: "Mayusculas",
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SwitchWidget(
                                width: size.width * 0.42,
                                text: "Numeros",
                              ),
                              Boton(
                                width: size.width * 0.42,
                                color: Color(0XFF2CDA9D),
                                textColor: Colors.white,
                                texto: "Generar",
                                onTap: () {},
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
                  texto: "Actualizar contraseña",
                  onTap: () {},
                ),
              )
            ],
          )),
    );
  }
}
