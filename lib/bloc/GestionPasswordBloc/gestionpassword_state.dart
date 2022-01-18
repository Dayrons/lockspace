part of 'gestionpassword_bloc.dart';

@immutable
abstract class GestionpasswordState {}

class ConsultandoPasswords extends GestionpasswordState {}

class PasswordsObtenidas extends GestionpasswordState {
  final List passwords;

  PasswordsObtenidas({this.passwords});
}

class SinPasswords extends GestionpasswordState{}