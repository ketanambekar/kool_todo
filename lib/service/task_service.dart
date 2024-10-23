import 'package:kool_todo/database/database.dart';
import 'package:kool_todo/models/task.dart';
import 'package:sqflite/sqflite.dart';


class TaskService {
  // Get all tasks from the database
  Future<List<Task>> getTasks() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('tasks');

    return List.generate(maps.length, (i) {
      return Task.fromMap(maps[i]);
    });
  }

  // Create a new task
  Future<void> createTask(Task task) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'tasks',
      task.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Update an existing task
  Future<void> updateTask(Task task) async {
    final db = await DatabaseHelper().database;
    await db.update(
      'tasks',
      task.toMap(),
      where: 'taskId = ?',
      whereArgs: [task.taskId],
    );
  }

  // Delete a task
  Future<void> deleteTask(int taskId) async {
    final db = await DatabaseHelper().database;
    await db.delete(
      'tasks',
      where: 'taskId = ?',
      whereArgs: [taskId],
    );
  }
}
