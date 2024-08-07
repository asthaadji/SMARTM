import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  final String baseUrl = 'https://api.tomorrow.io/v4/weather/forecast';
  final String apiKey = 'QQnxcTKhgVP0u7MY3MG2z1lF9DHSNSzU';

  Future<List<Weather>> fetchWeather(double latitude, double longitude) async {
    final url =
        Uri.parse('$baseUrl?location=$latitude,$longitude&apikey=$apiKey');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      List<Weather> weatherList = (data['timelines']['hourly'] as List)
          .map((item) => Weather.fromJson(item))
          .toList();
      return weatherList;
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
