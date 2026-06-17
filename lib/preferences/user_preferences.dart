import 'package:app/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class UserSharedPrefs {
  static final UserSharedPrefs _instance = UserSharedPrefs._internal();

  factory UserSharedPrefs() {
    return _instance;
  }

  UserSharedPrefs._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> setUser(Map<String, dynamic> user) async {
    final jsonString = jsonEncode(user);
    await _prefs.setString('user', jsonString);
  }

  Future<void> setSesion(bool sesion) async {
    await _prefs.setBool('sesion', sesion);
  }

  Future<bool?> getSesion() async {
    return _prefs.getBool('sesion');
  }

  User? getUser() {
    final jsonString = _prefs.getString('user');
    if (jsonString == null) return null;
    final Map<String, dynamic> userDecode = jsonDecode(jsonString) as Map<String, dynamic>;
    return User(
      id: userDecode["id"] as int? ?? 0,
      uuid: userDecode["uuid"] as String? ?? '',
      name: userDecode["name"] as String? ?? '',
      password: userDecode["password"] as String? ?? '',
      salt: userDecode["salt"] as String?,
    );
  }

  Future<void> clearUser() async {
    await _prefs.remove('user');
  }
}
