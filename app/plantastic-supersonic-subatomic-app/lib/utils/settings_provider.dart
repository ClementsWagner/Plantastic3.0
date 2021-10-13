import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plantastic/utils/preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'localizations.dart';

class SettingsProvider extends ChangeNotifier {

  ThemeData light = ThemeData(brightness: Brightness.light, primarySwatch: Colors.lightGreen, accentColor: Colors.deepOrange, bottomAppBarColor: Colors.lightGreen, cursorColor: Colors.white);

  ThemeData dark = ThemeData(brightness: Brightness.dark, primarySwatch: Colors.lightGreen, accentColor: Colors.deepOrange, bottomAppBarColor: ThemeData.dark().bottomAppBarColor, cursorColor:  Colors.white);


  void loadLocal(Locale sysLocal) {
    SharedPreferences prefs = Preferences.preferences;
    String lang = prefs.get("language");
    if (lang != null) {
      LocalLanguages.load(Locale(lang));
    } else {
      LocalLanguages.load(sysLocal);
    }
  }

  ThemeData _currentTheme;

  ThemeData get theme {
    if (_currentTheme == null) {
      SharedPreferences prefs = Preferences.preferences;
      _currentTheme = prefs.get("theme") == "darktheme"
          ? dark
          : light;
    }

    return _currentTheme;
  }

  set theme(ThemeData theme) {
    Preferences.preferences.setString(
        "theme", theme == light ? "lighttheme" : "darktheme");
    _currentTheme = theme;
    notifyListeners();
  }

  void setDark(){
    this.theme = dark;
  }

  void setLight(){
    this.theme = light;
  }

  set language(Locale language) {
    SharedPreferences prefs = Preferences.preferences;
    LocalLanguages.load(language);
    prefs.setString("language", language.languageCode);
    notifyListeners();
  }
}
