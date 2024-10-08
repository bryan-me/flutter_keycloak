// import 'dart:convert';
// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_keycloak/adapters/task.dart'; // Import the correct Task model
// import 'package:hive/hive.dart';
// import 'package:http/http.dart' as http;

// class TaskScreen extends StatefulWidget {
//   const TaskScreen({super.key});

//   @override
//   State<TaskScreen> createState() => _TaskScreenState();
// }

// class _TaskScreenState extends State<TaskScreen> {
//   List<Task> tasks = [];
//   bool isLoading = true;
//   bool isSyncing = false;

//   @override
//   void initState() {
//     super.initState();
//     // Load tasks from local storage
//     loadLocalTasks();
//     // Setup connectivity listener for auto-sync
//     setupConnectivityListener();
//   }

//   // Load tasks from Hive
//   Future<void> loadLocalTasks() async {
//     var taskBox = await Hive.openBox<Task>('tasks');
//     setState(() {
//       tasks = taskBox.values.toList();
//       isLoading = false;
//     });
//   }

//   // Fetch and sync tasks with remote server
//   Future<void> syncTasksWithRemote() async {
//     setState(() {
//       isSyncing = true;
//     });

//     try {
//       final response = await http.get(Uri.parse('https://api.example.com/tasks'));
//       if (response.statusCode == 200) {
//         List<Task> remoteTasks = parseTasks(response.body);

//         var taskBox = await Hive.openBox<Task>('tasks');
//         await taskBox.clear(); // Clear old tasks
//         for (var task in remoteTasks) {
//           await taskBox.put(task.id, task);
//         }

//         setState(() {
//           tasks = remoteTasks;
//         });
//       }
//     } catch (e) {
//       print('Error fetching data: $e');
//     }

//     setState(() {
//       isSyncing = false;
//     });
//   }

//  void setupConnectivityListener() {
//     // Listen for connectivity changes
//     Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//       if (result != ConnectivityResult.none) {
//         syncTasksWithRemote(); // Sync tasks only when there is connectivity
//       }
//     } as void Function(List<ConnectivityResult> event)?);
//   }




//   // Parse JSON to Task model
//   List<Task> parseTasks(String responseBody) {
//     final List<dynamic> parsed = json.decode(responseBody);
//     return parsed.map<Task>((json) => Task.fromJson(json as Map<String, dynamic>)).toList();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Tasks'),
//         actions: [
//           IconButton(
//             icon: isSyncing
//                 ? CircularProgressIndicator(color: Colors.white)
//                 : const Icon(Icons.sync),
//             onPressed: syncTasksWithRemote,
//           ),
//         ],
//       ),
//       body: isLoading
//           ? const Center(child: CircularProgressIndicator())
//           : tasks.isEmpty
//               ? const Center(child: Text('No tasks available'))
//               : ListView.builder(
//                   itemCount: tasks.length,
//                   itemBuilder: (context, index) {
//                     return ListTile(
//                       title: Text(tasks[index].title),
//                       subtitle: Text(tasks[index].completed
//                           ? 'Completed'
//                           : 'Pending'),
//                     );
//                   },
//                 ),
//     );
//   }
// }
