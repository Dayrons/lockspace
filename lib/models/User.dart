import 'package:app/db.dart';
import 'package:app/models/Password.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';
import 'package:bcrypt/bcrypt.dart';
import 'package:uuid/uuid.dart';

class User {
  int id;
   String uuid;
  final String name;
  String password;
  List<Password> passwords;

  encrypt.Encrypter encrypterFernet;

  User({this.id,this.uuid ,this.name, this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'uuid':this.uuid,
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
    this.password = hash;
    final uuid = Uuid().v4();
    final int userId = await db.insert(
      'users',
      {
        "uuid":uuid,
        "name": this.name.toLowerCase(),
        "password": this.password,
      },
    );
    this.uuid =uuid;
    this.id = userId;
  }

  Future<User> get() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> results = await db.query('users',
        where: 'name = ?',
        whereArgs: [
          this.name.toLowerCase(),
        ],
        limit: 1);

    List<User> users = List.generate(results.length, (i) {
      return User(
        id: results[i]["id"],
        uuid: results[i]["uuid"],
        name: results[i]["name"],
        password: results[i]["password"],
      );
    });
    if (users.length > 0) {
      final hasCheck = BCrypt.checkpw(this.password, users[0].password);
      if (hasCheck) {
        return users[0];
      }
    }

    return null;
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(
      'users',
      where: null,
    );
  }
}
