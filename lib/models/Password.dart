import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

class Password {
  int id;
  String title;
  String password;

  final DateTime crecreatedAt;
  final DateTime updatedAt;

  static Future<encrypt.Encrypter> getEncrypter() async {
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
    final keyFernet = encrypt.Key.fromUtf8(keyString);
    final fernet = encrypt.Fernet(keyFernet);
    return encrypt.Encrypter(fernet);
  }


    Password({
    this.id,
    this.password,
    this.title,
    this.crecreatedAt,
    this.updatedAt,
  });

  Future<List<Password>> filter(String search) async {
    Database db = await DB().conexion();

    final result = await db
        .query("passwords", where: "title LIKE ?", whereArgs: ['%$search%']);
    return List.generate(result.length, (i) {
      return Password(
        id: result[i]["id"],
        title: result[i]["title"],
        password: result[i]["password"],
        crecreatedAt: DateTime.parse(result[i]["created_at"]),
        updatedAt: DateTime.parse(result[i]["updated_at"]),
      );
    });
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'password':this.password,
      'updated_at': DateTime.now().toString(),
    };
  }

  Future<void> create() async {
    Database db = await DB().conexion();
    this.password = await this.passwordEncrypt();
    final data = this.toMap();
    data['created_at'] = DateTime.now().toString();
    await db.insert(
      'passwords',
      data,
    );
  }

  Future<void> update() async {
    Database db = await DB().conexion();
    this.password = await  this.passwordEncrypt();
    await db.update(
      'passwords',
      this.toMap(),
      where: "id = ?",
      whereArgs: [this.id],
    );
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(
      'passwords',
      where: null,
    );
  }

  Future<void> delete() async {
    Database db = await DB().conexion();
    await db.delete(
      'passwords',
      where: "id = ?",
      whereArgs: [this.id],
    );
  }

  Future<List<Password>> getAll() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> result = await db.query(
      'passwords',
      where: 'user_id = ?',
      whereArgs: [/* userId aquí */],
    );
    List<Password> passwords = [];
    for (var item in result) {
      Password pwd = Password(
        id: item["id"],
        title: item["title"],
        password: item["password"],
        crecreatedAt: DateTime.parse(item["created_at"]),
        updatedAt: DateTime.parse(item["updated_at"]),
      );
      pwd.password = await pwd.passwordDecrypt();
      passwords.add(pwd);
    }
    return passwords;
  }

  Future passwordEncrypt() async {
    final encrypterFernet = await  getEncrypter();
    final encrypted = encrypterFernet.encrypt(this.password);
    return encrypted.base64;
  }
  Future passwordDecrypt() async {
     final encrypterFernet = await  getEncrypter();
    return encrypterFernet.decrypt64(this.password);

  }



  @override
  String toString() {
    return 'Password{id: $id, title: $title, password: $password}';
  }
}
