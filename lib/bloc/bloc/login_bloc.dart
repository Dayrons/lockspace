import 'dart:async';

import 'package:app/models/Usuario.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
 
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is Sigin) {
        Usuario usuario = Usuario(nombre: "lennox", password: "123456");

        List usuarios = await usuario.obtener();

        

      }

    
    
  }
}
