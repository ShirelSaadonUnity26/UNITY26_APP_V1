import 'dart:convert';

import 'package:unity26_app_v1/database.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserData {
  static late MongoDatabase _mongoDatabase;
  static const _keyUser = 'user';
  static User myUser = User(
    image:
    "https://upload.wikimedia.org/wikipedia/en/0/0b/Darth_Vader_in_The_Empire_Strikes_Back.jpg",
    name: 'Test Test',
    email: 'test.test@gmail.com',
    phone: '(208) 206-5039',
    aboutMeDescription:
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat...',
  );

  static Future init() async =>
      //_preferences = await SharedPreferences.getInstance();
      _mongoDatabase= await MongoDatabase.userCollection;

  static Future setUser(UserBoundary user) async {
    final json = jsonEncode(user.toJson());


  }








}