import 'dart:convert';

import 'package:unoquide/common/constants/constants.dart';
import 'package:unoquide/common/models/login.dart';
import 'package:http/http.dart' as http;

Future<StudentLogin> student_login(String email, String password) async {
  String url = "$baseURL/student/Login";
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}));

  return StudentLogin.fromJson(jsonDecode(response.body));
}

Future<StudentLogin> teacher_login(String email, String password) async {
  print("email: $email, password: $password");
  String url = "$baseURL/teacher/Login";
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}));
  print("response from login: ${response.body}");
  print("response from login: ${response.statusCode}");
  if (response.statusCode == 200) {
    return StudentLogin.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}

Future<StudentLogin> parent_login(String email, String password) async {
  String url = "$baseURL/parent/Login";
  var response = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}));
  if (response.statusCode == 200) {
    print("Fetched Data successfully");
    return StudentLogin.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
