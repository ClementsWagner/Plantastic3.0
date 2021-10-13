import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:plantastic/entities/home_station.dart';
import 'package:plantastic/entities/member.dart';

class HomeStationService {
  static String _connection = "https://api.plantastic.at/api/v1/homestations";

  static Future<List<HomeStation>> getHomeStations(String token) async {
    final response = await http
        .get(_connection + "", headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return Future.value(list.map((e) =>HomeStation.fromJson(e)).toList());
    } else {
      throw Exception('Failed to load homeStation');
    }
  }

  static Future<bool> registerHomeStation(String token, String mac, String password) async{
    final response = await http
        .post(_connection + '/register', headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(<String, String>{'mac' : mac, 'password' : password}));
    if (response.statusCode == 201 || response.statusCode == 200) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static Future<bool> unregisterHomeStation(String token, String id) async{
    final response = await http
        .get(_connection + '/$id/unregister', headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'});
    if (response.statusCode == 204) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static Future<bool> editHomeStation(String token, HomeStation homeStation) async{
    final response = await http
        .put(_connection + '', headers: {'Authorization': 'Bearer $token', 'Content-Type': 'application/json; charset=UTF-8'}, body: jsonEncode(homeStation));
    if (response.statusCode == 204) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  static Future<List<Member>> getMembers(String token, String id) async {
    final response = await http
        .get(_connection + '/$id/members', headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      Iterable list = json.decode(response.body);
      return Future.value(list.map((e) => Member.fromJson(e)).toList());
    } else {
      throw Exception('Failed to load Members');
    }
  }
}

