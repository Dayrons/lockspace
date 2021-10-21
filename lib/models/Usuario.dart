import 'package:app/db.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sqflite/sqflite.dart';

class Usuario {
  final String nombre;
  final String password;

  //me quede probando encriptado y desencriptado con este modo
  // For Fernet Encryption/Decryption
  static final keyFernet =
      encrypt.Key.fromUtf8('TechWithVPIsBestTechWithVPIsBest');
  // if you need to use the ttl feature, you'll need to use APIs in the algorithm itself
  static final fernet = encrypt.Fernet(keyFernet);

  static final encrypterFernet = encrypt.Encrypter(fernet);

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
