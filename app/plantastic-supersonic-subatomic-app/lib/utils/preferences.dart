import 'package:shared_preferences/shared_preferences.dart';
class Preferences{

  static SharedPreferences prefs;

  static SharedPreferences get preferences{
    return prefs;
  }

  static set preferences(SharedPreferences preferences){
    prefs = preferences;
  }

  static Future<void> initialize() async{
    prefs = await SharedPreferences.getInstance();
  }

}