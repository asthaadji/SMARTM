import 'dart:convert';
import 'weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService {
  final String apiKey = 'QQnxcTKhgVP0u7MY3MG2z1lF9DHSNSzU';

  Future<List<Weather>> fetchWeather() async {
    final url = Uri.parse(
        'https://api.tomorrow.io/v4/weather/forecast?location=42.3478,-71.0466&apikey=QQnxcTKhgVP0u7MY3MG2z1lF9DHSNSzU'
        );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final dailyWeather = data['timelines']['daily'] as List;
      return dailyWeather.map((weather) => Weather.fromJson(weather)).toList();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
