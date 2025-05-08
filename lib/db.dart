import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

class DB {
  // esto debe de ser un map con el key el nombre de la tabla
  Map tables = {
    "users": {
      "create":
          "CREATE TABLE users (id	INTEGER NOT NULL UNIQUE,name TEXT NOT NULL ,password TEXT NOT NULL , PRIMARY KEY(id AUTOINCREMENT)) ",
      "drop": "DROP TABLE IF EXISTS users",
      "update": []
    },
    "password": {
      "create":
          "CREATE TABLE passwords (id	INTEGER NOT NULL UNIQUE, password	TEXT NOT NULL, title	TEXT NOT NULL, created_at	TIMESTAMP DEFAULT CURRENT_TIMESTAMP, updated_at	TIMESTAMP DEFAULT CURRENT_TIMESTAMP, PRIMARY KEY(id AUTOINCREMENT))",
      "drop": "DROP TABLE IF EXISTS password",
      "update": []
    }
  };

  conexion() async {


    String pathDb = await getDatabasesPath();

    return await openDatabase(p.join(pathDb, 'lockSpace.db'), version: 1,
        onCreate: (Database db, int version) async {
      for (var entry in tables.entries) {
        String tableName = entry.key;
        String query = entry.value['create'];
        print("Creando tabla $tableName con la query: $query");
        await db.execute(query);
      }
    }, onUpgrade: (db, oldVersion, newVersion) async {
      for (var entry in tables.entries) {}

      if (oldVersion < newVersion) {}
    });


  }
}
