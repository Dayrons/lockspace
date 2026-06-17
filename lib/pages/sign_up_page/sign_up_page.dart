import 'package:app/bloc/AuthBloc/auth_bloc.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:app/utils/ui.dart';
import 'package:app/widgets/boton.dart';
import 'package:app/widgets/check.dart';
import 'package:app/widgets/input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final Map<String, dynamic> values = {
    'name': '',
    'password': '',
    'sesion': false,
  };

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSignUpState) {
          if (!state.isLoading && !state.isError) {
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (BuildContext context) => HomePage(),
              ),
              (Route<dynamic> route) => false,
            );
          }
        }
      },
      child: Scaffold(
        backgroundColor: const Color(fondo),
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Ingresa una contraseña',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Con una sola contraseña gestiona todas las demas  ',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 30.00),
              Input(
                texto: 'Nombre de usuario',
                input: 'name',
                obscureText: false,
                validacion: true,
                onChange: _onChanged,
              ),
              Input(
                texto: 'Password',
                input: 'password',
                obscureText: true,
                validacion: true,
                onChange: _onChanged,
              ),
              Check(
                texto: 'Mantener sesion activa',
                input: 'sesion',
                value: values['sesion'] as bool,
                onChanged: _onChanged,
              ),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSignUpState && state.isLoading) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return Boton(
                    texto: 'Registrar',
                    color: const Color(detalles),
                    textColor: Colors.white,
                    onTap: _signUp,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onChanged(String input, dynamic value) {
    setState(() {
      values[input] = value;
    });
  }

  void _signUp() {
    BlocProvider.of<AuthBloc>(context).signUp(values);
  }
}
