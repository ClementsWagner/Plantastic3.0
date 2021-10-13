// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_station.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeStation _$HomeStationFromJson(Map<String, dynamic> json) {
  return HomeStation()
    ..id = json['id'] as String
    ..mac = json['mac'] as String
    ..name = json['name'] as String;
}

Map<String, dynamic> _$HomeStationToJson(HomeStation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'mac': instance.mac,
      'name': instance.name,
    };
