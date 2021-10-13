import 'package:plantastic/entities/sensor.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
class SensorService {
  static String _connection = "https://api.plantastic.at/api/v1/sensors/homestation";

  static Future<List<Sensor>> getSensors(String token,String id) async {
    final response = await http
        .get(_connection + '/$id', headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return Future.value(list.map((e) =>Sensor.fromJson(e)).toList());
    } else {
      //return Future.value(_testData(id));
      throw Exception('Failed to load Sensors');
    }
  }


  static List<Sensor> _testData(String id) {
    List<Sensor> sensors = [];
    for(int i = 0; i < 4; i++){
      var sensor = Sensor();
      sensor.id = i.toString();
      sensor.displayName = "Sensor " + i.toString();
      sensor.homeStationId = id;
      sensor.moisture = i*3 /10;
      sensor.light = i*3 /10;
      sensor.power = i*3 /10;
      sensors.add(sensor);
    }
    return sensors;
  }

  static Future<bool>  editSensor(String token, Sensor sensor) async {
    final response = await http
        .put(_connection + '', headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(sensor));
    if (response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }


}
