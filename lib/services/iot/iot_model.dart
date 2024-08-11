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

  factory IoTData.fromJson(Map<String, dynamic> json) {
    return IoTData(
      idIot: json['id_iot'],
      windSpeed: json['wind_speed'],
      airTemperature: json['air_temperature'],
      airHumidity: json['air_humidity'],
      soilMoisture: json['soil_moisture'],
      soilPh: json['soil_ph'],
      soilTemperature: json['soil_temperature'],
      deviceStatus: json['device_status'],
    );
  }
}
