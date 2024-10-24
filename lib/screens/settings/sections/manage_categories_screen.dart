import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kool_todo/controller/group_controller.dart';
import 'package:kool_todo/models/group_model.dart';

class ManageCategoriesScreen extends StatelessWidget {
  final GroupController groupController = Get.put(GroupController());

  ManageCategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manage Categories'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _showGroupDialog(context, null);
            },
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: groupController.groups.length,
          itemBuilder: (context, index) {
            final group = groupController.groups[index];
            return ListTile(
              title: Text(group.groupName),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      _showGroupDialog(context, group);
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _confirmDeleteGroup(context, group.groupId!);
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  // Dialog to add/edit group
  void _showGroupDialog(BuildContext context, Group? group) {
    final TextEditingController groupNameController = TextEditingController();
    if (group != null) {
      groupNameController.text = group.groupName;
    }

    Get.dialog(
      AlertDialog(
        title: Text(group == null ? 'Add Group' : 'Edit Group'),
        content: TextField(
          controller: groupNameController,
          decoration: InputDecoration(
            labelText: 'Group Name',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (groupNameController.text.isNotEmpty) {
                if (group == null) {
                  groupController
                      .addGroup(Group(groupName: groupNameController.text));
                } else {
                  group.groupName = groupNameController.text;
                  groupController.updateGroup(group);
                }
                Get.back();
              } else {
                Get.snackbar('Error', 'Group name cannot be empty');
              }
            },
            child: Text(group == null ? 'Add' : 'Update'),
          ),
        ],
      ),
    );
  }

  // Confirm delete group
  void _confirmDeleteGroup(BuildContext context, int groupId) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Group'),
        content: Text('Are you sure you want to delete this group?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              groupController.deleteGroup(groupId);
              Get.back();
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }
}
