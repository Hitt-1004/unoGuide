import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoguide/models/chatMessagesModel.dart';

import '../constants.dart';

Future<List<chatMessages>> getMessages(String authToken, String id) async {
  print("authToken: $authToken");
  print("id: $id");
  String url = "$baseURL/api/message/$id";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  });
  if (response.statusCode == 200) {
    print(response.body);
    //return Message.fromJson(jsonDecode(response.body));
    return parsechatMessages(response.body);
  } else {
    throw Exception('Failed to create post');
  }
}

List<chatMessages> parsechatMessages(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<chatMessages>((json) => chatMessages.fromJson(json)).toList();
}
