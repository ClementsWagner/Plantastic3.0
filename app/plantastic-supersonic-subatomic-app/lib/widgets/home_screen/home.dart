import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/widgets/home_screen/sensor_overview.dart';
import 'package:plantastic/widgets/settings_screen/settings.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;

  @override
  void initState() {
    controller = PageController(
      initialPage: currentIndex,
      keepPage: false,
    );
    super.initState();
  }

  PageController controller;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStationModel>(
        builder: (context, homeStationModel, child) {
      var stations = homeStationModel.homeStations;
      return stations.length > 0
          ? SliverTopBar(
              title: stations[currentIndex]?.name,
              appBarFunctions: {
                Icon(
                  Icons.account_circle,
                ): () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                }
              },
              child: PageView.builder(
                controller: controller,
                onPageChanged: (page) => setState(() {
                  currentIndex = page;
                }),
                itemBuilder: (context, index) {
                  return SensorOverview(
                    index: index,
                    homeStation: stations[index],
                  );
                },
                physics: BouncingScrollPhysics(),
                itemCount: stations.length,
              ),
            )
          : SliverTopBar(
              title: "Plantastic",
              appBarFunctions: {
                Icon(
                  Icons.account_circle,
                ): () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Settings()));
                }
              },
              child: Container(),
            );
    });
  }
}
