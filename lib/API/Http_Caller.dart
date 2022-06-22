import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:unity26_app_v1/constants.dart';
import 'dart:convert';
import 'package:unity26_app_v1/models/userBoundary.dart';


// ---------- User Related API --------------- //

void createNewUser(String _id, String phone, String firstName,String lastName,
    void Function(dynamic userBoundary) onLoaded) async {
  var client = http.Client();

  try {
    var uriResponse = await client.post(
        Uri.http("192.168.1.101:8080", "/users/signUp"),
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

void signUpUser(String _id, String phone,
    void Function(dynamic userBoundary) onLoaded) async {
  var client = http.Client();

  try {
    var uriResponse = await client.post(
        Uri.http("192.168.1.101:8080", "/users/signUp11"),
        body: jsonEncode({
          '_id': _id,
          'phone': phone,
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
        "192.168.1.101:8080", "/users/updateUser1/$userId"),
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

Future<UserBoundary> updateUserDetails(String userId, String firstName,String lastName) async {
  final http.Response response = await http.patch(
    Uri.http(
        "192.168.1.101:8080", "/users/updateUser1/$userId"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'firstName': firstName,
      'lastName':lastName,
    }),
  );
  if (response.statusCode == 200) {
    return UserBoundary.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}

Future<void> getUser(String userId,
    void Function(dynamic userBoundary) onLoaded) async {
  var client = http.Client();
  try {
    var uriResponse = await client.get(
        Uri.http(
            "192.168.1.101:8080", "/users/getUser/$userId"),
        headers: kJsonHeaders);


    var x= onLoaded(UserBoundary.fromJson(jsonDecode(uriResponse.body)));
    stderr.writeln('DDDDDDDDDDDD');
    stderr.writeln(onLoaded.toString());
    stderr.writeln(uriResponse.body);

  } finally {

    client.close();
  }
}
Future<UserBoundary> update2(String userId,String address) async {
  final http.Response response = await http.patch(
    Uri.http(
        "192.168.1.101:8080", "api/users/updateUser1/$userId"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'address': address,
    }),
  );
  if (response.statusCode == 200) {
    return UserBoundary.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to update album.');
  }
}
  Future<void> updateLocation(
      String userId,
      Address address,
      ) async {
    var client = http.Client();

    try {
      await client.patch(
          Uri.http(
              "192.168.1.101:8080", "/users/updateUserAddress/$userId"),
          body: jsonEncode({
            'address': address.toJson()
          }),
          headers: kJsonHeaders);
    } finally {
      client.close();
    }
  }
Future<void> updateAssistant(
    String userId,
     Assistant assistant
    ) async {
  var client = http.Client();

  try {
    await client.patch(
        Uri.http(
            "192.168.1.101:8080", "/users/usersAssistant/$userId"),
        body: jsonEncode({
          'assistant': assistant.toJson()
        }),
        headers: kJsonHeaders);
  } finally {
    client.close();
  }
}



Future<void> updateArrayOfCategory(
    String userId,
    Assistant assistant,
    List c
    ) async {
  var client = http.Client();

  try {
    await client.patch(
        Uri.http(
            "192.168.1.101:8080", "users/updateArrayOfCategory/$userId"),
        body: jsonEncode({
          'assistant': assistant.toJson(),
        }),
        headers: kJsonHeaders);
  } finally {
    client.close();
  }
}











void loginValidUser(String userId, void onLoaded(dynamic userBoundary)) async {
  var client = http.Client();

  try {
    print("/users/getUser/$userId");
    var uriResponse = await client.get(
        Uri.http("172.20.10.3:8080", "/users/getUserS/$userId"),
        headers: kJsonHeaders);
    onLoaded(UserBoundary.fromJson(jsonDecode(uriResponse.body)));
  } catch (e) {
    onLoaded("Error");
  } finally {
    client.close();
  }
}
Future<UserBoundary> fetchAlbum(String userId,void onLoaded(dynamic userBoundary)) async {
  var client = http.Client();

  try {
    print("/users/getUser/$userId");
    var uriResponse = await client.get(
        Uri.http("172.20.10.3:8080", "/users/getUserS/$userId"),
        headers: kJsonHeaders);
     onLoaded(UserBoundary.fromJson(jsonDecode(uriResponse.body)));
    return UserBoundary.fromJson(jsonDecode(uriResponse.body));
  } catch (e) {
    onLoaded("Error");
    throw Exception('Failed to load album');
  } finally {
    client.close();
  }
}









