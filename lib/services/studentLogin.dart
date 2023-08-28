import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoquide/constants.dart';
import 'package:unoquide/models/login.dart';

Future<Login> studentLogin(String email, String password) async {
  String url = "$baseURL/student/Login";
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}));
  if (response.statusCode == 200) {
    print("Fetched Data successfully");
    return Login.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
