import 'package:shared_preferences/shared_preferences.dart';

class KeyService {
  static final KeyService _instance = KeyService._internal();
  factory KeyService() => _instance;
  KeyService._internal();

  String? _derivedKey;

  String? get derivedKey => _derivedKey;

  bool get hasKey => _derivedKey != null;

  void setDerivedKey(String key) {
    _derivedKey = key;
  }

  void clear() {
    _derivedKey = null;
  }
}
