import 'dart:convert';



import 'online.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnlineData {
  static late SharedPreferences _preferences;
  static const _keyUser = 'online';

  static Online myUser = Online(
    day: "1",
    from: "00:00",
    to:"23:59"

    //it amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat...',
  );

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();


  static Future setUser(Online user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static Online getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : Online.fromJson(jsonDecode(json));
  }
}