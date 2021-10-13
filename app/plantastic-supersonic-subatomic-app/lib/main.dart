import 'package:flutter/material.dart';
import 'package:plantastic/provider_app.dart';
import 'package:plantastic/utils/preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initialize();


  runApp(ProviderApp());
}


PageStorageKey homeKey = new PageStorageKey("homeKey");
PageStorageKey stationKey = new PageStorageKey("stationKey");
PageStorageKey notificationKey = new PageStorageKey("notificationKey");
GlobalKey bottomNavigationBarKey = new GlobalKey(debugLabel: "bnb");

