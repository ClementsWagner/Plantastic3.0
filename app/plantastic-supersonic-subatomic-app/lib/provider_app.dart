import 'package:flutter/material.dart';
import 'package:plantastic/app.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/models/sensor_model.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/utils/settings_provider.dart';
import 'package:provider/provider.dart';



class ProviderApp extends StatefulWidget {


  @override
  _ProviderApp createState() => _ProviderApp();
}

class _ProviderApp extends State<ProviderApp> {

  AuthenticationService authenticationService;
  HomeStationModel homeStationModel;
  @override
  void initState() {
    authenticationService = AuthenticationService();
    homeStationModel = HomeStationModel(authenticationService: authenticationService);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => authenticationService),
          ChangeNotifierProvider(create: (_) => SettingsProvider()),
          ChangeNotifierProvider(create: (_) => homeStationModel),
          ChangeNotifierProvider(create: (_) => SensorModel(authenticationService: authenticationService,homeStationModel: homeStationModel))
        ],
        child: App());
  }
}
