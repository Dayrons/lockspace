import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:app/models/Password.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState());

  @override
  Stream<PasswordState> mapEventToState(
    PasswordEvent event,
  ) async* {
    if (event is PasswordEvent) {
      yield state.copyWith(
        isLoading: event.isLoading,
        passwords: event.passwords,
        password: event.password,
      );
    }
  }

  void selectPassword(Password password) {
    add(PasswordEvent(password: password, isLoading: false));
  }

  void init() async {
    add(PasswordEvent(isLoading: true));
    final Password password = Password();
    List<Password> passwords = await password.getAll();
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }

  void addPassword(Password password) async{
    add(PasswordEvent(isLoading: true));
    password.create();
    List<Password> passwords = await password.getAll();
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }
  void removePassword(Password password) async{
    add(PasswordEvent(isLoading: true));
    password.delete();
    List<Password> passwords = await password.getAll();
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }
  void updatePassword(Password password) {
    add(PasswordEvent(isLoading: true));
    password.update();
    add(PasswordEvent(isLoading: false));
    init();
  }

  void filterPasswords(String search) async {
    add(PasswordEvent(isLoading: true));
    final Password password = Password();
    List passwords = await password.filter(search);
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }

  void clearPasswords() {}
}
