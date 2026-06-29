import 'package:app/models/User.dart';
import 'package:app/models/Password.dart';
import 'package:app/pages/home_page/home_page.dart';
import 'package:app/utils/functions.dart';
import 'package:app/utils/key_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DesbloquearPage extends StatefulWidget {
  final User user;

  const DesbloquearPage({super.key, required this.user});

  @override
  State<DesbloquearPage> createState() => _DesbloquearPageState();
}

class _DesbloquearPageState extends State<DesbloquearPage> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _desbloquear() async {
    setState(() => _isLoading = true);

    try {
      final password = _passwordController.text;
      if (password.isEmpty) {
        Fluttertoast.showToast(
          msg: "Ingresa tu contraseña",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() => _isLoading = false);
        return;
      }

      // Derivar key desde la contraseña
      final derivedKey = await deriveKeyAsync(password, salt: widget.user.name.toLowerCase());
      KeyService().setDerivedKey(derivedKey);

      // Verificar que la contraseña es correcta intentando desencriptar
      final passwordModel = Password();
      final passwords = await passwordModel.getAll(decrypt: false);
      
      if (passwords.isNotEmpty) {
        // Hay contraseñas, verificar que podemos desencriptar la primera
        try {
          final decrypted = await passwords[0].passwordDecrypt();
          // Si llega aquí, la contraseña es correcta
        } catch (e) {
          // La contraseña es incorrecta - no puede desencriptar
          Fluttertoast.showToast(
            msg: "Contraseña incorrecta",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
          );
          KeyService().clear();
          setState(() => _isLoading = false);
          return;
        }
      }

      if (!mounted) return;
      Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => HomePage()),
        (route) => false,
      );
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Error al desbloquear",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFF1c1d22),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                height: 120,
                width: 120,
              ),
              const SizedBox(height: 20),
              Text(
                "Hola, ${widget.user.name}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                "Ingresa tu contraseña para desbloquear",
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              const SizedBox(height: 30),
              TextField(
                controller: _passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: "Contraseña",
                  hintStyle: const TextStyle(color: Colors.white38),
                  filled: true,
                  fillColor: const Color(0XFF2b2e3d),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
                onSubmitted: (_) => _desbloquear(),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0XFF2CDA9D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: _desbloquear,
                        child: const Text(
                          "Desbloquear",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
