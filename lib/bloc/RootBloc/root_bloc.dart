import 'package:app/models/Usuario.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'root_event.dart';
part 'root_state.dart';

class RootBloc extends Bloc<RootEvent, RootState> {
  RootBloc() : super(RootInitial());

  @override
  Stream<RootState> mapEventToState(
    RootEvent event,
  ) async* {
    if (event is Init) {
      Usuario usuario = Usuario();

      
      List usuarios = await usuario.obtener();

        

      if (usuarios.length == 0) {
        yield IniciandoPorPrimeraVez();
      } else {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        if (prefs.getBool("sesion")) {
          
          yield SesionActiva();
        }else{
          yield SesionInactiva();
        }

        
      }
    }
  }
}
