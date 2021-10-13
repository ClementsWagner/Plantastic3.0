import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/widgets/settings_screen/settings.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';
import 'package:plantastic/widgets/station_screen/station_overview.dart';

class Station extends StatefulWidget {
  @override
  _StationState createState() => _StationState();
}

class _StationState extends State<Station> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverTopBar(
      title: LocalLanguages.stations,
      appBarFunctions: {
        Icon(
          Icons.account_circle,
        ): () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        }
      },
      child: StationOverview(),
    );
  }
}