import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/class/DbTable.dart';
import 'package:flutter_app/class/Value.dart';

class DbHelper {
  static DbHelper dbHelper;
  static Database db;

  DbHelper._createInstance();

  factory DbHelper() {
    if (dbHelper == null) {
      return DbHelper._createInstance();
    }

    return dbHelper;
  }

  Future<void> open() async {
    if (db != null) return;

    var dbPath = join(await getDatabasesPath(), 'values_database.db');

    db = await openDatabase(dbPath, onCreate: initialize, version: 1);
  }

  void initialize(Database db, int newVersion) async {
    await db.execute("""
      CREATE TABLE NGValues(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT
      );
      CREATE TABLE favouriteValues(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
      valueId INTEGER,
      );
      INSERT INTO NGValues(id,text)
      VALUES (0, "Exceed clients' and colleagues' expectations");
      
      INSERT INTO NGValues(id,text)
      VALUES (0, "Take ownership and question the status quo in a constructive manner");  
          
      INSERT INTO NGValues(id,text)
      VALUES (0, "Be brave, curious and experiment. Learn from all successes and failures");
      
      INSERT INTO NGValues(id,text)
      VALUES (0,  "Act in a way that makes all of us proud");
      
      INSERT INTO NGValues(id,text)
      VALUES (0, "Build an inclusive, transparent and socially responsible culture"); 
                 
      INSERT INTO NGValues(id,text)
      VALUES (0, "Recognize excellence and engagement"); 
      
      INSERT INTO NGValues(id,text)
      VALUES (0, "Be ambitious, grow yourself and the people around you"); 

    
    
      
      
    """);
  }

  Future<int> insertEntry(DbTable entry, String tableName) async {
    var result = await db.insert(tableName, entry.toMapWithoutId(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    return result;
  }

  Future<List<Value>> getEntries() async {
    var result = await db.query("NGValues", orderBy: "id ASC");

    return List.generate(result.length, (i) => Value.fromMap(result[i]));
  }

  Future<int> deleteEntry(DbTable entry, String tableName) async {
    var result =
    await db.delete(tableName, where: 'id = ?', whereArgs: [entry.id]);
    return result;
  }
}