import 'package:app/pages/inicio/pagina_usuario.dart';
import 'package:app/pages/registro_usuario/RegistrarUsuarioBloc/registrarusuario_bloc.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/check.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaginaRegistroUsuario extends StatefulWidget {
  @override
  _PaginaRegistroUsuarioState createState() => _PaginaRegistroUsuarioState();
}

class _PaginaRegistroUsuarioState extends State<PaginaRegistroUsuario> {
  final Map datos = {
    'password': '',
    'sesion': false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(fondo),
      body: BlocBuilder<RegistrarusuarioBloc, RegistrarusuarioState>(
        builder: (context, state) {
          return BlocListener<RegistrarusuarioBloc, RegistrarusuarioState>(
            listener: (context, state) {
              if (state.registrado) {
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(
                        builder: (BuildContext context) => PaginaInicio()),
                    (Route<dynamic> route) => false);
              }
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40.00,
                    child: Text(
                      state.mensajeError.toUpperCase(),
                      style: TextStyle(
                          color: Color(0XFFff4d4d),
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'Ingresa una contraseña para autenticarte',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                  SizedBox(
                    height: 20.00,
                  ),
                  Input(
                    texto: 'Password',
                    input: 'password',
                    obscureText: true,
                    onChange: _onChanged,
                  ),
                  Check(
                    texto: 'Mantener sesion activa',
                    input: 'sesion',
                    value: datos['sesion'],
                    onChanged: _onChanged,
                  ),
                  Boton(
                    texto: 'Registrar',
                    color: Color(detalles),
                    textColor: Colors.white,
                    onTap: _registrar,
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _onChanged(value, input) {
    setState(() {
      datos[input] = value;
    });
  }

  void _registrar() {
    BlocProvider.of<RegistrarusuarioBloc>(context).add(Registrar(datos: datos));
  }
}
