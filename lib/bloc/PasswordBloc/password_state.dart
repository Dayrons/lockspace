part of 'password_bloc.dart';


class PasswordState {
  final List<Password> passwords;
  final bool isLoading;
  final Password password;

  PasswordState({this.passwords = const [], this.isLoading = true, this.password  = null});

  PasswordState copyWith({
    List<Password> passwords,
    bool isLoading,
    Password password,}) {
    return PasswordState(
      passwords: passwords ?? this.passwords,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
    );
  }
}
