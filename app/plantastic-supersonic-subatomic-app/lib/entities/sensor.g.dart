// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sensor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sensor _$SensorFromJson(Map<String, dynamic> json) {
  return Sensor()
    ..id = json['id'] as String
    ..homeStationId = json['homeStationId'] as String
    ..displayName = json['displayName'] as String
    ..moisture = (json['moisture'] as num)?.toDouble()
    ..light = (json['light'] as num)?.toDouble()
    ..power = (json['power'] as num)?.toDouble()
    ..available = json['available'] as bool
    ..mac = json['mac'] as String;
}

Map<String, dynamic> _$SensorToJson(Sensor instance) => <String, dynamic>{
      'id': instance.id,
      'homeStationId': instance.homeStationId,
      'displayName': instance.displayName,
      'moisture': instance.moisture,
      'light': instance.light,
      'power': instance.power,
      'available': instance.available,
      'mac': instance.mac,
    };
