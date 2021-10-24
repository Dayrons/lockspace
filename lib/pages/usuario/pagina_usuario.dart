import 'package:app/pages/usuario/widgets/password.dart';
import 'package:flutter/material.dart';

class PaginaUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF23272A),
      appBar: AppBar(
        backgroundColor: Color(0XFF23272A),
      ),
      body: ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Password();
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF2CDA9D),
        onPressed: () {},
      ),
    );
  }
}
