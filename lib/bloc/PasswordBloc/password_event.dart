part of 'password_bloc.dart';

class PasswordEvent {
  final bool isLoading;
  final Password password;
  final List<Password>passwords;
  final bool registerSuccess;
  final bool updateSuccess;
  final bool registerError;
  final bool  updateError;

  PasswordEvent({this.isLoading = true, this.password, this.passwords, this.registerSuccess , this.registerError, this.updateSuccess, this.updateError});
}
