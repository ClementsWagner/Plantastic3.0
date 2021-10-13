import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/services/sse_subscriber.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/utils/settings_provider.dart';
import 'package:plantastic/utils/system_language.dart';
import 'package:plantastic/widgets/app_layout.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatefulWidget {
  @override
  _App createState() => _App();
}

class _App extends State<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return refresh();
  }

  Widget login() {
    return FutureBuilder(
        future: Provider.of<AuthenticationService>(context, listen: false)
            .loginAction(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true) {
            return loadApp();
          }
          else if(snapshot.hasError ||(snapshot.hasData && snapshot.data == false)){
            Provider.of<AuthenticationService>(context, listen: false).logoutAction();
            return Container();
          }
          else {
            return Container();
          }
        });
  }

  Widget refresh() {
    return FutureBuilder(
        future: Provider.of<AuthenticationService>(context, listen: false)
            .refreshToken(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data == true && Provider.of<AuthenticationService>(context, listen: false).isLoggedIn) {
            return loadApp();
          }
          else if(snapshot.hasData && snapshot.data == false){
            return login();
          }
          else if(snapshot.hasError){
             Provider.of<AuthenticationService>(context, listen: false).logoutAction();
            return Container();
          }
          else {
            return Container();
          }
        });
  }

  Widget loadApp() {
    Provider.of<HomeStationModel>(context, listen: false).load();
    return Consumer<SettingsProvider>(builder: (context, settings, child) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        localizationsDelegates: [
          const SystemLanguageDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('de', ''),
        ],
        theme: settings.theme,
        home: AppLayout(),
      );
    });
  }
}
