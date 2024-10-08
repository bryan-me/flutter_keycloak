// import 'package:flutter/material.dart';
// import 'package:flutter_keycloak/screens/login_screen.dart';
// import 'package:flutter_keycloak/service/auth_service.dart';

// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     AuthService _authService = AuthService();

//     Future<void> logout() async {
//   await _authService.clearSession();
//   Navigator.of(context).pushReplacement(
//     MaterialPageRoute(builder: (context) => LoginScreen()),
//   );

// }
//    return  Scaffold(
//       body: Center(
//         child: 
//         Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const Text("This is the mainscreen"),
        
//          ElevatedButton(
//               onPressed: logout,
//               child: const Text('Logout'),
//             ),
//           ],
//         )
        
//       ),
      
//     );

    
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_keycloak/screens/login_screen.dart';
import 'package:flutter_keycloak/service/auth_service.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService _authService = AuthService();

    Future<void> logout() async {
      // Assuming the user ID or token is needed for the clearSession method
      final userId = await _authService.getUserId(); // Fetch userId or token from AuthService

      await _authService.clearSession(userId!); // Pass the userId or required argument
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("This is the main screen"),
            ElevatedButton(
              onPressed: logout,
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}