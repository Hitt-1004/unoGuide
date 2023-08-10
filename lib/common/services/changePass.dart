import 'dart:convert';

import 'package:unoquide/common/constants/constants.dart';

import '../models/password.dart';
import 'package:http/http.dart' as http;

Future<Password> changePassword(String pass, String authToken) async {
  Uri uri = Uri.parse('$baseURL/student/change-password');
  var res = http.patch(uri,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: jsonEncode({"password": pass}));
  return res.then((value) => Password.fromJson(jsonDecode(value.body)));
 
}
