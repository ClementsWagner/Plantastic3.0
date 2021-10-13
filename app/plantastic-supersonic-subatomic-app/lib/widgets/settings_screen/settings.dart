import 'package:flutter/material.dart';
import 'package:plantastic/app.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/utils/settings_provider.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {
  bool get _darkTheme =>
      _settingsProvider.theme == _settingsProvider.dark ? true : false;

  String get language =>
      LocalLanguages.locale.languageCode == "en" ? "English" : "Deutsch";
  SettingsProvider _settingsProvider;

  Future _askLanguage(BuildContext context) async {
    String tempLan = await showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: new Text(LocalLanguages.languages),
            children: <Widget>[
              new SimpleDialogOption(
                child: new Text('EN'),
                onPressed: () {
                  Navigator.pop(context, "en");
                },
              ),
              new SimpleDialogOption(
                child: new Text('DE'),
                onPressed: () {
                  Navigator.pop(context, "de");
                },
              ),
            ],
          );
        });
    if (tempLan != null && tempLan != "") {
      setState(() {
        LocalLanguages.load(Locale(tempLan));
        _settingsProvider.language = Locale(tempLan);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _settingsProvider = Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
        appBar: AppBar(
          title: Text(
            LocalLanguages.settings,
            style: TextStyle(color: Theme.of(context).cursorColor),
          ),
          iconTheme: IconThemeData(
            color: Theme.of(context).cursorColor,
          ),
        ),
        body: ListView(
          padding: EdgeInsets.all(3),
          children: <Widget>[
            Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: FutureBuilder(
                  future:
                  Provider.of<AuthenticationService>(context, listen: false)
                      .userInfo,
                  builder: (context, info) {
                    if (info.hasData) {
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            CircleAvatar(
                                backgroundColor: Colors.yellow,
                                child: Text(
                                    (info.data.name ?? " ").toString()[0])),
                            Container(
                              height: 7,
                            ),
                            Text(info.data.name ?? ""),
                            Text(info.data.email ?? ""),
                          ],
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                )),
            Divider(color: Colors.black),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                children: <Widget>[
                  Text(
                    "Darkmode",
                    style: TextStyle(fontSize: 18),
                  ),
                  Switch(
                    value: _darkTheme,
                    activeTrackColor: Colors.grey,
                    activeColor: Colors.lightGreen,
                    onChanged: (value) {
                      setState(() {
                        if (_darkTheme == true) {
                          _settingsProvider.setLight();
                        } else {
                          _settingsProvider.setDark();
                        }
                      });
                    },
                  )
                ],
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  children: <Widget>[
                    FlatButton(
                      child: Column(
                        children: <Widget>[
                          Text(LocalLanguages.languages,
                              style: TextStyle(fontSize: 18)),
                          Text(language, style: TextStyle(color: Colors.grey))
                        ],
                      ),
                      onPressed: () => _askLanguage(context),
                    ),
                  ],
                )),
            Align(
              alignment: Alignment.centerLeft,
              child: FlatButton(
                onPressed: () async {
                  Provider.of<AuthenticationService>(context, listen: false)
                      .logoutAction()
                      .then((value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (c) => App()),
                          (route) => false));
                },
                child: Text(LocalLanguages.logout,
                    style: TextStyle(fontSize: 18, color: Colors.red)),
              ),
            )
          ],
        ));
  }
}
