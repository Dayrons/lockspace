part of 'auth_bloc.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthSignInState extends AuthState {
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  AuthSignInState({this.isLoading = false, this.isError, this.errorMessage});

 
}

class AuthSignUpState extends AuthState {
  final bool isLoading;
   final bool isError;
  final String errorMessage;

  AuthSignUpState({this.isLoading = false, this.isError, this.errorMessage});

 
}
