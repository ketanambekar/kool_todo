import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kool_todo/controller/task_controller.dart';
import 'package:kool_todo/models/task.dart';
import 'package:kool_todo/routes/app_routes.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  // Task passed from the previous screen
  final Task task;

  TaskDetailScreen({super.key, required this.task});

  // Controllers for the text fields
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskPriorityController = TextEditingController();
  final TextEditingController taskTypeController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final Rx<DateTime> taskTargetDate = DateTime.now().obs;
  final RxInt selectedGroupId = 0.obs;
  // Status options
  final List<String> statusOptions = ["Pending", "In Progress", "Completed"];
  final RxString selectedStatus = ''.obs;

  @override
  Widget build(BuildContext context) {
    // Initialize the fields with task data
    taskNameController.text = task.taskName;
    taskPriorityController.text = task.taskPriority.toString();
    taskTypeController.text = task.taskType;
    taskTargetDate.value = DateTime.parse(task.taskTargetDate);
    selectedStatus.value =
        task.taskStatus; // Initialize with the current task status
    taskDescriptionController.text = task.taskDescription;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              _confirmDeleteTask(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Task Name
              TextField(
                controller: taskNameController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Task Priority
              TextField(
                controller: taskPriorityController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Task Priority',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Task Type
              TextField(
                controller: taskTypeController,
                decoration: const InputDecoration(
                  labelText: 'Task Type',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
        
              // Task Target Date
              Obx(() {
                return ListTile(
                  title: Text(
                    "Target Date: ${DateFormat('yyyy-MM-dd').format(taskTargetDate.value)}",
                  ),
                  trailing: const Icon(Icons.calendar_today),
                  onTap: () => _selectDate(context),
                );
              }),
              const SizedBox(height: 16),
        
              // Task Status Dropdown
              Obx(() {
                return DropdownButtonFormField<String>(
                  value: selectedStatus.value,
                  items: statusOptions.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status),
                    );
                  }).toList(),
                  decoration: const InputDecoration(
                    labelText: 'Task Status',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (newStatus) {
                    selectedStatus.value = newStatus!;
                  },
                );
              }),
        
              const SizedBox(height: 20),
              TextField(
                controller: taskDescriptionController,
                maxLines: 2,
                decoration: const InputDecoration(
                  labelText: "Task Description",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
        
              // Update Button
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Validate inputs and update the task
                    if (taskNameController.text.isNotEmpty &&
                        taskPriorityController.text.isNotEmpty &&
                        taskTypeController.text.isNotEmpty) {
                      task.taskName = taskNameController.text;
                      task.taskPriority = int.parse(taskPriorityController.text);
                      task.taskType = taskTypeController.text;
                      task.taskTargetDate = taskTargetDate.value.toString();
                      task.taskStatus = selectedStatus.value; // Update the status
                      task.taskDescription = taskDescriptionController.text;
                      // Update the task in the database
                      taskController.updateTask(task);
        
                      // Show success message and navigate back
                      Get.snackbar("Success", "Task updated successfully!");
                      Get.back();
                    } else {
                      Get.snackbar("Error", "Please fill all fields.");
                    }
                  },
                  child: const Text('Update Task'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to select date
  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: taskTargetDate.value,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != taskTargetDate.value) {
      taskTargetDate.value = picked;
    }
  }

  // Confirm delete task dialog
  void _confirmDeleteTask(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back(); // Close dialog
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              taskController.deleteTask(task.taskId!); // Delete the task
              Get.until((route) => Get.currentRoute == AppRoutes.dashboard);
              Get.snackbar('Task Deleted', 'The task has been deleted.');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
