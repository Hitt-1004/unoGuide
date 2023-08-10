import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../constants/constants.dart';



Future<String> sendEmailAndGetToken(String email) async {
  // Replace the API_URL with the actual API endpoint URL where you want to send the data.
  final apiUrl = '$baseURL/api/user/login';

  // Replace the headers with the appropriate headers required by your API.
  final headers = {
    'Content-Type': 'application/json',
  };

  // Replace the payload with the data you want to send in the request.
  final payload = {
    'email': email,
  };

  try {
    // Make the POST request to the API.
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: jsonEncode(payload),
    );

    // Check if the request was successful (status code 200).
    if (response.statusCode == 200) {
      // Assuming the API returns the response data in JSON format.
      final responseJson = jsonDecode(response.body);
      final token = responseJson['token'] as String;
      return token;
    } else {
      // If the request was not successful, you can handle the error here.
      print('Error: Unable to retrieve token. Status Code: ${response.statusCode}');
      return '';
    }
  } catch (e) {
    // If an exception occurs during the request, handle it here.
    print('Error: Exception occurred during request. ${e.toString()}');
    return '';
  }
}
