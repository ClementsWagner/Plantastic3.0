// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'humidity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Humidity _$HumidityFromJson(Map<String, dynamic> json) {
  return Humidity(
    id: json['id'] as String,
    sensorId: json['sensorId'] as String,
    value: (json['value'] as num)?.toDouble(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$HumidityToJson(Humidity instance) => <String, dynamic>{
      'id': instance.id,
      'sensorId': instance.sensorId,
      'value': instance.value,
      'date': instance.date?.toIso8601String(),
    };
