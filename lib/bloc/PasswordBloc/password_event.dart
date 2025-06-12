part of 'password_bloc.dart';

class PasswordEvent {
  final bool isLoading;
  final Password password;
  final List<Password>passwords;

  PasswordEvent({this.isLoading = true, this.password, this.passwords});
}
