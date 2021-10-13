import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:plantastic/entities/humidity.dart';
import 'package:plantastic/entities/light.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/services/sse_subscriber.dart';
import 'package:plantastic/utils/localizations.dart';

class LightScreen extends StatefulWidget {
  const LightScreen({Key key, @required this.sensor}) : super(key: key);
  final Sensor sensor;

  @override
  _LightScreenState createState() => _LightScreenState();
}

class _LightScreenState extends State<LightScreen> {
  @override
  void initState() {
    super.initState();
  }

  List<Light> _list = [];
  int dv = 1;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Light>(
        stream: SseSubscriber<Light>(
            dv == 1
                ? "http://10.0.2.2:8080/v1/stream"
                : "http://10.0.2.2:8080/v1/stream",
            (json) => Light.fromJson(json)).streamController.stream,
        builder: (context, data) {
          if (data.hasData) {
            _list.add(data.data);
            this.widget.sensor.light = data.data.value;
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
                          LocalLanguages.light,
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      Divider(color: Colors.black),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 20, 0, 30),
                        height: 250 / 1.5,
                        child: LiquidCustomProgressIndicator(
                          value: widget.sensor.light,
                          valueColor: AlwaysStoppedAnimation(Colors.yellow),
                          backgroundColor: Colors.grey[200],
                          direction: Axis.vertical,
                          center: Text(
                            "       " +
                                (widget.sensor.light * 100).toInt().toString() +
                                "%",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                          shapePath: _path(Size(300 / 1.5, 250 / 1.5)),
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
                              new charts.Series<Light, DateTime>(
                                id: 'light',
                                colorFn: (_, __) =>
                                charts.MaterialPalette.yellow.shadeDefault,
                                domainFn: (Light light, _) =>
                                light.date,
                                measureFn: (Light light, _) =>
                                light.value,
                                data: _list,
                              )..setAttribute(
                                  charts.rendererIdKey, 'customArea'),
                            ],
                            animate: false,
                            behaviors: [
                              new charts.ChartTitle(
                                  LocalLanguages.light + " (%)",
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
                      ),
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
      ..lineTo(105, 120) //and back to the origin, could not be necessary #1
      ..close();
  }

  _path(Size size) {
    Path path = Path();
    path.moveTo(size.width * 0.33, size.height);
    path.lineTo(size.width * 0.67, size.height);
    path.quadraticBezierTo(size.width * 0.67, size.height * 0.85,
        size.width * 0.67, size.height * 0.80);
    path.cubicTo(size.width * 0.65, size.height * 0.61, size.width * 0.74,
        size.height * 0.50, size.width * 0.77, size.height * 0.40);
    path.cubicTo(size.width * 0.85, size.height * 0.10, size.width * 0.62,
        size.height * 0.00, size.width * 0.50, 0);
    path.cubicTo(size.width * 0.38, size.height * 0.00, size.width * 0.15,
        size.height * 0.10, size.width * 0.23, size.height * 0.40);
    path.cubicTo(size.width * 0.27, size.height * 0.57, size.width * 0.35,
        size.height * 0.61, size.width * 0.33, size.height * 0.80);
    path.quadraticBezierTo(
        size.width * 0.34, size.height * 0.85, size.width * 0.33, size.height);
    path.close();
    return path;
  }

  static List<charts.Series<LinearSales, int>> _createSampleData() {
    final myFakeDesktopData = [
      new LinearSales(0, 5),
      new LinearSales(1, 25),
      new LinearSales(2, 100),
      new LinearSales(3, 75),
    ];
    return [
      new charts.Series<LinearSales, int>(
        id: 'humidity',
        colorFn: (_, __) => charts.MaterialPalette.yellow.shadeDefault,
        domainFn: (LinearSales sales, _) => sales.year,
        measureFn: (LinearSales sales, _) => sales.sales,
        data: myFakeDesktopData,
      )
        // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
    ];
  }
}

class LinearSales {
  final int year;
  final int sales;

  LinearSales(this.year, this.sales);
}
