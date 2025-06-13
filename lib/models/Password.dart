import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';

class Password {
  int id;
  String title;
  String password;

  final DateTime crecreatedAt;
  final DateTime updatedAt;

  //me quede probando encriptado y desencriptado con este modo
  // For Fernet Encryption/Decryption
  static final keyFernet =
      encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);

  static final encrypterFernet = encrypt.Encrypter(fernet);

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

  Password({
    this.id,
    this.password,
    this.title,
    this.crecreatedAt,
    this.updatedAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'title': this.title,
      'password':this.password,
      'updated_at': DateTime.now().toString(),
    };
  }

  Future<void> insert() async {
    Database db = await DB().conexion();
    this.password = this.passwordDecrypt();
    final data = this.toMap();
    data['created_at'] = DateTime.now().toString();
    await db.insert(
      'passwords',
      data,
    );
  }

 

  Future<void> update() async {
    Database db = await DB().conexion();
    this.password = this.passwordEncrypt();
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
    List<Map<String, dynamic>> result = await db.query('passwords');
    List<Password> passwords = List.generate(result.length, (i) {
      return Password(
        id: result[i]["id"],
        title: result[i]["title"],
        password: result[i]["password"],
        crecreatedAt: DateTime.parse(result[i]["created_at"]),
        updatedAt: DateTime.parse(result[i]["updated_at"]),
      );
    });

    return passwords;
  }

  passwordEncrypt() {
    final encrypted = encrypterFernet.encrypt(this.password);

    // print(fernet.extractTimestamp(encrypted.bytes));
    // unix timestamp
    return encrypted.base64;
  }
  passwordDecrypt() {
    
    return encrypterFernet.decrypt64(this.password);
  }



  @override
  String toString() {
    return 'Password{id: $id, title: $title, password: $password}';
  }
}
