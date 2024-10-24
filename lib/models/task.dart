class Task {
  int? taskId;
  String taskName;
  String taskCreationDate;
  String taskTargetDate;
  int taskPriority;
  String taskType;
  int taskShowAlert;
  String taskAlertTime;
  String taskStatus;
  int taskGroupId;
  String taskDescription; // Add this line

  Task({
    this.taskId,
    required this.taskName,
    required this.taskCreationDate,
    required this.taskTargetDate,
    required this.taskPriority,
    required this.taskType,
    required this.taskShowAlert,
    required this.taskAlertTime,
    required this.taskStatus,
    required this.taskGroupId,
    required this.taskDescription, // Add this line
  });

  // Add a toMap method to convert the task to a map
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'taskCreationDate': taskCreationDate,
      'taskTargetDate': taskTargetDate,
      'taskPriority': taskPriority,
      'taskType': taskType,
      'taskShowAlert': taskShowAlert,
      'taskAlertTime': taskAlertTime,
      'taskStatus': taskStatus,
      'taskGroupId': taskGroupId,
      'taskDescription': taskDescription, // Add this line
    };
  }

  // Add a fromMap method to create a task from a map
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskId: map['taskId'],
      taskName: map['taskName'],
      taskCreationDate: map['taskCreationDate'],
      taskTargetDate: map['taskTargetDate'],
      taskPriority: map['taskPriority'],
      taskType: map['taskType'],
      taskShowAlert: map['taskShowAlert'],
      taskAlertTime: map['taskAlertTime'],
      taskStatus: map['taskStatus'],
      taskGroupId: map['taskGroupId'],
      taskDescription: map['taskDescription'], // Add this line
    );
  }
}
