import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoguide/constants.dart';
import 'package:unoguide/models/login.dart';

Future<Login> parentLogin(String email, String password) async {
  String url = "$baseURL/parent/Login";
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
