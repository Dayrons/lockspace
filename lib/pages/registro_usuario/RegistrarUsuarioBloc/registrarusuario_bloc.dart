import 'package:app/models/Usuario.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'registrarusuario_event.dart';
part 'registrarusuario_state.dart';

class RegistrarusuarioBloc
    extends Bloc<RegistrarusuarioEvent, RegistrarusuarioState> {
  RegistrarusuarioBloc() : super(RegistrarusuarioState());

  @override
  Stream<RegistrarusuarioState> mapEventToState(
    RegistrarusuarioEvent event,
  ) async* {
    if (event is Validar) {
      yield RegistrarusuarioState(mensajeError: 'Minimo de 8 caracteres');
    }
    if (event is Registrar) {
      if (event.datos['password'].length >= 8) {
        Usuario usuario =
            Usuario(nombre: "lennox", password: event.datos['password']);

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setBool('sesion', event.datos['sesion']);

        usuario.insertar();

        yield RegistrarusuarioState(registrado: true);
      } else {
        yield RegistrarusuarioState(mensajeError: 'Minimo de 8 caracteres');
      }
    }
  }
}
