import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/widgets/home_screen/sensor_detail/humidity_screen.dart';
import 'package:plantastic/widgets/home_screen/sensor_detail/light_screen.dart';
import 'package:plantastic/widgets/home_screen/sensor_detail/sensor_settings.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';

class SensorDetail extends StatefulWidget {
  const SensorDetail({Key key, @required this.sensor}) : super(key: key);

  @override
  _SensorDetailState createState() => _SensorDetailState();

  final Sensor sensor;
}

class _SensorDetailState extends State<SensorDetail>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverTopBar(
      title: widget.sensor.displayName,
      appBarFunctions: {
        Icon(
          Icons.settings,
        ): () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SensorSettings(sensor: widget.sensor)));
        }
      },
      tabBarHeight: 30,
      tabBar: TabBar(
          controller: controller,
          unselectedLabelColor: Theme.of(context).accentColor,
          indicatorSize: TabBarIndicatorSize.label,
          indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Theme.of(context).accentColor),
          tabs: [
            for (int i = 0; i < 2; i++)
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(color: Theme.of(context).accentColor, width: 1)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(""),
                  ),
                ),
              ),
          ]),
      child: TabBarView(
        controller: controller,
        children: [
          HumidityScreen(sensor: widget.sensor,),
          LightScreen(sensor: widget.sensor,),
        ],
      ),
    );
  }
}
