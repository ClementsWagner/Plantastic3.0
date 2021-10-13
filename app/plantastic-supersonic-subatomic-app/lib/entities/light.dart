import 'package:json_annotation/json_annotation.dart';

part 'light.g.dart';

@JsonSerializable()
class Light {
  String id;
  String sensorId;
  double value;
  DateTime date;

  Light({this.id, this.sensorId, this.value, this.date});

  factory Light.fromJson(Map<String, dynamic> json) =>
      _$LightFromJson(json);

  Map<String, dynamic> toJson() => _$LightToJson(this);
}
