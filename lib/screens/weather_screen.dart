import 'package:flutter/material.dart';
import 'weather_model.dart';
import 'weather_services.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Weather>>(
        future: _weatherData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final weather = snapshot.data![index];
                return ListTile(
                  title:
                      Text('${weather.temperature}°F - ${weather.description}'),
                  subtitle: Text(
                      'Precipitation: ${weather.precipitation}% | Wind: ${weather.windSpeed} mph'),
                  trailing: Text(weather.date),
                );
              },
            );
          }
        },
      ),
    );
  }
}
