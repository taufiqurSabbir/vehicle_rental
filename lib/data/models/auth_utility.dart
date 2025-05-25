import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vehicle_rental/data/models/user_model.dart';

class AuthUtlity {
  AuthUtlity._();

  static UserModel userInfo = UserModel();

  /// Save user info
  static Future<void> saveUserInfo(UserModel model) async {
    final _sharep = await SharedPreferences.getInstance();
    await _sharep.setString('user-data', jsonEncode(model.toJson()));
  }

  /// Retrieve user info
  static Future<UserModel?> getUserInfo() async {
    final _sharep = await SharedPreferences.getInstance();
    final value = _sharep.getString('user-data');

    if (value != null) {
      return UserModel.fromJson(jsonDecode(value));
    }
    return null;
  }

  /// Check login and load user info if exists
  static Future<bool> checkUserLogin() async {
    final _sharep = await SharedPreferences.getInstance();
    final hasData = _sharep.containsKey('user-data');

    if (hasData) {
      final user = await getUserInfo();
      if (user != null) {
        userInfo = user;
        return true;
      }
    }
    return false;
  }

  /// Clear user data (logout)
  static Future<void> clearUserInfo() async {
    final _sharep = await SharedPreferences.getInstance();
    await _sharep.remove('user-data');
    userInfo = UserModel(); // clear current session
  }
}
