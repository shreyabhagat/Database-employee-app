import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();

  Database _db;

  Future<Database> get database async {
    if (_db != null) return _db;
    return _db = await initDatabase();
  }

  Future<Database> initDatabase() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'employee.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
     await db.execute(
        'create table employees(id integer primary key autoincrement,name text, post text, salary integer)');
  }
}
