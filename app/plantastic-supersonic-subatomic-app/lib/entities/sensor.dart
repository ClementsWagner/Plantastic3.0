import 'package:json_annotation/json_annotation.dart';
part 'sensor.g.dart';

@JsonSerializable()
class Sensor{
  String id;
  String homeStationId;
  String displayName;
  double moisture;
  double light;
  double power;
  bool available;
  String mac;


  Sensor();

  factory Sensor.fromJson(Map<String, dynamic> json) => _$SensorFromJson(json);
  Map<String, dynamic> toJson() => _$SensorToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Sensor &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          homeStationId == other.homeStationId &&
          displayName == other.displayName &&
          moisture == other.moisture &&
          light == other.light &&
          power == other.power &&
          available == other.available &&
          mac == other.mac;

  @override
  int get hashCode =>
      id.hashCode ^
      homeStationId.hashCode ^
      displayName.hashCode ^
      moisture.hashCode ^
      light.hashCode ^
      power.hashCode ^
      available.hashCode ^
      mac.hashCode;
}