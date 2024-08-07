class Weather {
  final String date;
  final double temperature;
  final String description;
  final double precipitation;
  final double windSpeed;

  Weather({
    required this.date,
    required this.temperature,
    required this.description,
    required this.precipitation,
    required this.windSpeed,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['time'],
      temperature: (json['values']['temperature'] as num).toDouble(),
      description: json['values']['weatherCode'] == 1000 ? 'Clear' : 'Cloudy',
      precipitation:
          (json['values']['precipitationProbability'] as num).toDouble(),
      windSpeed: (json['values']['windSpeed'] as num).toDouble(),
    );
  }
}
