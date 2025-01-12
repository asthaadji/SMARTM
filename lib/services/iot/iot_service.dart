import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:smartm/services/iot/iot_model.dart';

class IoTDatabaseHelper {
  static final IoTDatabaseHelper _instance = IoTDatabaseHelper._internal();

  factory IoTDatabaseHelper() => _instance;

  IoTDatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'iot_data.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE iot_data (
            id_iot INTEGER PRIMARY KEY AUTOINCREMENT,
            wind_speed INTEGER NOT NULL,
            air_temperature INTEGER NOT NULL,
            air_humidity INTEGER NOT NULL,
            soil_moisture INTEGER NOT NULL,
            soil_ph INTEGER NOT NULL,
            soil_temperature INTEGER NOT NULL,
            device_status INTEGER NOT NULL
          )
        ''');

        // Insert dummy data for demonstration purposes
        await db.insert('iot_data', {
          'id_iot': 1,
          'wind_speed': 10,
          'air_temperature': 25,
          'air_humidity': 60,
          'soil_moisture': 70,
          'soil_ph': 7,
          'soil_temperature': 20,
          'device_status': 1, // 1 for true, 0 for false
        });

        await db.insert('iot_data', {
          'id_iot': 2,
          'wind_speed': 12,
          'air_temperature': 22,
          'air_humidity': 65,
          'soil_moisture': 75,
          'soil_ph': 6,
          'soil_temperature': 18,
          'device_status': 0, // 1 for true, 0 for false
        });
      },
    );
  }

  /// Fetch all IoT data records from the database
  Future<List<IoTData>> getAllIoTData() async {
    final db = await database;
    final results = await db.query('iot_data');

    return results.map((row) => IoTData.fromMap(row)).toList();
  }

  /// Fetch a single IoT data record by ID
  Future<IoTData?> getIoTDataById(int id) async {
    final db = await database;
    final results = await db.query(
      'iot_data',
      where: 'id_iot = ?',
      whereArgs: [id],
    );

    if (results.isNotEmpty) {
      return IoTData.fromMap(results.first);
    } else {
      return null;
    }
  }

  /// Insert new IoT data into the database
  Future<int> insertIoTData(IoTData data) async {
    final db = await database;
    return await db.insert('iot_data', data.toMap());
  }

  /// Update an existing IoT data record
  Future<int> updateIoTData(IoTData data) async {
    final db = await database;
    return await db.update(
      'iot_data',
      data.toMap(),
      where: 'id_iot = ?',
      whereArgs: [data.idIot],
    );
  }

  /// Delete an IoT data record by ID
  Future<int> deleteIoTData(int id) async {
    final db = await database;
    return await db.delete(
      'iot_data',
      where: 'id_iot = ?',
      whereArgs: [id],
    );
  }
}

/// Fetch the first available IoT data record (simplified example)
Future<IoTData> fetchIoTData() async {
  final dbHelper = IoTDatabaseHelper();
  final List<IoTData> iotDataList = await dbHelper.getAllIoTData();

  if (iotDataList.isNotEmpty) {
    return iotDataList.first;
  } else {
    throw Exception('No IoT data available');
  }
}
