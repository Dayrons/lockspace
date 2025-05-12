part of 'gestionpassword_bloc.dart';

@immutable
abstract class GestionpasswordEvent {}

class ObtenerPasswords extends GestionpasswordEvent {}

class RegistrarPassword extends GestionpasswordEvent {
  final Password password;

  RegistrarPassword({this.password});
}

class UpdatePassword extends GestionpasswordEvent {
  final Map values;

  UpdatePassword({this.values});
}

class EliminarPassword extends GestionpasswordEvent {
  final int id;

  EliminarPassword({this.id});
}


class FiltrarPassword extends GestionpasswordEvent{
  final String search;

       FiltrarPassword({this.search});
}
