part of 'login_bloc.dart';

@immutable
abstract class LoginEvent {}

class Sigin extends LoginEvent {
  final String password;

  Sigin({@required this.password});
}
