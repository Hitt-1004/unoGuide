import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoquide/ateachers/models/teacher_model.dart';

import '../../common/constants/constants.dart';

Future<TeacherDataModel> getTeacherData(String authToken) async {
  String url = "$baseURL/teacher/";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  });

  print("getting response from server : ${response.body}");
  print("getting response from server : ${response.statusCode}");
  if (response.statusCode == 200) {
    print("getting response from server : ${response.body}");

    return TeacherDataModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
