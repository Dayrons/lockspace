import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';

class User {
  final String name;
  final String password;

  //me quede probando encriptado y desencriptado con este modo
  // For Fernet Encryption/Decryption
  static final keyFernet =
      encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);

  static final encrypterFernet = encrypt.Encrypter(fernet);

  User({this.name, this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'password': encriptar(this.password),
    };
  }

  Future<void> create() async {
    Database db = await DB().conexion();

    await db.insert(
      'users',
      this.toMap(),
    );
  }

  Future getAll() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> results = await db.query('users');
    print(results);
    List<User> users = List.generate(results.length, (i) {
      return User(
        name: results[i]["name"], password: results[i]["password"]);
    });

    return users;
  }

  encriptar(password) {
    final encrypted = encrypterFernet.encrypt(password);

    // print(fernet.extractTimestamp(encrypted.bytes));
    // unix timestamp
    return encrypted.base64;
  }

  decryptFernet(password) {
    encrypterFernet.decrypt64(password);

    return encrypterFernet.decrypt64(password);
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(
      'users',
      where: null,
    );
  }
}
