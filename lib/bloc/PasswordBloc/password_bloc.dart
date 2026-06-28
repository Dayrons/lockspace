import 'package:app/preferences/user_preferences.dart';
import 'package:bloc/bloc.dart';
import 'package:app/models/Password.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  PasswordBloc() : super(PasswordState()) {
    on<PasswordEvent>(_onPasswordEvent);
  }

  void _onPasswordEvent(PasswordEvent event, Emitter<PasswordState> emit) {
    emit(state.copyWith(
      isLoading: event.isLoading,
      passwords: event.passwords,
      password: event.password,
      registerError: event.registerError,
      registerSuccess: event.registerSuccess,
      updateSuccess: event.updateSuccess,
      updateError: event.updateError,
    ));
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

  void addPassword(Password password) async {
    add(PasswordEvent(isLoading: true));
    try {
      print('[PWD] addPassword() - title: ${password.title}, pass length: ${password.password.length}');
      await password.create();
      print('[PWD] addPassword() - create() succeeded');
      List<Password> passwords = await password.getAll();
      add(PasswordEvent(passwords: passwords, isLoading: false, registerSuccess: true));
    } catch (e) {
      print('[PWD] addPassword() EXCEPTION: $e');
      add(PasswordEvent(isLoading: false, registerError: true));
    }
  }

  void removePassword(Password password) async {
    add(PasswordEvent(isLoading: true));
    password.delete();
    List<Password> passwords = await password.getAll();
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }

  void updatePassword(Password password) async {
    try {
      add(PasswordEvent(isLoading: true));
      await password.update();
      List<Password> passwords = await password.getAll();
      add(PasswordEvent(isLoading: false, passwords: passwords, updateSuccess: true));
    } catch (e) {
      add(PasswordEvent(isLoading: false, updateError: true));
    }
  }

  void filterPasswords(String search) async {
    add(PasswordEvent(isLoading: true));
    final Password password = Password();
    List<Password> passwords = await password.filter(search);
    add(PasswordEvent(passwords: passwords, isLoading: false));
  }

  void clearPasswords() {}
}
