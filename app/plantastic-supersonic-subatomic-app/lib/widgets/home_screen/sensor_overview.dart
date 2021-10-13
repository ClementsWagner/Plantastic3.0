import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/entities/home_station.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/models/sensor_model.dart';
import 'package:plantastic/widgets/home_screen/sensor_detail/sensor_detail.dart';
import 'package:provider/provider.dart';

class SensorOverview extends StatefulWidget {

  SensorOverview({Key key, @required this.index, @required this.homeStation,}) : super(key: key);

  final int index;

  final HomeStation homeStation;

  @override
  _SensorOverviewState createState() => _SensorOverviewState();
}

class _SensorOverviewState extends State<SensorOverview> {


  @override
  Widget build(BuildContext context) {
    return Consumer<SensorModel>(
      builder: (context, model,child) {
        return Container(
          child: ListView(
            children: generateList(model.getByHomeStationId(widget.homeStation.id)),
            padding: EdgeInsets.only(top: 0),
          ),
        );
      });
  }

  var icons = [
    Icon(
      Icons.sentiment_dissatisfied,
      color: Colors.red,
    ),
    Icon(
      Icons.sentiment_neutral,
      color: Colors.yellow,
    ),
    Icon(
      Icons.sentiment_satisfied,
      color: Colors.green,
    ),
  ];

  var batteries = [
    Icon(
      Icons.battery_alert,
      color: Colors.red,
    ),
    Icon(
      Icons.battery_charging_full,
      color: Colors.yellow,
    ),
    Icon(
      Icons.battery_full,
      color: Colors.green,
    ),
  ];


  List<Widget> generateList(List<Sensor> sensors) {
    List<Widget> list = [];
    if(sensors != null){
      for (var sensor in sensors) {
        list.add(Card(
          child: ListTile(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SensorDetail(sensor: sensor,))),
            contentPadding: EdgeInsets.only(left: 7),
            leading: icons[sensor.moisture <= 1 ? (sensor.moisture *100).toInt() ~/ 34 : 0],
            title: Text(sensor.displayName),
            trailing: batteries[sensor.power <= 1 ? (sensor.power *100).toInt() ~/ 34 : 0],
          ),
        ));
      }
    }
    return list;
  }
}


