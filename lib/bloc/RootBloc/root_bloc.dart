import 'package:app/models/User.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/utils/key_service.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final _userPreferences = UserSharedPrefs();
  RootBloc() : super(RootInitial()) {
    on<Init>(_onInit);
  }

  Future<void> _onInit(Init event, Emitter<RootState> emit) async {
    await _userPreferences.init();
    final User? user = _userPreferences.getUser();

    if (user == null || user.id == 0) {
      // Primera vez o sin usuario
      emit(IniciandoPorPrimeraVez());
    } else {
      // Siempre verificar si la key está en memoria.
      // La key se pierde al cerrar/reiniciar la app, así que siempre
      // se pedirá la contraseña al iniciar (no hay "recuérdame").
      if (KeyService().hasKey) {
        emit(SesionActiva());
      } else {
        emit(RequiereDesbloqueo(user: user));
      }
    }
  }
}
