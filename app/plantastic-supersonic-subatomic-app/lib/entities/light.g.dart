// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'light.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Light _$LightFromJson(Map<String, dynamic> json) {
  return Light(
    id: json['id'] as String,
    sensorId: json['sensorId'] as String,
    value: (json['value'] as num)?.toDouble(),
    date: json['date'] == null ? null : DateTime.parse(json['date'] as String),
  );
}

Map<String, dynamic> _$LightToJson(Light instance) => <String, dynamic>{
      'id': instance.id,
      'sensorId': instance.sensorId,
      'value': instance.value,
      'date': instance.date?.toIso8601String(),
    };
