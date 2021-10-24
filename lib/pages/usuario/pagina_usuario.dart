import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/pages/registrar_password/pagina_registrar_password.dart';
import 'package:app/pages/usuario/widgets/password.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaUsuario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    init(context);
    return Scaffold(
      backgroundColor: Color(0XFF23272A),
      appBar: AppBar(
        backgroundColor: Color(0XFF23272A),
      ),
      body: BlocBuilder<GestionpasswordBloc, GestionpasswordState>(
        builder: (context, state) {
          if (state is PasswordsObtenidas) {
            return ListView.builder(
              itemCount: state.passwords.length,
              itemBuilder: (BuildContext context, int index) {
                var password = state.passwords[index];

                return Password(
                  titulo: password.titulo,
                  password: password.password,
                );
              },
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 2.00,
            ));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF2CDA9D),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute<Null>(
              builder: (BuildContext context) => PaginaRegistrarPassword()));
        },
      ),
    );
  }

  void init(BuildContext context) {
    BlocProvider.of<GestionpasswordBloc>(context).add(ObtenerPasswords());
  }
}
