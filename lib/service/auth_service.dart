// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:hive/hive.dart';

// class AuthService {
//   final _authBox = Hive.box('authBox');
//   final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

//   Future<void> storeToken(String accessToken, String refreshToken) async {
//     await _authBox.put('accessToken', accessToken);
//     await _authBox.put('refreshToken', refreshToken);
//   }

//   // Future<void> storePassword(String password) async {
//   //   await _secureStorage.write(key: 'appPassword', value: password);
//   // }

//   // Hash and store the password
//   Future<void> storeHashedPassword(String password) async {
//     var bytes = utf8.encode(password); // Convert the password to bytes
//     var hashedPassword = sha256.convert(bytes); // Hash the password

//     // Store the hashed password in Hive
//     await _authBox.put('hashedPassword', hashedPassword.toString());
//   }

//   Future<String?> getToken() async {
//     return _authBox.get('accessToken');
//   }

//   Future<String?> getRefreshToken() async {
//     return _authBox.get('refreshToken');
//   }

//   // Future<String?> getPassword() async {
//   //   return await _secureStorage.read(key: 'appPassword');
//   // }

//     // Retrieve the hashed password
//   Future<String?> getHashedPassword() async {
//     return _authBox.get('hashedPassword');
//   }

//  Future<void> setAdminPassword(String password) async {
//     await _secureStorage.write(key: 'admin_password', value: password);
//   }

//   Future<String?> getAdminPassword() async {
//     return await _secureStorage.read(key: 'admin_password');
//   }

//     Future<void> clearSession() async {
//     await _authBox.delete('accessToken');
//     await _authBox.delete('refreshToken');
//     await _authBox.delete('hashedPassword');
//     // await _secureStorage.delete(key: 'appPassword');
//   }

// }


import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive/hive.dart';

class AuthService {
  final _authBox = Hive.box('authBox');
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<void> storeToken(String userId, String accessToken, String refreshToken) async {
    await _authBox.put('${userId}_accessToken', accessToken);
    await _authBox.put('${userId}_refreshToken', refreshToken);
  }

  // Hash and store the password associated with the user ID
  Future<void> storeHashedPassword(String userId, String password) async {
    var bytes = utf8.encode(password); // Convert the password to bytes
    var hashedPassword = sha256.convert(bytes); // Hash the password
    await _authBox.put('${userId}_hashedPassword', hashedPassword.toString());
  }

  Future<String?> getToken(String userId) async {
    return _authBox.get('${userId}_accessToken');
  }

  Future<String?> getRefreshToken(String userId) async {
    return _authBox.get('userId_refreshToken');
  }

  // Retrieve the hashed password associated with the user ID
  Future<String?> getHashedPassword(String userId) async {
    return _authBox.get('${userId}_hashedPassword');
  }

  // Set and get admin password for password resets
  Future<void> setAdminPassword(String password) async {
    await _secureStorage.write(key: 'admin_password', value: password);
  }

  Future<String?> getAdminPassword() async {
    return await _secureStorage.read(key: 'admin_password');
  }

  // Clear session data for a specific user
  Future<void> clearSession(String userId) async {
    await _authBox.delete('${userId}_accessToken');
    await _authBox.delete('${userId}_refreshToken');
    await _authBox.delete('${userId}_hashedPassword');
  }

  // Retrieve userId from Hive based on stored token or any other key
  Future<String?> getUserId() async {
    // Assuming the userId is part of the keys stored, you can extract it
    // For example, if you store 'userId_accessToken', you can fetch it this way:
    var userIdKey = _authBox.keys.firstWhere((key) => key.endsWith('_accessToken'), orElse: () => null);
    
    if (userIdKey != null) {
      // Extract the userId from the key (userId_accessToken format)
      return userIdKey.split('_')[0]; 
    }
    
    return null; // Return null if no userId is found
  }
  // List all users stored in Hive
  List getAllUsers() {
    return _authBox.keys
        .where((key) => key.endsWith('_hashedPassword')) // Filter to find all user IDs
        .map((key) => key.split('_')[0]) // Extract user IDs
        .toList();
  }
}