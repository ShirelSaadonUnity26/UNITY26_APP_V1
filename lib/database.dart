import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/userBoundary.dart';




class MongoDatabase {
  static var db, userCollection;

  static connect() async {
    var db = await Db.create("mongodb+srv://shirel:UNITY26@cluster0.nbort.mongodb.net/?retryWrites=true&w=majority");
    await db.open();
    userCollection = db.collection(USER_COLLECTION);
    stderr.writeln(userCollection.toString());
  }

  static Future<List<Map<String, dynamic>>> getDocuments() async {
    try {
      final users = await userCollection.find().toList();
      return users;
    } catch (e) {
      return Future.value();
    }
  }

  static insert(UserBoundary user) async {
    await userCollection.insertAll([user.toJson()]);
  }

  static update(UserBoundary user) async {
    var u = await userCollection.findOne({"_id": user.userId});
    u["lastName"] = user.lastName;
    u["firstName"] = user.firstName;
    await userCollection.save(u);
  }


}