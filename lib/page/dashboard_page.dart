// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:smartm/services/auth/auth_model.dart';
import 'package:smartm/services/iot/iot_model.dart';
import 'package:smartm/services/iot/iot_service.dart';
import 'weather_stuff/weather_screen.dart'; // Ubah impor ini

class DashboardPage extends StatefulWidget {
  final UserLogin user;
  final Function(String) onShowSnackbar;
  const DashboardPage(
      {super.key, required this.user, required this.onShowSnackbar});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  late Future<IoTData> futureIoTData;
  IoTData? selectedData;

  @override
  void initState() {
    super.initState();
    try {
      futureIoTData = fetchIoTData();
    } catch (e) {
      widget.onShowSnackbar('Error fetch IoT data: ${e.toString()}');
    }
  }

  void updateSelectedData(IoTData data) {
    setState(() {
      selectedData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Informasi Cuaca',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              WeatherInfo(),
              const SizedBox(height: 8),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Sensor IoT Tersedia',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              const SizedBox(height: 8),
              IoTSensorList(
                futureIotData: futureIoTData,
                onSelectData: updateSelectedData,
              ),
              selectedData != null
                  ? SensorData(
                      selectedData: selectedData,
                    )
                  : const SizedBox(height: 8)
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherInfo extends StatelessWidget {
  // Ubah menjadi StatelessWidget
  const WeatherInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300, // Sesuaikan ketinggian sesuai kebutuhan
      child: WeatherScreen(), // Gantikan dengan WeatherScreen
    );
  }
}

// ignore: must_be_immutable
class IoTSensorList extends StatefulWidget {
  final Future<IoTData> futureIotData;
  final Function(IoTData) onSelectData;
  const IoTSensorList(
      {super.key, required this.futureIotData, required this.onSelectData});

  @override
  State<StatefulWidget> createState() => _IotSensorList();
}

class _IotSensorList extends State<IoTSensorList> {
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
      child: FutureBuilder<IoTData>(
        future: widget.futureIotData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No IoT data available'));
          } else {
            final data = snapshot.data!;
            if (!data.deviceStatus) return const SizedBox.shrink();
            return Column(
              children: [
                ListView(shrinkWrap: true, children: [
                  ListTile(
                    title: Text('ID IoT: ${data.idIot}'),
                    subtitle: Text(
                        'Status: ${data.deviceStatus ? "Active" : "Inactive"}'),
                    onTap: () {
                      setState(() => widget.onSelectData(data));
                    },
                  )
                ])
              ],
            );
          }
        },
      ),
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
          center: LatLng(-6.9808233, 110.1316992),
          zoom: 15.0,
        ),
        children: [
          TileLayer(
            urlTemplate:
                "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=tWC4SpLdQd1Cz0ch2fvw",
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

// ignore: must_be_immutable
class SensorData extends StatefulWidget {
  IoTData? selectedData;
  SensorData({super.key, required this.selectedData});

  @override
  State<SensorData> createState() => _SensorDataState();
}

class _SensorDataState extends State<SensorData> {
  @override
  Widget build(BuildContext context) {
    if (widget.selectedData == null) {
      return const SizedBox.shrink();
    }
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
      child: Column(
        children: [
          SensorDataTile(
              label: 'Data Kecepatan Angin',
              value: '${widget.selectedData!.windSpeed.toString()} m/s'),
          SensorDataTile(
              label: 'Data Suhu Udara',
              value: '${widget.selectedData!.airTemperature.toString()} °C'),
          SensorDataTile(
              label: 'Data Kelembapan Udara',
              value: '${widget.selectedData!.airHumidity.toString()} %'),
          SensorDataTile(
              label: 'Data pH Tanah',
              value: '${widget.selectedData!.soilPh.toString()} pH'),
          SensorDataTile(
              label: 'Data Kelembapan Tanah',
              value: '${widget.selectedData!.soilMoisture.toString()} %'),
          SensorDataTile(
              label: 'Data Suhu Tanah',
              value: '${widget.selectedData!.soilTemperature.toString()} °C'),
        ],
      ),
    );
  }
}

class SensorDataTile extends StatelessWidget {
  final String label;
  final String value;

  const SensorDataTile({Key? key, required this.label, required this.value})
      : super(key: key);

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
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
