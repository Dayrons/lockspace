import 'package:app/pages/sign_in_page/sign_in_page.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/utils/key_service.dart';
import 'package:app/utils/sync_service.dart';
import 'package:app/utils/ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = false;

  Future<void> _logout() async {
    final prefs = UserSharedPrefs();
    await prefs.init();
    await prefs.setSesion(false);
    await prefs.clearUser();
    KeyService().clear();
    // Cerrar conexión WS al cerrar sesión
    SyncService().disconnect();

    Navigator.of(context).pushAndRemoveUntil(
      CupertinoPageRoute(
        builder: (context) => const SignInPage(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
        top: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Configuraciónes',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            "General",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: [
                  Icon(
                    Icons.notifications,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Notificaciones",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: const Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: [
                  Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Mantener sesion activa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: const Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
           const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Row(
                children: [
                  Icon(
                    Icons.router,
                    color: Colors.white,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Contener conexion ftp activa",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
              Switch(
                value: _notificationsEnabled,
                activeColor: const Color(0XFF2CDA9D),
                onChanged: (bool newValue) {
                  setState(() {
                    _notificationsEnabled = newValue;
                  });
                },
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: TextButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.redAccent),
              label: const Text(
                "Cerrar sesión",
                style: TextStyle(color: Colors.redAccent, fontSize: 16),
              ),
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
