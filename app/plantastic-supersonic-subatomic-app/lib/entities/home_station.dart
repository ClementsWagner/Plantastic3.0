import 'package:json_annotation/json_annotation.dart';

part 'home_station.g.dart';

@JsonSerializable()
class HomeStation{
  String id;
  String mac;
  String name;

  HomeStation();


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HomeStation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          mac == other.mac &&
          name == other.name;

  @override
  int get hashCode => id.hashCode ^ mac.hashCode ^ name.hashCode;

  factory HomeStation.fromJson(Map<String, dynamic> json) => _$HomeStationFromJson(json);
  Map<String, dynamic> toJson() => _$HomeStationToJson(this);
}