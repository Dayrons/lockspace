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
    if (event is ObtenerPasswords) {
      Password password = Password();

      List passwords = await password.obtener();

      yield GestionpasswordState(
          passwords: passwords, obteniendoPassword: false);
    }
  }
}
