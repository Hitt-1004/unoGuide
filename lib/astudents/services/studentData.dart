import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../common/constants/constants.dart';
import '../models/studentModel.dart';

Future<StudentModel> getStudentData(String authToken) async {
  String url = "$baseURL/student/";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  });
  if (response.statusCode == 200) {
    return StudentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
