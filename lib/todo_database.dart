import 'dart:developer';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class TodoAppDatabase {
 
  Future<Database> createDB() async{
  Database db= await openDatabase(
      join( await getDatabasesPath(),"TodoDB.db"),
      version: 1,
      onCreate: (db, version) {
        db.execute(
          '''
         create table todo( 
         id INTEGER PRIMARY KEY AUTOINCREMENT,
         title TEXT,
         description TEXT,
         date TEXT
         )

          '''
        );
      },

    );
    return db;

  }


  //Get data
 Future<List<Map>> getTodoItem() async{
    Database localDb =await createDB();
    List<Map> list =await localDb.query("todo");
    return list;

  }

  ///ADD data 
   void insertTodoItem(Map<String,dynamic> obj) async{
    Database localDb =await createDB();
    await localDb.insert("todo", obj,
    conflictAlgorithm: ConflictAlgorithm.replace
    );
    log("data inserted in database");
   }

   //Update data 
   Future <void> updateTodoItem(Map<String,dynamic> obj) async{
    Database localDb =await createDB();
    await localDb.update("todo", obj ,
    where: "id=?",whereArgs: [obj['id']]);
    log("Data Updated ");
   }

   // Delete data 
   Future<void> deletetodoItem(int index) async{
    Database db =await createDB();
    await db.delete("todo",where: "id=?",whereArgs: [index]);
   }
}