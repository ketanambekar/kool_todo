import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kool_todo/controller/task_controller.dart';
import 'package:kool_todo/screens/add_task/add_task_view.dart';
import 'package:kool_todo/screens/settings/settings_view.dart';
import 'package:kool_todo/screens/task_details/task_detail_view.dart';

class Dashboard extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Get.to(() => const SettingsScreen());
            },
          ),
        ],),
      body: Obx(() {
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Dismissible(
              key: UniqueKey(),
              background: Container(
                color: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerLeft,
                child: const Icon(Icons.check, color: Colors.white),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                alignment: Alignment.centerRight,
                child: const Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  // Swipe left: Delete the task
                  taskController.deleteTask(task.taskId!);
                } else if (direction == DismissDirection.startToEnd) {
                  // Swipe right: Mark the task as completed
                  task.taskStatus = 'Completed'; // Update the task's status
                  taskController.updateTask(task);
                }
              },
              child: ListTile(
                title: Text(
                  task.taskName,
                  style: TextStyle(
                    decoration: task.taskStatus == 'Completed'
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                subtitle: Text('Due: ${task.taskTargetDate}'),
                trailing: Text(task.taskStatus),
                onTap: () {
                  // Handle task tap for edit if needed
                  Get.to(() => TaskDetailScreen(task: task));
                },
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example of adding a new task
          Get.bottomSheet(AddTaskView(),clipBehavior:Clip.hardEdge,isScrollControlled: true,);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
