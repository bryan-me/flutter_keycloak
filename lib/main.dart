
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_keycloak/task.dart';
// import 'package:flutter_keycloak/adapters/task_adapter.dart';
import 'package:flutter_keycloak/screens/auth_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());

  await Hive.openBox('authBox');
  // var taskBox = await Hive.openBox<Task>('tasks');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> with WidgetsBindingObserver {
  Timer? _inactivityTimer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _startInactivityTimer(); // Start timer on app launch
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _inactivityTimer?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // App is in background, cancel the inactivity timer
      _inactivityTimer?.cancel();
    } else if (state == AppLifecycleState.resumed) {
      // App is back in the foreground, navigate to AuthScreen for re-authentication
      _navigateToAuthScreen();
    }
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel(); // Cancel any existing timer

    // Start a new timer for 10 seconds (for testing, you can adjust this duration)
    _inactivityTimer = Timer(const Duration(seconds: 10), () {
      // After 10 seconds of inactivity, navigate to the AuthScreen
      _navigateToAuthScreen();
    });
  }

  void _navigateToAuthScreen() {
    print('Inactivity detected. Navigating to AuthScreen...');
    // Navigate to the AuthScreen for re-authentication
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => AuthScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: _startInactivityTimer, // Reset the timer on tap
      onPanDown: (_) => _startInactivityTimer(), // Reset the timer on any pan gesture
      child: MaterialApp(
        home: AuthScreen(), // Start with AuthScreen
        debugShowCheckedModeBanner: false,
        title: 'Keycloak Auth',
      ),
    );
  }
}