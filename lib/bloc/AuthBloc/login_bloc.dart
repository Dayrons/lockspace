import 'dart:async';
import 'package:app/models/Usuario.dart';
import 'package:encrypt/encrypt.dart';
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
      User user = User(name: "lennox", password: "123456");

      List users = await user.getAll();

      var password = users[0].password;

      var passwordDecryp = user.decryptFernet(password);

      password = passwordDecryp;
      if (event.password == password) {
        yield Logeado();
      }

      /* 

      final key = Key.fromUtf8('my 32 length key................');
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key));
      final encrypted = encrypter.encrypt(event.password, iv: iv);
      final decrypted = encrypter.decrypt(encrypted, iv: iv);

      String password = usuarios[0].password;

      if (encrypted.base64 == password) {
       
      } */
    }
  }
}
