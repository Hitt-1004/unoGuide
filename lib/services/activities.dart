import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

class SubjectData {
  String name;
  String percentage;

  SubjectData({required this.name, required this.percentage});

  factory SubjectData.fromJson(Map<String, dynamic> json) {
    return SubjectData(
      name: json['name'],
      percentage: json['percentage'],
    );
  }
}

Future<List<SubjectData>> activityStatus(String admNo, String id) async {
  print("id: $id");
  String url = "$baseURL/student/activityStatus/$admNo/$id";
  Uri uri = Uri.parse(url);

  try{
    var response = await http.get(uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    if (response.statusCode == 200) {
      print(response.body);
      final jsonData = json.decode(response.body);
      List<SubjectData> subjects = [];
      for (var item in jsonData) {
        subjects.add(SubjectData.fromJson(item));
      }
      return subjects;
    } else {
      throw Exception('Failed to create post');
    }
  } catch(err){
    throw Exception('Error: $err');
  }
}

