import 'package:flutter/material.dart';

class LocalLanguages {
  LocalLanguages();

  static Locale locale = Locale("en");

  static LocalLanguages load(Locale language) {
    locale = language;
    return LocalLanguages();
  }

  static Map<String, Map<String, Function(String)>> _localizedInterpolations = {
    'en': {
      'editX': (x) => 'Edit $x',
    },
    'de': {
      'editX': (x) => '$x bearbeiten',
    }
  };

  static Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'language': 'Language',
      'settings': 'Settings',
      'year': 'Year',
      'month': 'Month',
      'week': 'Week',
      'day': 'Day',
      'ok': 'OK',
      'cancel': 'CANCEL',
      'no_result': 'No Result!',
      'unknown': 'Unknown',
      'stations': 'Stations',
      'humidity': 'Humidity',
      'data': 'Data',
      'light': 'Light',
      'add_station': 'Add Station',
      'information': 'Information',
      'members': 'Members',
      'mac': 'MAC',
      'password': 'Password',
      'leave': 'Leave',
      'enter_mac': 'Enter MAC',
      'enter_password': 'Enter Password',
      'on_change_name_title': 'Do you really want to rename this station?',
      'on_change_name_text': 'The station will be renamed for everyone.',
      'notifications': 'Notifications',
      'on_add_controller_error': 'Mac or Password is invalid!',
      'login': 'Login',
      'logout': 'Logout',
      'noDataAvailable' : 'No Data available!',
      'errorDuringRenaming' : 'An error occurred during renaming!',
      'time' : 'Time',
      'today' : 'Today',
      'overall' : 'Overall',
      'power' : 'Power',
    },
    'de': {
      'language': 'Sprache',
      'settings': 'Einstellungen',
      'year': 'Jahr',
      'month': 'Monat',
      'week': 'Woche',
      'day': 'Tag',
      'ok': 'OK',
      'cancel': 'ABBRECHEN',
      'no_result': 'Kein Ergebniss!',
      'unknown': 'Unbekannt',
      'stations': 'Stationen',
      'humidity': 'Feuchtigkeit',
      'data': 'Daten',
      'light': 'Licht',
      'add_station': 'Station Hinzufügen',
      'information': 'Information',
      'members': 'Mitglieder',
      'mac': 'MAC',
      'password': 'Passwort',
      'leave': 'Verlassen',
      'enter_mac': 'MAC Eingeben',
      'enter_password': 'Passwort Eingeben',
      'on_change_name_title': 'Möchten sie diese Station wirklich umbenennen?',
      'on_change_name_text': 'Die Station wird für jeden umbennant.',
      'notifications': 'Nachrichten',
      'on_add_controller_error': 'Mac oder Passwort ist ungültig!',
      'login': 'Einloggen',
      'logout': 'Ausloggen',
      'noDataAvailable' : 'Keine Daten verfügbar!',
      'errorDuringRenaming' : 'Beim umbenennen ist ein Fehler aufgetreten!',
      'time' : "Zeit",
      'today' : 'Heute',
      'overall' : 'Allgemein',
      'power' : 'Akkustand',
    },
  };

  static String get languages {
    return _localizedValues[locale.languageCode]['language'];
  }

  static String get settings {
    return _localizedValues[locale.languageCode]['settings'];
  }

  static String get year {
    return _localizedValues[locale.languageCode]['year'];
  }

  static String get month {
    return _localizedValues[locale.languageCode]['month'];
  }

  static String get week {
    return _localizedValues[locale.languageCode]['week'];
  }

  static String get day {
    return _localizedValues[locale.languageCode]['day'];
  }

  static String get ok {
    return _localizedValues[locale.languageCode]['ok'];
  }

  static String get cancel {
    return _localizedValues[locale.languageCode]['cancel'];
  }

  static String get noResult {
    return _localizedValues[locale.languageCode]['no_result'];
  }

  static String get unknown {
    return _localizedValues[locale.languageCode]['unknown'];
  }

  static String get stations {
    return _localizedValues[locale.languageCode]['stations'];
  }

  static String get humidity {
    return _localizedValues[locale.languageCode]['humidity'];
  }

  static String get data {
    return _localizedValues[locale.languageCode]['data'];
  }

  static String get light {
    return _localizedValues[locale.languageCode]['light'];
  }

  static String get addStation {
    return _localizedValues[locale.languageCode]['add_station'];
  }

  static String get information {
    return _localizedValues[locale.languageCode]['information'];
  }

  static String get members {
    return _localizedValues[locale.languageCode]['members'];
  }

  static String get mac {
    return _localizedValues[locale.languageCode]['mac'];
  }

  static String get password {
    return _localizedValues[locale.languageCode]['password'];
  }

  static String get leave {
    return _localizedValues[locale.languageCode]['leave'];
  }

  static String get enterMac {
    return _localizedValues[locale.languageCode]['enter_mac'];
  }

  static String get enterPassword {
    return _localizedValues[locale.languageCode]['enter_password'];
  }

  static String get onChangeNameTitle {
    return _localizedValues[locale.languageCode]['on_change_name_title'];
  }

  static String get onChangeNameText {
    return _localizedValues[locale.languageCode]['on_change_name_text'];
  }

  static String get notifications {
    return _localizedValues[locale.languageCode]['notifications'];
  }

  static String get onAddControllerError {
    return _localizedValues[locale.languageCode]['on_add_controller_error'];
  }

  static String get login {
    return _localizedValues[locale.languageCode]['login'];
  }

  static String get logout {
    return _localizedValues[locale.languageCode]['logout'];
  }

  static String get noDataAvailable {
    return _localizedValues[locale.languageCode]['noDataAvailable'];
  }

  static String get errorDuringRenaming {
    return _localizedValues[locale.languageCode]['errorDuringRenaming'];
  }
  static String get time {
    return _localizedValues[locale.languageCode]['time'];
  }
  static String get today {
    return _localizedValues[locale.languageCode]['today'];
  }
  static String get overall {
    return _localizedValues[locale.languageCode]['overall'];
  }
  static String get power {
    return _localizedValues[locale.languageCode]['power'];
  }


















  static Function(String) get editX {
    return _localizedInterpolations[locale.languageCode]['editX'];
  }
}
