import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kool_todo/controller/group_controller.dart';
import 'package:kool_todo/controller/task_controller.dart';
import 'package:kool_todo/models/task.dart';
import 'package:kool_todo/screens/settings/sections/manage_categories_screen.dart';
import 'package:kool_todo/theme/app_colors.dart';


class AddTaskView extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();
  final GroupController groupController = Get.put(GroupController());
  // Controllers for the text fields
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskPriorityController = TextEditingController();
  final TextEditingController taskTypeController = TextEditingController();
  final TextEditingController taskDescriptionController = TextEditingController();
  final Rx<DateTime> taskTargetDate = DateTime.now().obs;
  final RxInt selectedGroupId = 0.obs;
  AddTaskView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardColor,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Task Name Input
          TextField(
            controller: taskNameController,
            decoration: const InputDecoration(
              labelText: "Task Name",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),

          // Task Priority Input
          TextField(
            controller: taskPriorityController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: "Task Priority",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),

          // Task Type Input
          TextField(
            controller: taskTypeController,
            decoration: const InputDecoration(
              labelText: "Task Type",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          Obx(() {
            return DropdownButtonFormField<int>(
              value: selectedGroupId.value != 0 ? selectedGroupId.value : null,
              decoration: const InputDecoration(
                labelText: "Task Category",
                border: OutlineInputBorder(),
              ),
              items: groupController.groups.map((group) {
                return DropdownMenuItem<int>(
                  value: group.groupId,
                  child: Text(group.groupName),
                );
              }).toList(),
              onChanged: (int? newValue) {
                selectedGroupId.value = newValue!;
              },
              hint: const Text("Select Category"),
            );
          }),
          const SizedBox(height: 10),

          // Button to manage categories
          TextButton.icon(
            icon: const Icon(Icons.category),
            label: const Text("Manage Categories"),
            onPressed: () {
              Get.to(() => ManageCategoriesScreen());
            },
          ),
          const SizedBox(height: 10),
          // Task Target Date (Date Picker)
          Obx(() {
            return ListTile(
              title: Text("Target Date: ${DateFormat('yyyy-MM-dd').format(taskTargetDate.value)}"),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context),
            );
          }),

          const SizedBox(height: 10),
          TextField(
            controller: taskDescriptionController,
            maxLines: 2,
            decoration: const InputDecoration(
              labelText: "Task Description",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          // Add Task Button
          ElevatedButton(
            onPressed: () {
              // Validate fields
              if (taskNameController.text.isNotEmpty &&
                  taskPriorityController.text.isNotEmpty &&
                  taskTypeController.text.isNotEmpty) {

                // Create Task and Save
                taskController.addTask(Task(
                  taskName: taskNameController.text,
                  taskCreationDate: DateTime.now().toString(),
                  taskTargetDate: taskTargetDate.value.toString(),
                  taskPriority: int.parse(taskPriorityController.text),
                  taskType: taskTypeController.text,
                  taskShowAlert: 0,  // Default to no alert
                  taskAlertTime: "",
                  taskStatus: "Pending",
                  taskGroupId: selectedGroupId.value,  // Default group ID (adjust as needed)
                  taskDescription: taskDescriptionController.text.isNotEmpty ? taskDescriptionController.text:'',
                ));

                // Close the bottom sheet
                Get.back();
              } else {
                // Show error message
                Get.snackbar("Error", "Please fill all the fields.");
              }
            },
            child: const Text("Add Task"),
          ),
        ],
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
}
