import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/main.dart';
import 'package:plantastic/utils/settings_provider.dart';
import 'package:plantastic/utils/system_language.dart';
import 'package:plantastic/widgets/home_screen/home.dart';
import 'package:plantastic/widgets/notifications_screen/notifications.dart';
import 'package:plantastic/widgets/station_screen/station.dart';
import 'package:provider/provider.dart';

class AppLayout extends StatefulWidget {
  AppLayout({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AppLayoutState createState() => _AppLayoutState();
}

class _AppLayoutState extends State<AppLayout> {
  int _currentIndex = 1;
  final PageStorageBucket _bucket = PageStorageBucket();

  List<Widget> _navigationItems;

  void loadNavigationBar() {
    _navigationItems = <Widget>[
      Icon(
        Icons.notifications_active,
        color: Colors.white,
      ),
      Icon(
        Icons.home,
        color: Colors.white,
      ),
      Icon(
        Icons.router,
        color: Colors.white,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    Provider.of<SettingsProvider>(context, listen: false)
        .loadLocal(SystemLanguage.of(context).locale);
    loadNavigationBar();
    // return Scaffold(
    //   bottomNavigationBar: CurvedNavigationBar(
    //       index: _currentIndex,
    //       backgroundColor: Colors.transparent,
    //       buttonBackgroundColor: Theme.of(context).accentColor,
    //       color: Theme.of(context).bottomAppBarColor,
    //       height: 50,
    //       animationDuration: Duration(milliseconds: 400),
    //       onTap: (int index) {
    //         setState(() {
    //           _currentIndex = index;
    //         });
    //       },
    //       items: _navigationItems),
    //   body: PageStorage(
    //     child: getPage(_currentIndex),
    //     bucket: _bucket,
    //     key: getPageStorageKey(_currentIndex),
    //   ),
    // );
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: PageStorage(
              child: getPage(_currentIndex),
              bucket: _bucket,
              key: getPageStorageKey(_currentIndex),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
              child: CurvedNavigationBar(
                  index: _currentIndex,
                  backgroundColor: Colors.transparent,
                  buttonBackgroundColor: Theme.of(context).accentColor,
                  color: Theme.of(context).bottomAppBarColor,
                  height: 50,
                  animationDuration: Duration(milliseconds: 400),
                  onTap: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  items: _navigationItems),
            ),
          ),
        ],
      ),
    );
  }

  PageStorageKey getPageStorageKey(int index) {
    switch (index) {
      case 0:
        return notificationKey;
      case 1:
        return homeKey;
      case 2:
        return stationKey;
    }
    return null;
  }

  Widget getPage(int index) {
    switch (index) {
      case 0:
        return Notifications();
      case 1:
        return Home();
      case 2:
        return Station();
    }
    return null;
  }
}
