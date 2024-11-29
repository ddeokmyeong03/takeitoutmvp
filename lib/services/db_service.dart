import 'dart:async';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._internal();
  factory DatabaseService() => _instance;

  DatabaseService._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'ingredients.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ingredients(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            storage TEXT,
            expiryDate TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertIngredient(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('ingredients', data);
  }

  Future<List<Map<String, dynamic>>> fetchIngredients() async {
    final db = await database;
    return await db.query('ingredients');
  }

  Future<int> deleteIngredient(int id) async {
    final db = await database;
    return await db.delete('ingredients', where: 'id = ?', whereArgs: [id]);
  }
}
