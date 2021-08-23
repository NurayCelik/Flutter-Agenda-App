import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DBHelper {
  static Future<Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'db'),
        onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE table(userId TEXT PRIMARY KEY, title TEXT, details TEXT, myDate TEXT, colorOne TEXT, colorTwo TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> updateData(
      String table, Map<String, Object> data, String userId) async {
    final db = await DBHelper.database();
    return db.update(table, data, where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<void> deleteData(String table, String userId) async {
    final db = await DBHelper.database();
    return db.delete(table, where: 'userId = ?', whereArgs: [userId]);
  }

  static Future<void> deleteDatabase(String table) async {
    final db = await DBHelper.database();
    db.rawDelete("Delete from $table");
  }

  static Future closeDb() async {
    final db = await DBHelper.database();
    db.close();
  }

  Future<int> queryRowCount(String table) async {
    Database db = await DBHelper.database();
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}
