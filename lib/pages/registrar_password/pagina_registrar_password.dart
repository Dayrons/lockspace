import 'package:app/pages/registrar_password/widgets/barra_superior.dart';
import 'package:app/pages/registrar_password/widgets/cuerpo.dart';
import 'package:flutter/material.dart';

class PaginaRegistrarPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF23272A),
      appBar: AppBar(
        toolbarHeight: 0,
        backgroundColor: Color(0XFF23272A),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            BarraSuperiro(),
            Cuerpo(),
          ],
        ),
      ),
    );
  }
}
