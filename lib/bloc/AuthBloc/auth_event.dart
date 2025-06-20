part of 'auth_bloc.dart';

class AuthEvent {

  final bool isSignIn;
  final bool isSignUp;
  final bool isLoading;
  final bool isError;
  final String errorMessage;

  const AuthEvent({this.isSignIn = false, this.isSignUp = false , this.isLoading = false, this.errorMessage = "",this.isError = false});
}
