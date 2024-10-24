import 'package:kool_todo/database/database.dart';
import 'package:kool_todo/models/group_model.dart';

class GroupService {
  static Future<List<Group>> getGroups() async {
    final db = await DatabaseHelper.instance.database;
    final result = await db.query('groups');
    return result.map((json) => Group.fromJson(json)).toList();
  }

  static Future<void> addGroup(Group group) async {
    final db = await DatabaseHelper.instance.database;
    await db.insert('groups', group.toJson());
  }

  static Future<void> updateGroup(Group group) async {
    final db = await DatabaseHelper.instance.database;
    await db.update('groups', group.toJson(), where: 'groupId = ?', whereArgs: [group.groupId]);
  }

  static Future<void> deleteGroup(int groupId) async {
    final db = await DatabaseHelper.instance.database;
    await db.delete('groups', where: 'groupId = ?', whereArgs: [groupId]);
  }
}
