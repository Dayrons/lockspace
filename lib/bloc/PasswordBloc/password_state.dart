part of 'password_bloc.dart';

class PasswordState {
  final List<Password> passwords;
  final bool isLoading;
  final Password password;
  final bool registerSuccess;
  final bool updateSuccess;
  final bool registerError;
  final bool updateError;

  PasswordState({
    this.passwords = const [],
    this.isLoading = true,
    Password? password,
    this.registerSuccess = false,
    this.updateSuccess = false,
    this.registerError = false,
    this.updateError = false,
  }) : password = password ?? Password();

  PasswordState copyWith({
    List<Password>? passwords,
    bool? isLoading,
    Password? password,
    bool? registerSuccess,
    bool? updateSuccess,
    bool? registerError,
    bool? updateError,
  }) {
    return PasswordState(
      passwords: passwords ?? this.passwords,
      isLoading: isLoading ?? this.isLoading,
      password: password ?? this.password,
      registerSuccess: registerSuccess ?? this.registerSuccess,
      updateSuccess: updateSuccess ?? this.updateSuccess,
      registerError: registerError ?? this.registerError,
      updateError: updateError ?? this.updateError,
    );
  }
}
