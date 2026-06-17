import 'package:app/bloc/AuthBloc/auth_bloc.dart';
import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/bloc/RootBloc/root_bloc.dart';
import 'package:app/pages/root.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const AppState());
}

class AppState extends StatelessWidget {
  const AppState({super.key});

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
      child: const App(),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Root(),
      theme: ThemeData(
        primaryColor: const Color(0XFF1c1d22),
      ),
    );
  }
}
