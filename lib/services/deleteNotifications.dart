import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants.dart';

Future<void> deleteNotification(String authToken, String userId, String notificationId) async {
  print("authToken: $authToken");
  print("id: $notificationId");
  String url = "$baseURL/notification/deleteMyNotification/$notificationId";
  Uri uri = Uri.parse(url);

  final payload = {
      "userId": userId,
      "role": "parent"
  };

  var response = await http.delete(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': authToken,
  }, body: jsonEncode(payload));

  if (response.statusCode == 200) {
    print(response.body);
  } else {
    throw Exception('Failed to create post');
  }
}

