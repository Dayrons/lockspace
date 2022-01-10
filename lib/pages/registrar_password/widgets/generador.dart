import 'package:app/widgets/check.dart';
import 'package:flutter/material.dart';

class Generador extends StatelessWidget {
  final Function onChanged;
  final List values;
  final Function onPressed;

  const Generador({Key key, this.onChanged, this.values, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 20.00, vertical: 20.00),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Generar Contraseña'.toUpperCase(),
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'mayuscula',
              value: values[0],
              onChanged: onChanged,
              texto: 'Mayuscula',
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'numero',
              value: values[1],
              onChanged: onChanged,
              texto: 'Numeros',
            ),
            Check(
              width: (size.width * 50) / 100,
              input: 'caracteres',
              value: values[2],
              onChanged: onChanged,
              texto: 'Caracteres especiales',
            ),
            MaterialButton(
              color: Color(0XFF2CDA9D),
              onPressed: () {
                onPressed();
              },
              child: Text(
                'Generar',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ));
  }
}
