import 'package:json_annotation/json_annotation.dart';

part 'humidity.g.dart';

@JsonSerializable()
class Humidity {
  String id;
  String sensorId;
  double value;
  DateTime date;

  Humidity({this.id, this.sensorId, this.value, this.date});

  factory Humidity.fromJson(Map<String, dynamic> json) =>
      _$HumidityFromJson(json);

  Map<String, dynamic> toJson() => _$HumidityToJson(this);
}
