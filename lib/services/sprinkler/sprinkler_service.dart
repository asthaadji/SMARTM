import 'dart:convert';
import 'package:http/http.dart' as http;
import 'sprinkler_model.dart';

class SprinklerService {
  final String baseUrl = 'http://109.123.235.25:3178/api/v1/sprinkler/status';
  final String apiKey = 'QbibHTE0bSljigQnC828lqtr8YdwGB8F';

  Future<Sprinkler> getSprinklerStatus() async {
    final response = await http.get(Uri.parse(baseUrl), headers: {
      'Content-Type': 'application/json',
      'X-API-KEY': 'QbibHTE0bSljigQnC828lqtr8YdwGB8F',
    });

    if (response.statusCode == 200) {
      return Sprinkler.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load sprinkler status');
    }
  }

  Future<void> switchSprinkler(bool isActive, String authToken) async {
    final response = await http.patch(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authToken',
      },
      body: json.encode([
        {
          'data': {'is_active': isActive}
        }
      ]),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to switch sprinkler status');
    }
  }
}
