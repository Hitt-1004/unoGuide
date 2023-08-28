import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:unoquide/common/config/shared-services.dart';
import 'package:unoquide/constants.dart';

Future<List<Map<String, dynamic>>> fetchReport(String admNo, String schoolId, String authToken) async {
  String url = '$baseURL/teacher/record/$admNo/$schoolId';
  Uri uri = Uri.parse(url);

  print("auth: $authToken\nadm: $admNo\nschId: $schoolId");

  final response = await http.get(uri, headers: {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $authToken',
  });

  if (response.statusCode == 200) {
    // Parse the response body using jsonDecode
    List<dynamic> data = jsonDecode(response.body);
    print(data);

    // Return the list of maps containing the data
    return List<Map<String, dynamic>>.from(data);
  } else {
    // If the server did not return a 200 OK response,
    // throw an exception or handle the error as per your requirement.
    throw Exception('Failed to load data');
  }
}
