import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final db = DatabaseHelper._();

  Database? database;
  Database? db1;

  Future<Database?> checkDb() async {
    if (database != null) {
      return database;
    } else {
      return await createDatabase();
    }
  }

  Future<Database?> createDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "moneytracker.db");
    if (Platform.isWindows || Platform.isLinux) {
      //Windows
      sqfliteFfiInit();
      final databaseFactory = databaseFactoryFfi;
      return databaseFactory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) {
            String query =
                "CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,expense INTEGER,operation TEXT,category TEXT,dateofexp TEXT,remarks TEXT)";
            db.execute(query);
          },
        ),
      );
    } else {
      //macOS, iOS, and Android
      return openDatabase(
        path,
        version: 1,
        onCreate: (db, version) {
          String query =
              "CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,expense INTEGER,operation TEXT,category TEXT,dateofexp TEXT,remarks TEXT)";
          db.execute(query);
        },
      );
    }
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        String query =
            "CREATE TABLE expenses(id INTEGER PRIMARY KEY AUTOINCREMENT,expense INTEGER,operation TEXT,category TEXT,dateofexp TEXT,remarks TEXT)";
        db.execute(query);
      },
    );
  }

  Future<void> insertData({
    required int expense,
    required String operation,
    required String category,
    required String dateofexp,
    String remarks = "",
  }) async {
    database = await checkDb();
    database!.insert("expenses", {
      "expense": expense,
      "operation": operation,
      "category": category,
      "dateofexp": dateofexp,
      "remarks": remarks,
    });
  }

  Future<List<Map>> readData() async {
    database = await checkDb();
    String query = "SELECT * FROM expenses";
    List<Map> dataList = await database!.rawQuery(query);
    return dataList;
  }

  Future<void> deleteData({required int id}) async {
    database = await checkDb();
    database!.delete("expenses", where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllData() async {
    database = await checkDb();
    database!.delete("expenses",);
  }

  Future<void> udpateData({
    required int id,
    required int expense,
    required String operation,
    required String category,
    required String dateofexp,
    String remarks = "",
  }) async {
    database = await checkDb();
    database!.update(
        "expenses",
        {
          "expense": expense,
          "operation": operation,
          "category": category,
          "dateofexp": dateofexp,
          "remarks": remarks,
        },
        where: "id = ?",
        whereArgs: [id]);
  }

  Future<List<Map>> getTotalExpense() async {
    database = await checkDb();
    String query = "SELECT SUM(expense) as totalExp FROM expenses";
    List<Map> exp = await database!.rawQuery(query);
    return exp;
  }
}
