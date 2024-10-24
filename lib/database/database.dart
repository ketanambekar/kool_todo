import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper.internal();
  static Database? _database;

  factory DatabaseHelper() {
    return instance;
  }

  DatabaseHelper.internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'kool_todo.db');
    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE tasks (
        taskId INTEGER PRIMARY KEY AUTOINCREMENT,
        taskName TEXT,
        taskCreationDate TEXT,
        taskTargetDate TEXT,
        taskPriority INTEGER,
        taskType TEXT,
        taskShowAlert INTEGER,
        taskAlertTime TEXT,
        taskStatus TEXT,
        taskGroupId INTEGER,
        taskDescription TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE groups (
        groupId INTEGER PRIMARY KEY AUTOINCREMENT,
        groupName TEXT
      )
    ''');
  }
}
