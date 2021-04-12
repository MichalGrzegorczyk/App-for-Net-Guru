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

    var dbPath = join(await getDatabasesPath(), 'values_database7.db');

    db = await openDatabase(dbPath, onCreate: initialize, version: 1);
  }

  void initialize(Database db, int newVersion) async {
    await db.execute("""
      CREATE TABLE NGValues(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        text TEXT
      )
    """);
    await db.execute("""
      CREATE TABLE favouriteValues(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        valueId TEXT
      )
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

  Future<List<Value>> getFavouriteEntries() async {

    var result = await db.rawQuery('select NGValues.text from NGValues, favouriteValues where NGValues.id=valueId');
    print(result);
    return List.generate(result.length, (i) => Value.fromMap(result[i]));

  }
}