class IoTData {
  final int idIot;
  final int windSpeed;
  final int airTemperature;
  final int airHumidity;
  final int soilMoisture;
  final int soilPh;
  final int soilTemperature;
  final bool deviceStatus;

  IoTData({
    required this.idIot,
    required this.windSpeed,
    required this.airTemperature,
    required this.airHumidity,
    required this.soilMoisture,
    required this.soilPh,
    required this.soilTemperature,
    required this.deviceStatus,
  });

  /// Factory method to create an IoTData instance from JSON
  factory IoTData.fromJson(Map<String, dynamic> json) {
    return IoTData(
      idIot: json['id_iot'],
      windSpeed: json['wind_speed'],
      airTemperature: json['air_temperature'],
      airHumidity: json['air_humidity'],
      soilMoisture: json['soil_moisture'],
      soilPh: json['soil_ph'],
      soilTemperature: json['soil_temperature'],
      deviceStatus: json['device_status'] == 1, // Convert 1/0 to bool
    );
  }

  /// Converts an IoTData instance to a Map for SQLite operations
  Map<String, dynamic> toMap() {
    return {
      'id_iot': idIot,
      'wind_speed': windSpeed,
      'air_temperature': airTemperature,
      'air_humidity': airHumidity,
      'soil_moisture': soilMoisture,
      'soil_ph': soilPh,
      'soil_temperature': soilTemperature,
      'device_status': deviceStatus ? 1 : 0, // Convert bool to 1/0
    };
  }

  /// Factory method to create an IoTData instance from SQLite Map
  factory IoTData.fromMap(Map<String, dynamic> map) {
    return IoTData(
      idIot: map['id_iot'],
      windSpeed: map['wind_speed'],
      airTemperature: map['air_temperature'],
      airHumidity: map['air_humidity'],
      soilMoisture: map['soil_moisture'],
      soilPh: map['soil_ph'],
      soilTemperature: map['soil_temperature'],
      deviceStatus: map['device_status'] == 1, // Convert 1/0 to bool
    );
  }
}
