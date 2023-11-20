import 'package:flutter/cupertino.dart';

const int fondo = 0XFF1c1d22;
const int detalles = 0XFF2CDA9D;

const double padding = 20.00;



double getHorizontalSpace(BuildContext context) {
  final Size size  = MediaQuery.of(context).size;
  return size.width < 360 ? 10.00 : 20.00;
}
