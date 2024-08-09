import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:smartm/services/auth/auth_model.dart';

class AuthService {
  final String baseUrl = 'http://109.123.235.25:3178/api/v1/auth';

  Future<UserReg> register(String email, String password, String name) async {
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
      return UserReg.fromJson(userJson);
    } else {
      throw Exception('Failed to register user');
    }
  }

  Future<UserLogin> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to login user');
    }
    final responseData = json.decode(response.body);
    final userJson = responseData['data']['user'];
    final token = responseData['data']['token'];

    if (userJson == null ||
        userJson['email'] == null ||
        userJson['name'] == null ||
        token == null) {
      throw Exception('Invalid response data');
    }
    return UserLogin.fromJson({...userJson, 'token': token});
  }
}
