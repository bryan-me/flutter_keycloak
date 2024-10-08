// // import 'package:flutter_keycloak/adapters/task_adapter.dart';
// // import 'package:hive/hive.dart';
// import 'dart:convert';

// import 'package:flutter_keycloak/task.dart';
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;
// // import 'package:connectivity_plus/connectivity_plus.dart';



// class TaskService{
//   // var taskBox = await Hive.openBox<Task>('tasks');
//   // Parse JSON data and convert it into a List of Task objects
//   List<Task> parseTasks(String responseBody) {
//     final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
//     return parsed.map<Task>((json) => Task.fromJson(json)).toList();
//   }

//   Future<void> fetchAndSaveData() async {
//   try {
//     final response = await http.get(Uri.parse('https://api.example.com/tasks'));
//     if (response.statusCode == 200) {
//       List<Task> tasks = parseTasks(response.body); // Convert JSON to Task objects
//       var taskBox = await Hive.openBox<Task>('tasks');

//       // Clear existing data to avoid duplications
//       await taskBox.clear();

//       // Store new data
//       for (var task in tasks) {
//         await taskBox.put(task.id, task);
//       }
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//   }
// }

// Future<List<Task>> getLocalTasks() async {
//   var taskBox = await Hive.openBox<Task>('tasks');
//   return taskBox.values.toList();
// }

// Future<void> syncWithRemote() async {
//   var taskBox = await Hive.openBox<Task>('tasks');
//   var localTasks = taskBox.values.toList();

//   // Fetch remote data
//   final response = await http.get(Uri.parse('https://api.example.com/tasks'));
//   if (response.statusCode == 200) {
//     List<Task> remoteTasks = parseTasks(response.body);

//     // Synchronize data: Update local database if there are changes in the remote data
//     for (var remoteTask in remoteTasks) {
//       var localTask = taskBox.get(remoteTask.id);
//       if (localTask == null || localTask.title != remoteTask.title || localTask.completed != remoteTask.completed) {
//         await taskBox.put(remoteTask.id, remoteTask); // Update local storage
//       }
//     }

//     // Remove any deleted tasks that exist locally but not remotely
//     for (var localTask in localTasks) {
//       if (!remoteTasks.any((remoteTask) => remoteTask.id == localTask.id)) {
//         await taskBox.delete(localTask.id); // Delete outdated local data
//       }
//     }
//   }
// }

// }
