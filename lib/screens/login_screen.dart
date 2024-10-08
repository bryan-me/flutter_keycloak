// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_keycloak/screens/main_screen.dart';
// import 'package:flutter_keycloak/service/auth_service.dart';
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService _authService = AuthService();
//   String _username = '';
//   String _password = '';

//   Future<void> _login() async {
//   // Call the Keycloak token API and store the token
//   await createClient();

//   // After successful login, store the tokens in Hive or Shared Preferences
//   await _authService.storeToken('accessToken', 'refreshToken');

//   // Check if the user has already set an app password
//   final savedPassword = await _authService.getPassword();

//   if (savedPassword == null) {
//     // Ask the user to set a password if none is set
//     _setPassword();
//   } else {
//     // Navigate to the main screen if password is already set
//     if (context.mounted) {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const MainScreen()),
//       );
//     }
//   }
// }

// Future<void> createClient() async {
//   final tokenEndpoint = Uri.parse(
//       'http://10.0.2.2:8080/realms/Push/protocol/openid-connect/token');
//   const clientId = 'push-messenger';
//   final username = _username;
//   final password = _password;

//   try {
//     // Send POST request to Keycloak token endpoint
//     final tokenResponse = await http.post(
//       tokenEndpoint,
//       headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//       body: {
//         'grant_type': 'password',
//         'client_id': clientId,
//         'username': username,
//         'password': password,
//       },
//     );

//     if (tokenResponse.statusCode == 200) {
//       // Parse the response body to get the tokens
//       final jsonResponse = json.decode(tokenResponse.body);
//       final accessToken = jsonResponse['access_token'];
//       final refreshToken = jsonResponse['refresh_token'];

//       // Store tokens securely in Hive or another secure storage
//       await _authService.storeToken(accessToken, refreshToken);
//     } else {
//       // Handle error response
//       print('Failed to obtain access token. Status code: ${tokenResponse.statusCode}');
//       throw Exception('Failed to obtain access token');
//     }
//   } catch (e) {
//     // Handle network or server errors
//     print('Error during token exchange: $e');
//     throw Exception('Failed to obtain access token');
//   }
// }

//   void _setPassword() {
//     showDialog(
//       context: context,
//       builder: (context) {
//         String newPassword = '';
//         return AlertDialog(
//           title: const Text("Set a password"),
//           content: TextField(
//             obscureText: true,
//             onChanged: (value) {
//               newPassword = value;
//             },
//             decoration: const InputDecoration(hintText: "Password"),
//           ),
//           actions: [
//             TextButton(
//               child: const Text("Save"),
//               onPressed: () async {
//                 await _authService.storePassword(newPassword);
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushReplacement(
//                   MaterialPageRoute(builder: (context) => const MainScreen()),
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
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 _username = value;
//               },
//               decoration: const InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               obscureText: true,
//               onChanged: (value) {
//                 _password = value;
//               },
//               decoration: const InputDecoration(labelText: "Password"),
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_keycloak/screens/main_screen.dart';
// import 'package:flutter_keycloak/service/auth_service.dart';
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService _authService = AuthService();
//   String _username = '';
//   String _password = '';

//   Future<void> _login() async {
//     await createClient();
//     await _authService.storeToken('accessToken', 'refreshToken');

//     // final savedPassword = await _authService.getPassword();
//     final savedPassword = await _authService.getHashedPassword();
//     if (tokenExchange == 200) {
//       await _authService.storeHashedPassword(_password);
//       Navigator.of(context).pop();
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (context) => const MainScreen()),
//       );
//     } else {
//       //Handle failed login attempt
//     }
//     // if (savedPassword == null) {
//     //   _setPassword();
//     // } else {
//     //   if (context.mounted) {
//     //     Navigator.of(context).pushReplacement(
//     //       MaterialPageRoute(builder: (context) => const MainScreen()),
//     //     );
//     //   }
//     // }
//   }

//   Future<void> createClient() async {
//     final tokenEndpoint = Uri.parse(
//         'http://10.0.2.2:8080/realms/Push/protocol/openid-connect/token');
//     const clientId = 'push-messenger';
//     final username = _username;
//     final password = _password;

