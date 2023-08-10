import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/password.dart';

Future<Password> changePassword(String pass, String authToken) async {
  var baseURL = "https://backend.uno-guide.com";
  Uri uri = Uri.parse('$baseURL = /student/change-password');
  var res = http.patch(uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({"password": pass}));
  print(res);
  return res.then((value) => Password.fromJson(jsonDecode(value.body)));
}