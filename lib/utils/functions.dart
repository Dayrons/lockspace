import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

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

  int maxLength = values["max_length"] as int? ?? 12;
  for (var i = 1; i < maxLength - selectedCharacters.length; i++) {
    final numeroRandom = random.nextInt(lowercase.length);
    passwordRandom += lowercase[numeroRandom];
  }

  selectedCharacters.shuffle();
  passwordRandom += selectedCharacters.join();

  return passwordRandom;
}

String getDeviceId() {
  return 'default_device_key_fallback';
}