//     try {
//       final tokenResponse = await http.post(
//         tokenEndpoint,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {
//           'grant_type': 'password',
//           'client_id': clientId,
//           'username': username,
//           'password': password,
//         },
//       );

//       if (tokenResponse.statusCode == 200) {
//         final jsonResponse = json.decode(tokenResponse.body);
//         final accessToken = jsonResponse['access_token'];
//         final refreshToken = jsonResponse['refresh_token'];

//         await _authService.storeToken(accessToken, refreshToken);
//       } else {
//         print(
//             'Failed to obtain access token. Status code: ${tokenResponse.statusCode}');
//         throw Exception('Failed to obtain access token');
//       }
//     } catch (e) {
//       print('Error during token exchange: $e');
//       throw Exception('Failed to obtain access token');
//     }
//   }

//   // void _setPassword() {
//   //   showDialog(
//   //     context: context,
//   //     builder: (context) {
//   //       String newPassword = '';
//   //       return AlertDialog(
//   //         title: const Text("Set a password"),
//   //         content: TextField(
//   //           obscureText: true,
//   //           onChanged: (value) {
//   //             newPassword = value;
//   //           },
//   //           decoration: const InputDecoration(hintText: "Password"),
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             child: const Text("Save"),
//   //             onPressed: () async {
//   //               // await _authService.storePassword(newPassword);
//   //               await _authService.storeHashedPassword(newPassword);
//   //               Navigator.of(context).pop();
//   //               Navigator.of(context).pushReplacement(
//   //                 MaterialPageRoute(builder: (context) => const MainScreen()),
//   //               );
//   //             },
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }

//   Future<void> _forgotPassword() async {
//     if (_username.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter your username or email')),
//       );
//       return;
//     }

//     final forgotPasswordUrl = Uri.parse(
//         'http://10.0.2.2:8080/realms/Push/login-actions/reset-credentials?client_id=push-messenger&username=$_username');

//     try {
//       final response =
//           await http.get(forgotPasswordUrl); // Use GET instead of POST

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Password reset link sent to your email')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content:
//                   Text('Failed to send reset link: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error sending reset link')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 _username = value;
//               },
//               decoration: const InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               obscureText: true,
//               onChanged: (value) {
//                 _password = value;
//               },
//               decoration: const InputDecoration(labelText: "Password"),
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: _forgotPassword,
//               child: const Text('Forgot Password?'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }


// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_keycloak/screens/main_screen.dart';
// import 'package:flutter_keycloak/service/auth_service.dart';
// import 'package:http/http.dart' as http;

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService _authService = AuthService();
//   String _username = '';
//   String _password = '';

//   Future<void> _login() async {
//     try {
//       // Attempt to create a client and retrieve tokens
//       final tokenExchangeStatus = await createClient();

//       if (tokenExchangeStatus == 200) {
//         // Store hashed password after successful login
//         await _authService.storeHashedPassword(_password);
//         // Navigate to the main screen
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => const MainScreen()),
//         );
//       } else {
//         // Handle failed login attempt
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Login failed. Please try again.')),
//         );
//       }
//     } catch (e) {
//       // Display error message in case of an exception
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error: $e')),
//       );
//     }
//   }

//   Future<int> createClient() async {
//     final tokenEndpoint = Uri.parse(
//         'http://10.0.2.2:8080/realms/Push/protocol/openid-connect/token');
//     const clientId = 'push-messenger';
//     final username = _username;
//     final password = _password;

//     try {
//       final tokenResponse = await http.post(
//         tokenEndpoint,
//         headers: {'Content-Type': 'application/x-www-form-urlencoded'},
//         body: {
//           'grant_type': 'password',
//           'client_id': clientId,
//           'username': username,
//           'password': password,
//         },
//       );

//       if (tokenResponse.statusCode == 200) {
//         final jsonResponse = json.decode(tokenResponse.body);
//         final accessToken = jsonResponse['access_token'];
//         final refreshToken = jsonResponse['refresh_token'];

