part of 'registrarpassword_bloc.dart';

class RegistrarpasswordState {
  final double width;
  final Map inputs;
  RegistrarpasswordState(
      {this.width = 0.00,
      this.inputs = const {
        'password': {'valor': '', 'validacion': true},
        'titulo': {'valor': '', 'validacion': true}
      }});
}
