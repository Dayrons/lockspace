import 'package:app/models/Password.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'gestionpassword_event.dart';
part 'gestionpassword_state.dart';

class GestionpasswordBloc
    extends Bloc<GestionpasswordEvent, GestionpasswordState> {
  GestionpasswordBloc() : super(ConsultandoPasswords());

  @override
  Stream<GestionpasswordState> mapEventToState(
    GestionpasswordEvent event,
  ) async* {
    Password password = Password();

    List passwords = await password.obtener();

    yield PasswordsObtenidas(passwords: passwords);

    if (event is RegistrarPassword) {
      Password password = event.password;

      await password.insertar();
      yield PasswordsObtenidas(passwords: passwords);
    }
  }
}
