import 'package:app/models/Password.dart';
import 'package:app/models/User.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DB {
  Map tables = {
    User.table_name: {
      "create":
          "CREATE TABLE ${User.table_name} (id INTEGER NOT NULL UNIQUE, uuid TEXT NOT NULL UNIQUE, name TEXT NOT NULL, password TEXT NOT NULL, PRIMARY KEY(id AUTOINCREMENT))",
      "drop": "DROP TABLE IF EXISTS ${User.table_name}",
      "update": []
    },
    Password.table_name: {
      "create":
      "CREATE TABLE ${Password.table_name} (id INTEGER NOT NULL UNIQUE, uuid TEXT NOT NULL UNIQUE, user_id INTEGER NOT NULL, password TEXT NOT NULL, title TEXT NOT NULL, expiration INTEGER, expiration_unit TEXT, created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(id AUTOINCREMENT), FOREIGN KEY(user_id) REFERENCES users(id) ON DELETE CASCADE)",
      "drop": "DROP TABLE IF EXISTS ${Password.table_name}",
      "update": []
    }
  };

  conexion() async {
    String pathDb = await getDatabasesPath();

    return await openDatabase(p.join(pathDb, 'lockSpace.db'), version: 4,
        onCreate: (Database db, int version) async {
      for (var entry in tables.entries) {
        String tableName = entry.key;
        String query = entry.value["create"];
        await db.execute(query);
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      // Migración v4: cambio de bcrypt a HMAC-SHA256 para verificación de
      // contraseña. Los hashes viejos no son compatibles, se recrean tablas.
      if (oldVersion < 4) {
        await db.execute("DROP TABLE IF EXISTS ${Password.table_name}");
        await db.execute("DROP TABLE IF EXISTS ${User.table_name}");
        for (var entry in tables.entries) {
          await db.execute(entry.value["create"]);
        }
      }
    });
  }
}
