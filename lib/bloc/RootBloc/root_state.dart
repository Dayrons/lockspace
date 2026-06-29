part of 'root_bloc.dart';

@immutable
abstract class RootState {}

class RootInitial extends RootState {}


class IniciandoPorPrimeraVez extends RootState{}

class IniciarSesion extends RootState{}

class SesionActiva extends RootState{}

class SesionInactiva extends RootState{}

/// Estado cuando hay sesión guardada pero se necesita la contraseña
/// para derivar la key (después de reload o reinicio)
class RequiereDesbloqueo extends RootState{
  final user;
  RequiereDesbloqueo({required this.user});
}