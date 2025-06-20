import 'package:app/bloc/PasswordBloc/password_bloc.dart';
import 'package:app/models/Usuario.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

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
      if(event.isSignUp){
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
      
      final user = User(name: values["username"], password: values["password"]);
      await user.create();
      add(AuthEvent(isSignUp: true, isLoading: false, isError: false));

    } catch (e) {
      add(AuthEvent(isSignUp: true, isLoading: false, isError: true, errorMessage: "$e"));

    }
  }

  signIn(Map values) {
     final user =  User(name: values["username"], password:values["password"]);

     print(user);

      // return BCrypt.checkpw(passwordPlano, hashGuardado);
   
  }
}
