
import 'dart:math';
import 'package:encrypt/encrypt.dart' as encrypt;

import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';
String generarPassword(Map<String, dynamic> values) {
  //https://stackoverflow.com/questions/11674820/how-do-i-generate-random-numbers-in-dart
  //https://api.dart.dev/stable/2.15.1/dart-math/Random-class.html
  //https://protocoderspoint.com/generate-random-number-dart-program/

  String passwordRandom = '';

  List lowercase = [
    'a',
    'b',
    'c',
    'd',
    'e',
    'f',
    'g',
    'h',
    'i',
    'j',
    'k',
    'l',
    'm',
    'n',
    'o',
    'p',
    'q',
    'r',
    's',
    't',
    'u',
    'v',
    'w',
    'x',
    'y',
    'z'
  ];

  const List capitalLetters = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z'
  ];
  const List specialCharacters = [
    '!',
    '@',
    '#',
    '\$',
    '%',
    '^',
    '&',
    '*',
    '(',
    ')',
    '+',
    '{',
    '}',
    '[',
    ']'
  ];
  const List numbers = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '0'];

  if (values['capital_letters']) {
    lowercase.addAll(capitalLetters);
  }
  if (values['numbers']) {
    lowercase.addAll(numbers);
  }
  if (values['special_characters']) {
    lowercase.addAll(specialCharacters);
  }

  var random = Random();
  List<String> selectedCharacters = [];

  if (values['capital_letters']) {
    selectedCharacters.add(capitalLetters[random.nextInt(capitalLetters.length)]);
  }
  if (values['numbers']) {
    selectedCharacters.add(numbers[random.nextInt(numbers.length)]);
  }
  if (values['special_characters']) {
    selectedCharacters.add(specialCharacters[random.nextInt(specialCharacters.length)]);
  }

  for (var i = 1; i < values["max_length"] - selectedCharacters.length; i++) {
    final numeroRandom = random.nextInt(lowercase.length);
    passwordRandom += lowercase[numeroRandom];
  }

  // Shuffle the selected characters into the password
  selectedCharacters.shuffle();
  passwordRandom += selectedCharacters.join();

  return passwordRandom;
}


Future<String> getDeviceId() async{
  final deviceInfo = DeviceInfoPlugin();
    String deviceId = '';

    if (Platform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      deviceId = androidInfo.id;
    } else if (Platform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      deviceId = iosInfo.identifierForVendor;
    } else {
      deviceId = 'unsupported_platform';
    }

  
    String keyString = deviceId.padRight(32, '0').substring(0, 32);
   
    return keyString;
}