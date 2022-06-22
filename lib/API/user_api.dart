import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:unity26_app_v1/constants.dart';
import 'package:unity26_app_v1/models/user.dart';

class UsersApi {
  static Future<List<MyUser>> getUsers() async {

    var client = http.Client();
    try {

      var response = await client.get(
          Uri.http(
              "192.168.1.101:8080", "/users/getAllUsers"),
          headers: kJsonHeaders);
      if (response.statusCode == 200) {
          print(response.body);
          final body = json.decode(response.body);
          return body.map<MyUser>(MyUser.fromJson).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {

      client.close();
    }
  }
  static Future<MyUser> getUserSpecific(String id) async {

    var client = http.Client();
    try {

      var response = await client.get(
          Uri.http(
              "192.168.1.101:8080", "/users/getUser/$id"),
          headers: kJsonHeaders);
      if (response.statusCode == 200) {
        print(response.body);
        final body = json.decode(response.body);
        stderr.writeln(body);
        return body.map<MyUser>(MyUser.fromJson).toList();
      } else {
        // If the server did not return a 200 OK response,
        // then throw an exception.
        throw Exception('Failed to load album');
      }
    } finally {

      client.close();
    }
  }

  static Future<List<MyUser>> getUsersLocally(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');
    final body = json.decode(data);

    return body.map<MyUser>(MyUser.fromJson).toList();
  }
}