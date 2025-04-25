import 'package:app/bloc/GestionPasswordBloc/gestionpassword_bloc.dart';
import 'package:app/models/Password.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
part 'registrarpassword_event.dart';
part 'registrarpassword_state.dart';

class RegistrarpasswordBloc
    extends Bloc<RegistrarpasswordEvent, RegistrarpasswordState> {
  final datos = {
    'password': {'valor': '', 'validacion': false},
    'titulo': {'valor': '', 'validacion': false}
  };

  RegistrarpasswordBloc() : super(RegistrarpasswordState());

  @override
  Stream<RegistrarpasswordState> mapEventToState(
    RegistrarpasswordEvent event,
  ) async* {
    if (event is Validar) {
      final input = datos[event.input];
      input['valor'] = event.valor;

      if (event.input == 'password') {
        input['validacion'] = event.valor.isNotEmpty;
        input['validacion'] = event.valor.length >= 2;
      }
      if (event.input == 'titulo') {
        input['validacion'] = event.valor.isNotEmpty;
      }
    } else if (event is Registrar) {
      if (datos['password']['validacion'] && datos['titulo']['validacion']) {
        Password password = Password(
          password: datos['password']['valor'],
          titulo: datos['titulo']['valor'],
        );

        await password.insertar();

        final List passwords = await password.obtener();

        BlocProvider.of<GestionpasswordBloc>(event.context).emit(
            GestionpasswordState(
                passwords: passwords, obteniendoPassword: false));

        datos['password']['valor'] = '';
        datos['titulo']['valor'] = '';
        datos['titulo']['validacion'] = false;
        datos['titulo']['validacion'] = false;
        yield RegistrarpasswordState(width: 250.00);

        await Future.delayed(Duration(seconds: 1));
        yield RegistrarpasswordState(width: 0.00);
      } else {
        yield RegistrarpasswordState(inputs: datos);

        //Mostrar un mensaje depende del campo que no este validado
      }
    }
  }
}
