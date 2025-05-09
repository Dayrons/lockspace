import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';

class Password {
  int id;
  final String title;
  final String password;

  //me quede probando encriptado y desencriptado con este modo
  // For Fernet Encryption/Decryption
  static final keyFernet =
      encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);

  static final encrypterFernet = encrypt.Encrypter(fernet);

  Future<List<Password>> filter(String search) async {
    Database db = await DB().conexion();

    final result = await db.query("passwords",
        where: "title LIKE ?", whereArgs: ['%$search%']);
    return List.generate(result.length, (i) {
      return Password(
        id: result[i]["id"],
        title: result[i]["title"],
        password: result[i]["password"],
      );
    });
  }

  Password({this.id, this.password, this.title});

  Map<String, dynamic> toMap() {
    return {
      'id':this.id,
      'title': this.title,
      'password': encriptar(this.password),
    };
  }

  Future<void> insertar() async {
    Database db = await DB().conexion();

    await db.insert(
      'passwords',
      this.toMap(),
    );
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(
      'passwords',
      where: null,
    );
  }

  Future<void> eliminar() async {
    Database db = await DB().conexion();
    await db.delete(
      'passwords',
      where: "id = ?",
      whereArgs: [this.id],
    );
  }

  Future obtener() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> resultado = await db.query('passwords');
    List<Password> passwords = List.generate(resultado.length, (i) {
      return Password(
        id: resultado[i]["id"],
        title: resultado[i]["title"],
        password: resultado[i]["password"],
      );
    });

    return passwords;
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
}
