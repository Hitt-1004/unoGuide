import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoquide/models/parentModel.dart';

import '../constants.dart';

Future<ParentModel> getParentData(String authToken) async {
  print("authToken: $authToken");
  String url = "$baseURL/parent/";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': authToken,
  });
  if (response.statusCode == 200) {
    print(response.body);
    return ParentModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to create post');
  }
}
