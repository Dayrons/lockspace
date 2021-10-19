import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart';
import 'package:sqflite/sqflite.dart';

class Usuario {
  final String nombre;
  final String password;

  Usuario({this.nombre, this.password});

  Map<String, dynamic> toMap() {
    return {
      'usuario': this.nombre,
      'password': encriptar(this.password),
    };
  }

  Future<void> insertar() async {
    Database db = await DB().conexion();

    await db.insert(
      'tbl_usuario',
      this.toMap(),
    );
  }

  Future obtener() async {
    Database db = await DB().conexion();
    List<Map<String, dynamic>> resultado = await db.query('tbl_usuario');
    List favoritos = List.generate(resultado.length, (i) {
      return Usuario(
          nombre: resultado[i]["usuario"], password: resultado[i]["password"]);
    });

    return favoritos;
  }

  String encriptar(password) {
    final plainText = password;
    final key = Key.fromUtf8('my 32 length key................');
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key));

    final encrypted = encrypter.encrypt(plainText, iv: iv);
    final decrypted = encrypter.decrypt(encrypted, iv: iv);

    print(decrypted);
    return encrypted.base64;
  }
}
