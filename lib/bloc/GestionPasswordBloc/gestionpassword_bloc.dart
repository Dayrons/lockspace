import 'package:app/models/Password.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
part 'gestionpassword_event.dart';
part 'gestionpassword_state.dart';

class GestionpasswordBloc
    extends Bloc<GestionpasswordEvent, GestionpasswordState> {
  GestionpasswordBloc() : super(GestionpasswordState());

  @override
  Stream<GestionpasswordState> mapEventToState(
    GestionpasswordEvent event,
  ) async* {
    Password password = Password();
    if (event is ObtenerPasswords) {
      List passwords = await password.obtener();

      yield GestionpasswordState(
          passwords: passwords, obteniendoPassword: false);
    } else if (event is EliminarPassword) {
      await password.eliminar();

      List passwords = await password.obtener();

      yield GestionpasswordState(
          passwords: passwords, obteniendoPassword: false);
    } else if (event is FiltrarPassword) {
      List passwords = await password.filter(event.search);

      yield GestionpasswordState(
        passwords: passwords,
        obteniendoPassword: false,
      );
    }
  }
}
