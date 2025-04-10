import 'package:flutter_sqflite/models/expense.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

const String filename = 'expenses.db';

class DatabaseService {
  DatabaseService._init();
  static final DatabaseService instance = DatabaseService._init();

  static Database? _database;

  Future<Database> get database async {
    // check if database is null, if not return the database
    if (_database != null) {
      return _database!;
    }

    // if database is null, initialize the database
    _database = await _initializeDB(filename);
    return _database!;
  }

  // create the database
  Future _createDB(Database db, version) async {
    await db.execute('''
      CREATE TABLE $tableName(
        $idField $idType,
        $titleField $titleType,
        $amountField $amountType,
        $dateField $dateType,
        $categoryField $categoryType
      )
      ''');
  }

  // initialize the database
  Future<Database> _initializeDB(String filename) async {
    // get the path to the database
    final dbPath = await getDatabasesPath();
    // join the path with the filename
    final path = join(dbPath, filename);

    // open the database
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  // create expense
  Future<Expense> createExpense(Expense expense) async {
    final db = await instance.database;
    final id = await db.insert(tableName, expense.toJson());
    return expense.copyWith(id: id);
  }

  Future<List<Expense?>> readAllExpenses() async {
    final db = await instance.database;
    final result = await db.query(tableName);
    return result.map((json) => Expense.fromJson(json)).toList();
  }

  Future<int> deleteExpense(int id) async {
    final db = await instance.database;
    return await db.delete(tableName, where: '$idField = ?', whereArgs: [id]);
  }

  Future<void> clearAllExpenses() async {
    final db = await instance.database;
    await db.delete(tableName);
  }

  Future<void> close() async {
    final db = await instance.database;
    db.close();
  }
}
