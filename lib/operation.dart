import 'dart:convert';
import 'dart:async';
import 'user_new.dart';
import 'package:http/http.dart' as http;

Future<List<UserNew>> fetchFruit() async {
  final response = await http.get(
      Uri.http("192.168.1.104:8080", "/users/getAllUsers"));
  if (response.statusCode == 200) {
    return decodeUser(response.body);
  } else {
    throw Exception('Unable to fetch data from the REST API');
  }
}

List<UserNew> decodeUser(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<UserNew>((json) =>UserNew.fromMap(json)).toList();
}

// Future<UserNew> updateFruit(String title) async {
//   final http.Response response = await http.put(
//       Uri.http("192.168.1.104:8080", "/users/getAllUsers"),
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, String>{
//       'title': title,
//     }),
//   );
//
//   if (response.statusCode == 200) {
//     return UserNew.fromJson(json.decode(response.body));
//   } else {
//     throw Exception('Failed to update album.');
//   }
// }

Future<UserNew> sendFruit(
String id, String phone,
String name,
String lastName,
String birthday,
    int vv
    ) async {
  final http.Response response = await http.post(
    Uri.http("192.168.1.104:8080", "/users/signUp"),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      '_id': id,
      'phone': phone,
      'firstName': name,
      'lastName': lastName,
      'birthday': birthday,
      '__v':vv.toString()
    }),
  );
  if (response.statusCode == 201) {
    return UserNew.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
Future<UserNew> deleteAlbum(String id) async {
  final http.Response response = await http.delete(
      Uri.http("192.168.1.104:8080", "/users/delete/$id"),

    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
  );

  if (response.statusCode == 200) {
    return UserNew.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to delete album.');
  }
}