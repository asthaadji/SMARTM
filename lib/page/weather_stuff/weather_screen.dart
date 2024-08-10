import 'package:flutter/material.dart';
import '../../services/weather/weather_model.dart';
import '../../services/weather/weather_services.dart';
import 'package:intl/intl.dart'; // Pastikan kamu menambahkan ini di pubspec.yaml untuk memformat tanggal

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  Future<List<Weather>>? _weatherData;

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    setState(() {
      _weatherData = _weatherService.fetchWeather(42.3478, -71.0466);
    });
  }

  List<Weather> _filterWeatherByDay(List<Weather> weatherList) {
    List<Weather> filteredWeather = [];
    String? lastDate;

    for (var weather in weatherList) {
      String currentDate =
          DateFormat('yyyy-MM-dd').format(DateTime.parse(weather.date));

      if (lastDate != currentDate) {
        filteredWeather.add(weather);
        lastDate = currentDate;
      }
    }

    return filteredWeather;
  }

  String _getDisplayDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    final DateTime today = DateTime.now();
    final DateTime tomorrow = today.add(Duration(days: 1));

    if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(today)) {
      return "Hari Ini";
    } else if (DateFormat('yyyy-MM-dd').format(date) ==
        DateFormat('yyyy-MM-dd').format(tomorrow)) {
      return "Besok";
    } else {
      return DateFormat('yyyy-MM-dd').format(date);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: FutureBuilder<List<Weather>>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            // Filter cuaca berdasarkan hari
            List<Weather> filteredWeather = _filterWeatherByDay(snapshot.data!);

            return Scrollbar(
              child: ListView.builder(
                scrollDirection:
                    Axis.horizontal, // Menjadikan ListView horizontal
                itemCount: filteredWeather.length,
                itemBuilder: (context, index) {
                  final weather = filteredWeather[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 150, // Lebar container untuk setiap item
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 5.0,
                            spreadRadius: 2.0,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            weather.description == 'Clear'
                                ? Icons.wb_sunny
                                : Icons.cloud,
                            size: 100.0,
                            color: weather.description == 'Clear'
                                ? Colors.orange
                                : const Color.fromARGB(255, 207, 207, 207),
                          ),
                          SizedBox(height: 10),
                          Text(
                            _getDisplayDate(weather.date),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "${weather.temperature}°F",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Precipitation: ${weather.precipitation}%',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Wind: ${weather.windSpeed} mph',
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
