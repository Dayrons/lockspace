part of 'registrarusuario_bloc.dart';

@immutable
abstract class RegistrarusuarioEvent {}


class Registrar extends RegistrarusuarioEvent{
  final Map datos;

  Registrar({this.datos});
}

 class Validar  extends RegistrarusuarioEvent{
   
   final String input;
   final String value;

  Validar({ this.input, this.value});


 }