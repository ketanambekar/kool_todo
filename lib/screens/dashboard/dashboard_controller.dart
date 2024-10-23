import 'package:get/get.dart';
import 'package:kool_todo/models/task.dart';
import 'package:kool_todo/service/task_service.dart';


class DashboardController extends GetxController {
  final TaskService _taskService = TaskService();

  // Observable list of tasks
  var tasks = <Task>[].obs;

  // Fetch tasks when the controller is initialized
  @override
  void onInit() {
    fetchTasks();
    super.onInit();
  }

  // Fetch all tasks from the database
  void fetchTasks() async {
    tasks.value = await _taskService.getTasks();
  }

  // Add a new task
  void addTask(Task task) async {
    await _taskService.createTask(task);
    fetchTasks();  // Refresh the list after adding
  }

  // Update an existing task
  void updateTask(Task task) async {
    await _taskService.updateTask(task);
    fetchTasks();  // Refresh the list after updating
  }

  // Delete a task by its ID
  void deleteTask(int taskId) async {
    await _taskService.deleteTask(taskId);
    fetchTasks();  // Refresh the list after deleting
  }

  // Optionally, you can create a method to get a specific task by ID
  Task? getTaskById(int taskId) {
    return tasks.firstWhere((task) => task.taskId == taskId);
  }
}
