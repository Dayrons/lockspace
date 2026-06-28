import 'package:app/db.dart';
import 'package:app/models/Password.dart';
import 'package:app/utils/key_service.dart';
import 'package:app/utils/functions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:crypto/crypto.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';

class User {
  late int id;
  late String uuid;
  final String name;
  String password;
  List<Password> passwords = [];

  static String table_name = 'users';

  User({this.id = 0, this.uuid = '', required this.name, required this.password});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'password': password,
    };
  }

  /// Genera un hash verificable de la contraseña usando HMAC-SHA256.
  /// Formato: "hmac_sha256$<base64_hash>"
  /// El salt incluye el username para que cada usuario tenga un hash único.
  static String _hashPassword(String password, String username) {
    final key = utf8.encode('lockspace_auth_v1_${username.toLowerCase()}');
    final bytes = utf8.encode(password);
    final hmac = Hmac(sha256, key);
    final digest = hmac.convert(bytes);
    return 'hmac_sha256\$${base64Encode(digest.bytes)}';
  }

  /// Verifica una contraseña contra un hash guardado.
  static bool _verifyPassword(String password, String storedHash, String username) {
    final computed = _hashPassword(password, username);
    return computed == storedHash;
  }

  Future<void> create() async {
    Database db = await DB().conexion();

    // Guardar la contraseña original antes de hashear
    final masterPassword = password;

    print('[AUTH] create() - name: $name, pass length: ${masterPassword.length}');

    // 1. Hash para verificación de login (HMAC-SHA256, no reversible sin el secreto)
    final hash = _hashPassword(masterPassword, name);
    password = hash;

    print('[AUTH] create() - stored hash: ${hash.substring(0, 50)}...');

    // 2. Derivar key de encriptación desde LA CONTRASEÑA ORIGINAL (no el hash)
    //    usando PBKDF2. El salt incluye el username en lowercase para que sea
    //    único por usuario pero determinista entre dispositivos.
    //    Misma pass + mismo user = misma key (permite sync FTP con desktop).
    final derivedKey = await deriveKeyAsync(masterPassword, salt: name.toLowerCase());
    KeyService().setDerivedKey(derivedKey);

    print('[AUTH] create() - derivedKey (first 8 bytes): ${derivedKey.sublist(0, 8)}');

    // 3. Guardar usuario en DB (solo el hash, NUNCA la key derivada ni la pass original)
    final uuidVal = Uuid().v4();
    final int userId = await db.insert(
      User.table_name,
      {
        "uuid": uuidVal,
        "name": name.toLowerCase(),
        "password": password,
      },
    );
    uuid = uuidVal;
    id = userId;

    print('[AUTH] create() - user saved with id: $id');
  }

  Future<User?> get() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> results = await db.query(User.table_name,
        where: 'name = ?',
        whereArgs: [name.toLowerCase()],
        limit: 1);

    print('[AUTH] get() - name: $name, results: ${results.length}');

    if (results.isEmpty) return null;

    final storedHash = results[0]["password"] as String;
    final dbName = results[0]["name"] as String;

    print('[AUTH] get() - storedHash: ${storedHash.substring(0, 40)}...');
    print('[AUTH] get() - input password length: ${password.length}');

    // Verificar contraseña: HMAC-SHA256 es determinista, si la contraseña
    // es diferente el hash será diferente → retorna false.
    final computedHash = _hashPassword(password, dbName);
    print('[AUTH] get() - computedHash: ${computedHash.substring(0, 40)}...');

    final hasCheck = _verifyPassword(password, storedHash, dbName);
    print('[AUTH] get() - hasCheck: $hasCheck');

    if (!hasCheck) return null;

    // Derivar la misma key que se usó al registrarse:
    // misma contraseña + mismo username (lowercase) = misma key (determinista)
    final derivedKey = await deriveKeyAsync(password, salt: dbName.toLowerCase());
    KeyService().setDerivedKey(derivedKey);

    return User(
      id: results[0]["id"] as int,
      uuid: results[0]["uuid"] as String,
      name: dbName,
      password: storedHash,
    );
  }

  Future<void> clear() async {
    Database db = await DB().conexion();
    await db.delete(User.table_name);
  }
}
