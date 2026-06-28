import 'dart:typed_data';

class KeyService {
  static final KeyService _instance = KeyService._internal();
  factory KeyService() => _instance;
  KeyService._internal();

  Uint8List? _derivedKey;

  Uint8List? get derivedKey => _derivedKey;

  bool get hasKey => _derivedKey != null;

  void setDerivedKey(Uint8List key) {
    _derivedKey = key;
  }

  void clear() {
    _derivedKey = null;
  }
}
