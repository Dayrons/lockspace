import 'package:app/bloc/RootBloc/root_bloc.dart';
import 'package:app/pages/home_page/home_page.dart';
// import 'package:app/pages/inicio/pagina_usuario.dart';
import 'package:app/pages/login/pagina_login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'inicianndo_por_primera_vez/pagina_iniciando_por_primera_vez.dart';

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RootBloc, RootState>(
      listener: (context, state) {
        if (state is IniciandoPorPrimeraVez) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) =>
                      PaginaIniciandoPorPrimeravez()),
              (Route<dynamic> route) => false);
        } else if (state is SesionActiva) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => PaginaInicio()),
              (Route<dynamic> route) => false);
        } else if (state is SesionInactiva) {
          Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (BuildContext context) => PaginaLogin()),
              (Route<dynamic> route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: Color(0XFF1c1d22),
        body: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                height: 200.00,
                width: 200.00,
              ),
              Text(
                'LockSpace',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 32.00),
              ),
              Container(
                margin: EdgeInsets.only(top: 20.00),
                width: 250.00,
                child: Text('Un espacio seguro para todas tus contraseñas',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.00),
                    textAlign: TextAlign.center),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void init() {
    BlocProvider.of<RootBloc>(context).add(Init());
  }
}
