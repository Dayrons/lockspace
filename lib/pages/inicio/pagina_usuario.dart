import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/pages/inicio/widgets/notificacion.dart';
import 'package:app/pages/registrar_password/pagina_registrar_password.dart';
import 'package:app/pages/inicio/widgets/password.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaInicio extends StatefulWidget {
  @override
  _PaginaInicioState createState() => _PaginaInicioState();
}

class _PaginaInicioState extends State<PaginaInicio> {
  double opacidad = 0;

  @override
  void initState() {
    super.initState();
    init(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0XFF1c1d22),
      endDrawer: Container(
        padding: EdgeInsets.only(bottom: 20),
        color: Color(fondo),
        width: MediaQuery.of(context).size.width * 0.6,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    leading: Icon(Icons.delete, color: Colors.white),
                    title: Text(
                      'eliminar contraseñas',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.settings, color: Colors.white),
                    title: Text(
                      'Configuracion',
                      style: TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Cerrar sesion',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            "Mis contraseñas",
            style: const TextStyle(
              fontSize: 18.00,
            ),
          ),
        ),
        backgroundColor: Color(0XFF1c1d22),
      ),
      body: BlocBuilder<GestionpasswordBloc, GestionpasswordState>(
          builder: (context, state) {
        if (state.obteniendoPassword) {
          return Text('Obteniendo password');
        } else {
          if (state.passwords.length > 0) {
            return Stack(children: [
              ListView.builder(
                itemCount: state.passwords.length,
                itemBuilder: (BuildContext context, int index) {
                  final password = state.passwords[index];
                  return Password(
                    titulo: password.titulo,
                    password: password.decryptFernet(password.password),
                    funcion: _notificacion,
                  );
                },
              ),
              Positioned(
                top: 10.00,
                left: size.width / 2 - 120.00 / 2,
                width: 120.00,
                height: 35.00,
                child: Notificacion(opacidad: opacidad),
              ),
            ]);
          } else {
            return SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/4.png',
                    width: 140,
                  ),
                  SizedBox(
                    height: 20.00,
                  ),
                  Text('No tienes ninguna contraseña',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.00))
                ],
              ),
            );
          }
        }
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Color(0XFF2CDA9D),
        onPressed: () {
          Navigator.of(context).push(CupertinoPageRoute(
              builder: (BuildContext context) => PaginaRegistrarPassword()));
        },
      ),
    );
  }

  void init(BuildContext context) {
    BlocProvider.of<GestionpasswordBloc>(context).add(ObtenerPasswords());
  }

  void _notificacion() async {
    setState(() {
      opacidad = 1;
    });
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {
      opacidad = 0;
    });
  }
}
