import 'dart:io';

import 'package:budget_tracker/screen/home/model/home_model.dart';
import 'package:budget_tracker/screen/transaction/model/transaction_model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  static DBHelper helper = DBHelper._();

  DBHelper._();

  Database? database;

  Future<Database>? checkDb() async {
    if (database != null) {
      return database!;
    } else {
      return await initDb();
    }
  }

  Future<Database> initDb() async {
    Directory dir = await getApplicationSupportDirectory();
    String path = join(dir.path, "category.db");
    return openDatabase(
      version: 1,
      path,
      onCreate: (db, version) {
        String categoryQuery =
            "CREATE TABLE category(id INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT)";
        String transactionQuery =
            "CREATE TABLE trans(id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,amount TEXT,date TEXT,time TEXT,category TEXT, status INTEGER)";
        db.execute(categoryQuery);
        db.execute(transactionQuery);
      },
    );
  }

  void insertCategory(String name) async {
    var db = await checkDb();
    db!.insert("category", {"name": name});
  }

  Future<List<HomeModel>> readCategory() async {
    var db = (await checkDb())!;
    String query = "SELECT * FROM category";
    List<Map> l1 = await db.rawQuery(query);
    List<HomeModel> cList = l1.map((e) => HomeModel.mapToModel(e)).toList();
    return cList;
  }

  void deleteCategory(int id) async {
    var db = (await checkDb())!;
    db.delete("category", where: "id=?", whereArgs: [id]);
  }

  void updateCategory(String name, int id) async {
    var db = (await checkDb())!;
    db.update("category", {"name": "$name"}, where: "id=?", whereArgs: [id]);
  }

  void insertTransaction(TransactionModel model) async {
    var db = (await checkDb())!;
    db.insert("trans", {
      "title": "${model.title}",
      "amount": "${model.amount}",
      "date": "${model.date}",
      "time": "${model.time}",
      "category": "${model.category}",
      "status": model.status
    });
  }
}
