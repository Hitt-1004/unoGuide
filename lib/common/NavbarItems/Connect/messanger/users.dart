import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../constants/constants.dart';
import 'chatMessagesModel.dart';


Future<List<User>> getUsers(String authToken, String searchText) async {
  final apiUrl = "$baseURL/api/user";
  try {
    final response = await http.get(Uri.parse(apiUrl), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': authToken,
    });
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      List<User> users = [];

      // Loop through the data to create a list of User objects
      for (var userMap in data) {
        final User user = User.fromJson(userMap);
        if (user.name.toLowerCase().contains(searchText.toLowerCase())) {
          users.add(user);
        }
      }

      return users;
    } else {
      throw Exception('Failed to load users');
    }
  } catch (e) {
    throw Exception('Error fetching users: $e');
  }
}
