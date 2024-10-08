import 'package:hive/hive.dart';

part 'task.g.dart'; // Make sure this is generated after running build_runner

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final bool completed;

  Task({
    required this.id,
    required this.title,
    required this.completed,
  });

  // Factory constructor to create Task from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      id: json['id'] as String,
      title: json['title'] as String,
      completed: json['completed'] as bool,
    );
  }

  // Method to convert Task to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'completed': completed,
    };
  }
}