//         // Store tokens securely
//         await _authService.storeToken(accessToken, refreshToken);
//       } else {
//         print(
//             'Failed to obtain access token. Status code: ${tokenResponse.statusCode}');
//         return tokenResponse.statusCode; // Return status code to handle login status
//       }
//     } catch (e) {
//       print('Error during token exchange: $e');
//       throw Exception('Failed to obtain access token');
//     }

//     return 200; // Return success if everything worked
//   }

//   Future<void> _forgotPassword() async {
//     if (_username.isEmpty) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please enter your username or email')),
//       );
//       return;
//     }

//     final forgotPasswordUrl = Uri.parse(
//         'http://10.0.2.2:8080/realms/Push/login-actions/reset-credentials?client_id=push-messenger&username=$_username');

//     try {
//       final response = await http.get(forgotPasswordUrl);

//       if (response.statusCode == 200) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(
//               content: Text('Password reset link sent to your email')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content:
//                   Text('Failed to send reset link: ${response.statusCode}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Error sending reset link')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               onChanged: (value) {
//                 _username = value;
//               },
//               decoration: const InputDecoration(labelText: "Username"),
//             ),
//             TextField(
//               obscureText: true,
//               onChanged: (value) {
//                 _password = value;
//               },
//               decoration: const InputDecoration(labelText: "Password"),
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('Login'),
//             ),
//             TextButton(
//               onPressed: _forgotPassword,
//               child: const Text('Forgot Password?'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// } 


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_keycloak/screens/main_screen.dart';
import 'package:flutter_keycloak/service/auth_service.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();

  // Using TextEditingController for better state management
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    try {
      // Attempt to create a client and retrieve tokens
      final tokenExchangeStatus = await createClient();

      if (tokenExchangeStatus == 200) {
        // Navigate to the main screen after successful login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } else {
        // Handle failed login attempt
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login failed. Please try again.')),
        );
      }
    } catch (e) {
      // Display error message in case of an exception
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<int> createClient() async {
    final tokenEndpoint = Uri.parse(
        'http://10.0.2.2:8080/realms/Push/protocol/openid-connect/token');
    const clientId = 'push-messenger';
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final tokenResponse = await http.post(
        tokenEndpoint,
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
        body: {
          'grant_type': 'password',
          'client_id': clientId,
          'username': username,
          'password': password,
        },
      );

      if (tokenResponse.statusCode == 200) {
        final jsonResponse = json.decode(tokenResponse.body);
        final accessToken = jsonResponse['access_token'];
        final refreshToken = jsonResponse['refresh_token'];

        // Decode the access token to get the user ID (subject claim 'sub')
        Map<String, dynamic> payload = Jwt.parseJwt(accessToken);
        final userId = payload['sub']; // Extract the user ID

        // Store tokens and user ID securely
        await _authService.storeToken(userId, accessToken, refreshToken);

        // Store the hashed password with the user ID
        await _authService.storeHashedPassword(userId, password);  // Pass password correctly here
      } else {
        print(
            'Failed to obtain access token. Status code: ${tokenResponse.statusCode}');
        return tokenResponse.statusCode;
      }
    } catch (e) {
      print('Error during token exchange: $e');
      throw Exception('Failed to obtain access token');
    }

    return 200;
  }

  Future<void> _forgotPassword() async {
    if (_usernameController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter your username or email')),
      );
      return;
    }

    final forgotPasswordUrl = Uri.parse(
        'http://10.0.2.2:8080/realms/Push/login-actions/reset-credentials?client_id=push-messenger&username=${_usernameController.text}');

    try {
      final response = await http.get(forgotPasswordUrl);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('Password reset link sent to your email')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to send reset link: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error sending reset link')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController, // Use the controller
              decoration: const InputDecoration(labelText: "Username"),
            ),
            TextField(
              controller: _passwordController, // Use the controller
              obscureText: true,
              decoration: const InputDecoration(labelText: "Password"),
            ),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: _forgotPassword,
              child: const Text('Forgot Password?'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}