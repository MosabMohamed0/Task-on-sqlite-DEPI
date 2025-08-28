import 'package:depi/sessions_tasks/expence_tracker/expense_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqliteDatabase {
  static late Database database;
  static const String tableName = "expenseTracker";

  static Future<void> initDatabase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'expenseTracker.db');

    // Delete the database
    // await deleteDatabase(path);

    // open the database
    database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute(
          'CREATE TABLE $tableName (id INTEGER PRIMARY KEY AUTOINCREMENT, date TEXT, amount REAL, category TEXT, note TEXT)',
        );
      },
    );
  }

  static Future<void> insertNewExpense(ExpenseModel expense) async {
    await database.insert(
      tableName,
      expense.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<void> updateExpense(ExpenseModel expense) async {
    await database.update(
      tableName,
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  static Future<void> deleteExpense(int id) async {
    await database.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  static Future<List<ExpenseModel>> getAllExpense() async {
    final List<Map<String, dynamic>> maps = await database.query(tableName);
    return maps.map((e) => ExpenseModel.fromMap(e)).toList();
  }

  static Future<void> clear() async {
    await database.delete(tableName);
  }
}
