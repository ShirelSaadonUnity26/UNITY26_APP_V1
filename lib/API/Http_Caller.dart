import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:http/http.dart' as http;
import 'package:unity26_app_v1/constants.dart';

import 'dart:convert';

import 'package:unity26_app_v1/models/userBoundary.dart';


// ---------- User Related API ---------------

void createNewUser(String _id, String phone, String firstName,String lastName,
    void onLoaded(dynamic userBoundary)) async {
  var client = http.Client();

  try {
    var uriResponse = await client.post(
        Uri.http("10.0.2.2:8080", "/users/signUp"),
        body: jsonEncode({
          '_id': _id,
          'phone': phone,
          'firstName': firstName,
          'lastName': lastName
        }),
        headers: kJsonHeaders);

    onLoaded(UserBoundary.fromJson(jsonDecode(uriResponse.body)));
  } catch (e) {
    onLoaded("Error");
  } finally {
    client.close();
  }
}
Future<UserBoundary> update1(String userId,String birthday) async {
  final http.Response response = await http.patch(
    Uri.http(
        "10.0.2.2:8080", "/users/updateUser1/$userId"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'birthday': birthday,
    }),
  );

  if (response.statusCode == 200) {
    return UserBoundary.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<void> getUser(String userId,
    void onLoaded (dynamic userBoundary)) async {
  var client = http.Client();
  try {
    var uriResponse = await client.get(
        Uri.http(
            "10.0.2.2:8080", "/users/getUser/$userId"),
        headers: kJsonHeaders);

    var x= onLoaded(UserBoundary.fromJson(jsonDecode(uriResponse.body)));
    stderr.writeln(onLoaded);
    stderr.writeln(uriResponse.body);

  } finally {

    client.close();
  }
}