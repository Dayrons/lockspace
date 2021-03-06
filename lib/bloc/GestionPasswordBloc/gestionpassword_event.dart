part of 'gestionpassword_bloc.dart';

@immutable
abstract class GestionpasswordEvent {}

class ObtenerPasswords extends GestionpasswordEvent {}

class RegistrarPassword extends GestionpasswordEvent {
  final Password password;

  RegistrarPassword({this.password});
}

class EliminarPassword extends GestionpasswordEvent {
  final int id;

  EliminarPassword({this.id});
}
