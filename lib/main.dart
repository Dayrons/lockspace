import 'package:app/bloc/AuthBloc/login_bloc.dart';
import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/bloc/RootBloc/root_bloc.dart';
import 'package:app/pages/inicianndo_por_primera_vez/pagina_iniciando_por_primera_vez.dart';
import 'package:app/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(),
        ),
        BlocProvider<GestionpasswordBloc>(
          create: (context) => GestionpasswordBloc(),
        ),
        BlocProvider<RootBloc>(
          create: (context) => RootBloc(),
        ),
      ],
      child: App(),
    );
  }
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaginaIniciandoPorPrimeravez(),
      theme: ThemeData(
        primaryColor: Color(0XFF1c1d22),
      ),
    );
  }
}
