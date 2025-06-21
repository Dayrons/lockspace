import 'package:app/models/User.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  final _userPreferences = UserSharedPrefs();
  RootBloc() : super(RootInitial());

  @override
  Stream<RootState> mapEventToState(
    RootEvent event,
  ) async* {
    if (event is Init) {
      await _userPreferences.init();
      final User user =_userPreferences.getUser();

      final sesionIsActive = await _userPreferences.getSesion();
  
      if (user?.id == null) {
        yield IniciandoPorPrimeraVez();
      } else {
        if (sesionIsActive) {
          yield SesionActiva();
        } else {
          yield SesionInactiva();
        }
      }
    }
  }
}
