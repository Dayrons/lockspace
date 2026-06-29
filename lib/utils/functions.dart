import 'dart:math';
import 'dart:convert';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

String generarPassword(Map<String, dynamic> values) {
  String passwordRandom = '';

  List<String> lowercase = [
    'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm',
    'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
  ];

  const List<String> capitalLetters = [
    'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  const List<String> specialCharacters = [
    '!', '@', '#', r'$', '%', '^', '&', '*', '(', ')', '+', '{', '}', '[', ']'
  ];
  const List<String> numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

  if (values['capital_letters'] == true) {
    lowercase.addAll(capitalLetters);
  }
  if (values['numbers'] == true) {
    lowercase.addAll(numbers);
  }
  if (values['special_characters'] == true) {
    lowercase.addAll(specialCharacters);
  }

  var random = Random();
  List<String> selectedCharacters = [];

  if (values['capital_letters'] == true) {
    selectedCharacters.add(capitalLetters[random.nextInt(capitalLetters.length)]);
  }
  if (values['numbers'] == true) {
    selectedCharacters.add(numbers[random.nextInt(numbers.length)]);
  }
  if (values['special_characters'] == true) {
    selectedCharacters.add(specialCharacters[random.nextInt(specialCharacters.length)]);
  }

  int maxLength = (values["max_length"] as num?)?.toInt() ?? 12;
  for (var i = 1; i < maxLength - selectedCharacters.length; i++) {
    final numeroRandom = random.nextInt(lowercase.length);
    passwordRandom += lowercase[numeroRandom];
  }

  selectedCharacters.shuffle();
  passwordRandom += selectedCharacters.join();

  return passwordRandom;
}

/// Deriva una clave de 32 bytes desde la contraseña del usuario usando PBKDF2.
/// 
/// Implementación manual de PBKDF2-HMAC-SHA256 (RFC 2898).
/// Usa 100,000 iteraciones y un salt fijo basado en el nombre de usuario
/// para que sea determinista entre dispositivos.
/// 
/// Esto permite que la misma contraseña maestra produzca la misma key de
/// encriptación en cualquier dispositivo (necesario para sincronización FTP
/// con la app desktop).
Future<Uint8List> deriveKeyAsync(String password, {String? salt}) async {
  final saltBytes = utf8.encode(salt != null ? 'lockspace_v1_$salt' : 'lockspace_v1_default');
  final passwordBytes = utf8.encode(password);
  const iterations = 100000;
  const keyLength = 32; // 256 bits para Fernet
  
  // PBKDF2: DK = T_1 || T_2 || ... || T_l
  // T_i = F(Password, Salt, c, i)
  // F(P,S,c,i) = U_1 XOR U_2 XOR ... XOR U_c
  // U_1 = PRF(P, S || i)
  // U_2 = PRF(P, U_1)
  // ...
  
  final hmac = Hmac(sha256, passwordBytes);
  final blocksNeeded = (keyLength / 32).ceil(); // SHA256 produce 32 bytes
  
  final key = <int>[];
  
  for (var blockIndex = 1; blockIndex <= blocksNeeded; blockIndex++) {
    // U_1 = HMAC(Password, Salt || blockIndex)
    final blockInput = Uint8List(saltBytes.length + 4);
    blockInput.setAll(0, saltBytes);
    // blockIndex como big-endian 4 bytes
    blockInput[saltBytes.length] = (blockIndex >> 24) & 0xff;
    blockInput[saltBytes.length + 1] = (blockIndex >> 16) & 0xff;
    blockInput[saltBytes.length + 2] = (blockIndex >> 8) & 0xff;
    blockInput[saltBytes.length + 3] = blockIndex & 0xff;
    
    var u = hmac.convert(blockInput).bytes;
    var t = List<int>.from(u);
    
    // U_2 hasta U_c
    for (var i = 1; i < iterations; i++) {
      u = hmac.convert(u).bytes;
      for (var j = 0; j < t.length; j++) {
        t[j] ^= u[j];
      }
    }
    
    key.addAll(t);
  }
  
  return Uint8List.fromList(key.take(keyLength).toList());
}
