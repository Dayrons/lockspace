import 'package:app/db.dart';
import 'package:app/models/Password.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';
import 'package:bcrypt/bcrypt.dart';

class User {
  int id;
  final String name;
  final String password;
  List<Password> passwords;

  encrypt.Encrypter encrypterFernet;

  User({this.name, this.password});

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'password': this.password,
    };
  }

  List<Password> _getPasswords() {
    return [];
  }

  Future<void> create() async {
    Database db = await DB().conexion();

    String hash = BCrypt.hashpw(this.password, BCrypt.gensalt());
    await db.insert(
      'users',
      {
        "name": this.name,
        "password": hash,
      },
    );
  }

  


  Future<List<User>> get() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> results = await db.query(
      'users',
      where: 'name = ?',
      whereArgs: [this.name],
    );
    List<User> users = List.generate(results.length, (i) {
      return User(
        name: results[i]["name"],
        password: results[i]["password"],
      );
    });

    return users;
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(
      'users',
      where: null,
    );
  }
}
