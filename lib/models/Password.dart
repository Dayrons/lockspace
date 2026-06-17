import 'package:app/db.dart';
import 'package:app/preferences/user_preferences.dart';
import 'package:app/utils/key_service.dart';
import 'package:app/utils/functions.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';
import 'dart:convert';
import 'package:uuid/uuid.dart';

class Password {
  late int userId;
  late int id;
  late String uuid;
  late String title;
  late String password;
  int expiration = 0;
  String expirationUnit = '';
  final DateTime createdAt;
  late DateTime updatedAt;
  final _userPreferences = UserSharedPrefs();
  static String table_name = 'passwords';

  Password({
    this.id = 0,
    this.uuid = '',
    this.userId = 0,
    this.password = '',
    this.title = '',
    this.expiration = 0,
    this.expirationUnit = '',
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : createdAt = createdAt ?? DateTime.now(),
       updatedAt = updatedAt ?? DateTime.now();

  static encrypt.Encrypter getEncrypter() {
    final keyService = KeyService();
    final keyString = keyService.derivedKey ?? getDeviceId();
    final keyBytes = base64.decode(keyString);
    final key = encrypt.Key.fromLength(32);
    final finalKey = encrypt.Key(keyBytes.length == 32 ? keyBytes : key.bytes);
    final fernet = encrypt.Fernet(finalKey);
    return encrypt.Encrypter(fernet);
  }

  Future<List<Password>> filter(String search) async {
    await _userPreferences.init();
    final user = _userPreferences.getUser();
    if (user == null) return [];
    Database db = await DB().conexion();
    final result = await db
        .query("passwords", where: "title LIKE ? AND user_id = ?", whereArgs: ['%$search%', user.id]);
    return List.generate(result.length, (i) {
      return Password(
        id: result[i]["id"] as int,
        uuid: result[i]["uuid"] as String,
        userId: result[i]["user_id"] as int,
        title: result[i]["title"] as String,
        expiration: result[i]["expiration"] as int,
        expirationUnit: result[i]["expiration_unit"] as String,
        password: result[i]["password"] as String,
        createdAt: DateTime.parse(result[i]["created_at"] as String),
        updatedAt: DateTime.parse(result[i]["updated_at"] as String),
      );
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'user_id': userId,
      'title': title,
      'password': password,
      'expiration': expiration,
      'expiration_unit': expirationUnit,
      'updated_at': updatedAt,
    };
  }

  Future<void> create() async {
    await _userPreferences.init();
    final user = _userPreferences.getUser();
    if (user == null) return;
    userId = user.id;
    Database db = await DB().conexion();
    password = await passwordEncrypt();
    uuid = Uuid().v4();
    final data = toMap();
    data['created_at'] = DateTime.now().toString();
    data['updated_at'] = DateTime.now().toString();
    await db.insert(Password.table_name, data);
  }

  Future<void> update() async {
    Database db = await DB().conexion();
    password = await passwordEncrypt();
    final data = toMap();
    data['updated_at'] = DateTime.now().toString();
    await db.update(Password.table_name, data, where: "id = ?", whereArgs: [id]);
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(Password.table_name);
  }

  Future<void> delete() async {
    Database db = await DB().conexion();
    await db.delete(Password.table_name, where: "id = ?", whereArgs: [id]);
  }

  Future<List<Password>> getAll({bool decrypt = true}) async {
    await _userPreferences.init();
    final user = _userPreferences.getUser();
    if (user == null) return [];
    Database db = await DB().conexion();
    List<Map<String, dynamic>> result = await db.query(
      Password.table_name,
      where: 'user_id = ?',
      whereArgs: [user.id],
    );
    List<Password> passwords = [];
    for (var item in result) {
      Password pwd = Password(
        id: item["id"] as int,
        uuid: item["uuid"] as String,
        userId: item["user_id"] as int,
        title: item["title"] as String,
        password: item["password"] as String,
        expiration: item["expiration"] as int,
        expirationUnit: item["expiration_unit"] as String,
        createdAt: DateTime.parse(item["created_at"] as String),
        updatedAt: DateTime.parse(item["updated_at"] as String),
      );
      if (decrypt) {
        pwd.password = await pwd.passwordDecrypt();
      }
      passwords.add(pwd);
    }
    return passwords;
  }

  Future<String> passwordEncrypt() async {
    final encrypterFernet = getEncrypter();
    final encrypted = encrypterFernet.encrypt(password);
    return encrypted.base64;
  }

  Future<String> passwordDecrypt() async {
    final encrypterFernet = getEncrypter();
    return encrypterFernet.decrypt64(password);
  }

  @override
  String toString() {
    return 'Password{id: $id, user_id: $userId title: $title, password: $password}';
  }
}
