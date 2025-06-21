import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/models/User.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());
  final _userPreferences = UserSharedPrefs();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is AuthEvent) {
      if (event.isSignIn) {
        yield AuthSignInState(
          isError: event.isError,
          errorMessage: event.errorMessage,
          isLoading: event.isLoading,
        );
      }
      if (event.isSignUp) {
        yield AuthSignUpState(
          isError: event.isError,
          errorMessage: event.errorMessage,
          isLoading: event.isLoading,
        );
      }
    }
  }

  signUp(Map values) async {
    add(AuthEvent(isSignUp: true, isLoading: true));
    try {
      // con el injectable en un solo lugar llamaria al metodo init y le pasaria el  _userPreferences a todos los bloc necesarios
      await _userPreferences.init();
      final user = User(name: values["name"], password: values["password"]);
      await user.create();
      await _userPreferences.setUser(user.toMap());
      add(AuthEvent(isSignUp: true, isLoading: false, isError: false));
    } catch (e) {
      add(AuthEvent(
          isSignUp: true, isLoading: false, isError: true, errorMessage: "$e"));
    }
  }

  signIn(Map values) async {
    add(AuthEvent(isSignIn: true, isLoading: true));
    try {
      User user = User(name: values["name"], password: values["password"]);
      user = await user.get();
      if (user != null) {
        await _userPreferences.setUser(user.toMap());
        add(AuthEvent(isSignIn: true, isLoading: false, isError: false));
      }else{
        add(AuthEvent(isSignIn: true, isLoading: false, isError: true, errorMessage: "Usuario o contraseña invalida"));
      }
    } catch (e) {
        add(AuthEvent(isSignIn: true, isLoading: false, isError: true, errorMessage: "$e"));
      
    }
  }
}
