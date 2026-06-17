import 'package:app/db.dart';
import 'package:app/models/Password.dart';
import 'package:app/utils/key_service.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class User {
  late int id;
  late String uuid;
  final String name;
  String? salt;
  String password;
  List<Password> passwords = [];

  static String table_name = 'users';

  User({this.id = 0, this.uuid = '', required this.name, required this.password, this.salt});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'password': password,
      'salt': salt,
    };
  }

  Future<void> create() async {
    Database db = await DB().conexion();

    String hash = BCrypt.hashpw(password, BCrypt.gensalt());
    password = hash;

    final key = KeyService();
    salt = base64Encode(Uuid().v4().codeUnits);
    key.setDerivedKey(salt!);

    final uuidVal = Uuid().v4();
    final int userId = await db.insert(
      User.table_name,
      {
        "uuid": uuidVal,
        "name": name.toLowerCase(),
        "password": password,
        "salt": salt,
      },
    );
    uuid = uuidVal;
    id = userId;
  }

  Future<User?> get() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> results = await db.query(User.table_name,
        where: 'name = ?',
        whereArgs: [name.toLowerCase()],
        limit: 1);

    List<User> users = List.generate(results.length, (i) {
      return User(
        id: results[i]["id"] as int,
        uuid: results[i]["uuid"] as String,
        name: results[i]["name"] as String,
        password: results[i]["password"] as String,
        salt: results[i]["salt"] as String?,
      );
    });
    if (users.isNotEmpty) {
      final hasCheck = BCrypt.checkpw(password, users[0].password);
      if (hasCheck) {
        final key = KeyService();
        if (users[0].salt != null) {
          key.setDerivedKey(users[0].salt!);
        }
        return users[0];
      }
    }
    return null;
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(User.table_name);
  }
}
