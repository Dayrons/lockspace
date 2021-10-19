import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;



class DB {
  
  List tablas =[
       "CREATE TABLE tbl_usuario (id	INTEGER NOT NULL UNIQUE,usuario TEXT NOT NULL ,password TEXT NOT NULL , PRIMARY KEY(id AUTOINCREMENT)) ",
 "CREATE TABLE tbl_passwords (id	INTEGER NOT NULL UNIQUE,password	TEXT NOT NULL, titulo	TEXT NOT NULL,PRIMARY KEY(id AUTOINCREMENT))" 
      
];

   conexion() async {
    String pathDb = await getDatabasesPath();
    return await openDatabase(p.join(pathDb, 'lockSpace.db'), version: 1,
        onCreate:  (Database db, int version) async{
          for (var tabla in tablas) {
         
             await db.execute(tabla);
             
           }
          
    },
    );
  }

}