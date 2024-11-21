import 'package:path/path.dart';
import 'package:simple_cashier_app/core/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> initDb() async {
    if (_database != null) return _database!;

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, Constants.dbName);

    _database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(Constants.categoriesQuery);
      },
    );
    return _database!;
  }
}
