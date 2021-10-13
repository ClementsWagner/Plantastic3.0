import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:plantastic/entities/humidity.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/services/sse_subscriber.dart';
import 'package:plantastic/utils/localizations.dart';

class HumidityScreen extends StatefulWidget {
  const HumidityScreen({Key key, @required this.sensor}) : super(key: key);
  final Sensor sensor;

  @override
  _HumidityScreenState createState() => _HumidityScreenState();
}

class _HumidityScreenState extends State<HumidityScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Humidity> _list = [];
  int dv = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Humidity>(
        stream: SseSubscriber<Humidity>( dv == 1 ? "http://10.0.2.2:8080/v1/stream" : "http://10.0.2.2:8080/v1/stream",
            (json) => Humidity.fromJson(json)).streamController.stream,
        builder: (context, data) {
          if (data.hasData) {
            _list.add(data.data);
            this.widget.sensor.moisture = data.data.value;
          }
          return Container(
            padding: EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalLanguages.humidity,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Divider(color: Colors.black),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                        height: 100,
                        child: LiquidCustomProgressIndicator(
                          value: widget.sensor.moisture,
                          valueColor: AlwaysStoppedAnimation(Colors.cyan),
                          backgroundColor: Colors.grey[200],
                          direction: Axis.vertical,
                          center: Text(
                            (widget.sensor.moisture * 100).toInt().toString() +
                                "%",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          shapePath: _path(Size(300, 100)),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalLanguages.data,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Divider(color: Colors.black),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: DropdownButton<int>(
                          value: dv,
                          onChanged: (int newValue) {
                            setState(() {
                              dv = newValue;
                            });
                          },
                          items: [1, 2].map((int value) {
                            return DropdownMenuItem<int>(
                              value: value,
                              child: Text(value == 1
                                  ? LocalLanguages.today
                                  : LocalLanguages.overall),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                        height: 200,
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                        child: charts.TimeSeriesChart(
                            [
                              new charts.Series<Humidity, DateTime>(
                                id: 'humidity',
                                colorFn: (_, __) =>
                                    charts.MaterialPalette.blue.shadeDefault,
                                domainFn: (Humidity humidity, _) =>
                                    humidity.date,
                                measureFn: (Humidity humidity, _) =>
                                    humidity.value,
                                data: _list,
                              )..setAttribute(
                                  charts.rendererIdKey, 'customArea'),
                            ],
                            animate: false,
                            behaviors: [
                              new charts.ChartTitle(
                                  LocalLanguages.humidity + " (%)",
                                  behaviorPosition:
                                      charts.BehaviorPosition.start,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                              new charts.ChartTitle(LocalLanguages.time,
                                  behaviorPosition:
                                      charts.BehaviorPosition.bottom,
                                  titleOutsideJustification: charts
                                      .OutsideJustification.middleDrawArea),
                            ],
                            customSeriesRenderers: [
                              new charts.LineRendererConfig(
                                  // ID used to link series to this renderer.
                                  customRendererId: 'customArea',
                                  includeArea: true,
                                  stacked: true),
                            ]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  Path _buildBoatPath() {
    return Path()
      ..moveTo(15, 120)
      ..lineTo(0, 85)
      ..lineTo(50, 85)
      ..lineTo(60, 80)
      ..lineTo(60, 85)
      ..lineTo(120, 85)
      ..lineTo(105, 120)
      ..close();
  }

  _path(Size size) {
    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.17, size.height);
    path.lineTo(size.width * 0.83, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  static List<charts.Series<Humidity, DateTime>> _createSampleData() {
    final testData = [
      new Humidity(date: new DateTime(2017, 9, 19), value: 0.1),
      new Humidity(date: new DateTime(2017, 9, 26), value: 0.9),
      new Humidity(date: new DateTime(2017, 10, 3), value: 0.3),
      new Humidity(date: new DateTime(2017, 10, 10), value: 0.7),
      new Humidity(date: new DateTime(2017, 10, 19), value: 0.5),
      new Humidity(date: new DateTime(2017, 10, 26), value: 0.9),
      new Humidity(date: new DateTime(2017, 11, 3), value: 0.3),
      new Humidity(date: new DateTime(2017, 11, 10), value: 0.7),
    ];
    return [
      new charts.Series<Humidity, DateTime>(
        id: 'humidity',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (Humidity humidity, _) => humidity.date,
        measureFn: (Humidity humidity, _) => humidity.value,
        data: testData,
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }
}
