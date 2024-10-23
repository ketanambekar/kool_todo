import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kool_todo/models/task.dart';
import 'package:kool_todo/screens/dashboard/dashboard_controller.dart';

class Dashboard extends StatelessWidget {
   Dashboard({super.key});

  final DashboardController taskController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return ListTile(
              title: Text(task.taskName),
              subtitle: Text('Due: ${task.taskTargetDate}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  taskController.deleteTask(task.taskId!);
                },
              ),
              onTap: () {
                // Handle task tap for edit
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Function to add a new task
          taskController.addTask(Task(
            taskName: "New Task",
            taskCreationDate: DateTime.now().toString(),
            taskTargetDate: DateTime.now().add(Duration(days: 1)).toString(),
            taskPriority: 1,
            taskType: "General",
            taskShowAlert: 0,
            taskAlertTime: "",
            taskStatus: "Pending",
            taskGroupId: 1,  // Sample group ID
          ));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}