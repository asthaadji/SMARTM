import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smartm/services/iot/iot_model.dart';

Future<IoTData> fetchIoTData() async {
  final response = await http.get(
    Uri.parse('http://109.123.235.25:3178/api/v1/iot/monitoring'),
  );

  if (response.statusCode == 200) {
    final jsonData = jsonDecode(response.body);
    final data = jsonData['data'];

    return IoTData.fromJson(data);
  } else {
    throw Exception('Failed to Load IoT data');
  }
}
