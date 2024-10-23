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
  });

  // You can add fromMap and toMap methods for easier database interaction
  factory Task.fromMap(Map<String, dynamic> json) => Task(
    taskId: json['taskId'],
    taskName: json['taskName'],
    taskCreationDate: json['taskCreationDate'],
    taskTargetDate: json['taskTargetDate'],
    taskPriority: json['taskPriority'],
    taskType: json['taskType'],
    taskShowAlert: json['taskShowAlert'],
    taskAlertTime: json['taskAlertTime'],
    taskStatus: json['taskStatus'],
    taskGroupId: json['taskGroupId'],
  );

  Map<String, dynamic> toMap() => {
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
  };
}
