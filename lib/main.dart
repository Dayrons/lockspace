import 'package:app/bloc/AuthBloc/auth_bloc.dart';
import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/bloc/RootBloc/root_bloc.dart';
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
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<RootBloc>(
          create: (context) => RootBloc(),
        ),
        BlocProvider<PasswordBloc>(
          create: (context) => PasswordBloc(),
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
      home: Root(),
      theme: ThemeData(
        primaryColor: Color(0XFF1c1d22),
      ),
    );
  }
}
