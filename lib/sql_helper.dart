import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'demo.db');
    print(path);
// // Delete the database
//     await deleteDatabase(path);

// open the database
    Database database =
        await openDatabase(path, version: 1, onCreate: _onCreate);

    return database;
  }

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE Test (id INTEGER PRIMARY KEY, name TEXT, value INTEGER, num REAL)');

    await db.execute(
        'CREATE TABLE User (id INTEGER PRIMARY KEY, user_name TEXT, password TEXT)');

    print('create database and table');
  }

  userExists(String user_name) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('SELECT * FROM User');

    bool check = false;
    response.forEach((element) {
      if (element['user_name'] == user_name) {
        check = true;
      }
    });
    return check;
  }

  login(String user_name, String password) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery('SELECT * FROM User');

    bool check = false;
    response.forEach((element) {
      if (element['user_name'] == user_name &&
          element['password'] == password) {
        check = true;
      }
    });
    return check;
  }

  readData(String sql) async {
    Database? mydb = await db;
    List<Map> response = await mydb!.rawQuery(sql);
    return response;
  }

  insertData(String sql) async {
    Database? mydb = await db;
    print('mydb : $mydb');
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
