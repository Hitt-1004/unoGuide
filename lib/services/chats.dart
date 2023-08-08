import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:unoguide/models/chatModel.dart';

import '../constants.dart';

Future<List<Chat>> getChats(String authToken) async {
  print("authToken: $authToken");
  String url = "$baseURL/api/chat";
  Uri uri = Uri.parse(url);
  var response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  });
  if (response.statusCode == 200) {
    print(response.body);
    //return Message.fromJson(jsonDecode(response.body));
    final List<dynamic> jsonData = jsonDecode(response.body);
    return jsonData.map((json) => Chat.fromJson(json)).toList();
  } else {
    throw Exception('Failed to create post');
  }
}

Future<Chat> addChats(String authToken, String userId) async {
  print("authToken: $authToken");
  String url = "$baseURL/api/chat";
  Uri uri = Uri.parse(url);

  final payload = {"userId": userId};

  var response = await http.post(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  }, body: jsonEncode(payload));
  if (response.statusCode == 200) {
    print(response.body);
    //return Message.fromJson(jsonDecode(response.body));
    final jsonData = jsonDecode(response.body);
    return Chat.fromJson(jsonData);
  } else {
    throw Exception('Failed to create post');
  }
}
