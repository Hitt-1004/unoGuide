import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoguide/models/studentModel.dart';

import '../constants.dart';

Future<Student> getStudentData(String authToken) async {
  print("authToken: $authToken");
  String url = "$baseURL/student/";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': authToken,
  });
  if (response.statusCode == 200) {
    print(response.body);
    return Student.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
