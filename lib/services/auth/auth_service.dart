import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartm/services/auth/auth_model.dart';

class AuthService {
  final String baseUrl = 'http://109.123.235.25:3178/api/v1/auth';

  Future<User> register(String email, String password, String name) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
        'name': name,
      }),
    );
    if (response.statusCode == 201) {
      final responseData = json.decode(response.body);
      final userJson = responseData['data']['user'];
      if (userJson == null ||
          userJson['name'] == null ||
          userJson['email'] == null) {
        throw Exception('Invalid response data: $responseData');
      }
      return User.fromJson(userJson);
    } else {
      throw Exception('Failed to register user');
    }
  }
}
