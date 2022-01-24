part of 'registrarpassword_bloc.dart';

@immutable
abstract class RegistrarpasswordEvent {}

class Validar extends RegistrarpasswordEvent {
  final String input;
  final String valor;

  Validar({this.input, this.valor});
}

class Registrar extends RegistrarpasswordEvent {
  final BuildContext context;

  Registrar({this.context});
}
