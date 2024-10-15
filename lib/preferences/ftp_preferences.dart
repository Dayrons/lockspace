

import 'package:app/models/FtpClientModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class FtpSharedPrefs {
  static const String _tokenKey = 'token';

  //setters
  Future<void> save(FtpClientModel ftpClient) async {
    final prefs = await SharedPreferences.getInstance();

    if (ftpClient != null) {
      // prefs.setString(_tokenKey, response.data.jwt.token);
    }
  }

 
}
