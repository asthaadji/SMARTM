// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'weather_screen.dart'; // Ubah impor ini

class DashboardPage extends StatelessWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: 
        Image.asset('assets/LogoHorizontal.png',height: 40),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            WeatherInfo(),
            IoTSensorMap(),
            SensorData(),
          ],
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget { // Ubah menjadi StatelessWidget
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Sesuaikan ketinggian sesuai kebutuhan
      child: WeatherScreen(), // Gantikan dengan WeatherScreen
    );
  }
}

class IoTSensorMap extends StatelessWidget {
  const IoTSensorMap({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: FlutterMap(
        options: const MapOptions(
          center: LatLng(-6.9808233,110.1316992),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate: "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=tWC4SpLdQd1Cz0ch2fvw",
            additionalOptions: const {
              'attribution': '© OpenStreetMap contributors',
            },
          ),
          // MarkerLayer(
          //   markers: _createMarkers(),
          // ),
        ],
      ),
    );
  }

  // List<Marker> _createMarkers() {
  //   return [
  //     Marker(
  //       width: 80.0,
  //       height: 80.0,
  //       point: LatLng(-7.250445, 112.768845),
  //       builder: (ctx) => const Icon(Icons.location_on, color: Colors.red, size: 40),
  //     ),
  //     // Tambahkan marker lainnya sesuai kebutuhan
  //   ];
  // }
}

class SensorData extends StatelessWidget {
  const SensorData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: const Column(
        children: [
          SensorDataTile(label: 'Data Kecepatan Angin', value: '12 m/s'),
          SensorDataTile(label: 'Data Suhu Udara', value: '33°C'),
          SensorDataTile(label: 'Data Kelembapan Udara', value: '74%'),
          SensorDataTile(label: 'Data pH Tanah', value: '8 pH'),
          SensorDataTile(label: 'Data Kelembapan Tanah', value: '62%'),
          SensorDataTile(label: 'Data Suhu Tanah', value: '29°C'),
        ],
      ),
    );
  }
}

class SensorDataTile extends StatelessWidget {
  final String label;
  final String value;

  const SensorDataTile({Key? key, required this.label, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
