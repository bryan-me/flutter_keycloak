


// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:flutter_keycloak/screens/login_screen.dart';
// import 'package:flutter_keycloak/screens/main_screen.dart';
// import 'package:flutter_keycloak/service/auth_service.dart';

// class AuthScreen extends StatefulWidget {
//   @override
//   _AuthScreenState createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final AuthService _authService = AuthService();
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage(); // Secure storage instance
//   String _password = '';
//   int _failedAttempts = 0;
//   final int _maxAttempts = 3; // Maximum allowed attempts before password reset is offered

//   @override
//   void initState() {
//     super.initState();
//     _initializeApp();
//   }

//    Future<void> _initializeApp() async {
//     // Set the admin password securely during app initialization
//     await _authService.setAdminPassword('SuperSecretAdminPassword123!');
    
//     // Check the session
//     _checkSession();
//   }

//   Future<void> _checkSession() async {
//     final token = await _authService.getToken();
//     // final savedPassword = await _authService.getPassword();
//     final savedPassword = await _authService.getHashedPassword();

//     if (token != null && savedPassword != null) {
//       // If token exists, ask for the password
//       _promptForPassword();
//     } else {
//       // No session, show login screen
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const LoginScreen()),
//       );
//     }
//   }

//   void _promptForPassword() {
//     if (Navigator.canPop(context)) {
//       Navigator.pop(context);
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Enter your password"),
//           content: TextField(
//             obscureText: true,
//             onChanged: (value) {
//               _password = value;
//             },
//             decoration: const InputDecoration(hintText: "Password"),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Submit"),
//               onPressed: () async {
//                 // final savedPassword = await _authService.getPassword();
//                 final savedPassword = await _authService.getHashedPassword();

//                 //Hash entered password
//                 final enteredPasswordHash = _hashPassword(_password);
//                 if (enteredPasswordHash == savedPassword) {
//                   // Password is correct, proceed to the main app
//                   Navigator.of(context).pop();
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (context) => MainScreen()),
//                   );
//                 } else {
//                   // Increment failed attempts
//                   _failedAttempts++;
//                   // Check if max attempts reached
//                   if (_failedAttempts >= _maxAttempts) {
//                     _promptForPasswordReset();
//                   } else {
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Incorrect password. Attempt $_failedAttempts/$_maxAttempts")),
//                     );
//                     _promptForPassword(); // Reopen the password prompt
//                   }
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _promptForPasswordReset() {
//     if (Navigator.canPop(context)) {
//       Navigator.pop(context);
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Password Reset"),
//           content: const Text("You've exceeded the maximum attempts. Please enter the admin password to reset your password."),
//           actions: [
//             TextButton(
//               child: const Text("Enter Admin Password"),
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _promptForAdminPassword(); // Prompt for admin password
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Prompt user for the admin password to allow password reset
//   void _promptForAdminPassword() {
//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Enter Admin Password"),
//           content: TextField(
//             obscureText: true,
//             onChanged: (value) {
//               _password = value;
//             },
//             decoration: const InputDecoration(hintText: "Admin Password"),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Submit"),
//               onPressed: () async {
//                 final adminPassword = await _secureStorage.read(key: 'admin_password');
//                 if (_password == adminPassword) {
//                   // Admin password is correct, proceed with password reset
//                   Navigator.of(context).pop();
//                   _resetUserPassword(); // Trigger password reset
//                 } else {
//                   // Show error for incorrect admin password
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(content: Text("Incorrect admin password")),
//                   );
//                   _promptForAdminPassword(); // Reopen admin password prompt
//                 }
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Reset user's password logic
//   void _resetUserPassword() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("Reset Password"),
//           content: TextField(
//             obscureText: true,
//             onChanged: (value) {
//               _password = value;
//             },
//             decoration: const InputDecoration(hintText: "New Password"),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Submit"),
//               onPressed: () async {
//                 // await _authService.storePassword(_password); // Save the new password
//                 await _authService.storeHashedPassword(_password);
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   const SnackBar(content: Text("Password reset successfully")),
//                 );
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => const LoginScreen()),
//                 );
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

// String _hashPassword(String password) {
//   return sha256.convert(utf8.encode(password)).toString();
// }


import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_keycloak/screens/login_screen.dart';
import 'package:flutter_keycloak/screens/main_screen.dart';
import 'package:flutter_keycloak/service/auth_service.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  // final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
   String _selectedUser = '';
  String _password = '';
  List<String> _users = [];
  int _failedAttempts = 0;
  final int _maxAttempts = 3;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Set admin password during app initialization if needed
    await _authService.setAdminPassword('SuperSecretAdminPassword123!');
    
    // Get all users stored in Hive
    // _users = _authService.getAllUsers();
    // Cast the returned list to List<String>
  _users = _authService.getAllUsers().cast<String>();
    
    if (_users.isNotEmpty) {
      // If users exist, prompt user to select an account
      _showUserSelection();
    } else {
      // No users found, navigate to login screen for a new account
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  // Show dialog to choose existing user or new login
  void _showUserSelection() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Continue with these users"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Display a list of users
              if (_users.isNotEmpty)
                ..._users.map((user) => ListTile(
                  title: Text(user),
                  onTap: () {
                    _selectedUser = user;
                    _promptForPassword();
                  },
                )),
              const Divider(),
              ListTile(
                title: const Text("Log in as a new user"),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const LoginScreen()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _promptForPassword() {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Enter your password"),
          content: TextField(
            obscureText: true,
            onChanged: (value) {
              _password = value;
            },
            decoration: const InputDecoration(hintText: "Password"),
          ),
          actions: [
            TextButton(
              child: const Text("Submit"),
              onPressed: _checkPassword,
            ),
          ],
        );
      },
    );
  }

  String _hashPassword(String password) {
    return sha256.convert(utf8.encode(password)).toString();
  }

  // Check if entered password is correct
  Future<void> _checkPassword() async {
    final savedPasswordHash = await _authService.getHashedPassword(_selectedUser);
    final enteredPasswordHash = _hashPassword(_password);

    if (enteredPasswordHash == savedPasswordHash) {
      // Password matches, reset failed attempts and navigate to main screen
      _failedAttempts = 0;
      Navigator.of(context).pop(); // Close dialog
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      // Incorrect password
      _failedAttempts++;
      if (_failedAttempts >= _maxAttempts) {
        // After max failed attempts, force re-login
        _promptReLogin();
      } else {
        // Provide feedback for incorrect password and allow retry
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Incorrect password, please try again.")),
        );
      }
    }
  }

  // Prompt for re-login after too many failed attempts
  void _promptReLogin() {
    Navigator.of(context).pop(); // Close the password dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Too many failed attempts"),
          content: const Text("Please log in again."),
          actions: [
            TextButton(
              child: const Text("Re-Login"),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}