import 'package:flutter/material.dart';
import 'package:plantastic/entities/home_station.dart';
import 'package:plantastic/entities/member.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/services/home_station_service.dart';
import 'package:collection/collection.dart';

class HomeStationModel extends ChangeNotifier {
  final AuthenticationService authenticationService;

  List<HomeStation> _homeStations;

  List<HomeStation> get homeStations {
    load();
    return _homeStations.toList();
  }

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  HomeStationModel({
    @required this.authenticationService,
    List<HomeStation> homeStations,
  }) : _homeStations = homeStations ?? [];

  Future load() async {
    if (!_isLoading && authenticationService.isLoggedIn) {
      _isLoading = true;
      return HomeStationService.getHomeStations(
              await authenticationService.token)
          .then((loaded) {
        if (!ListEquality().equals(loaded, _homeStations)) {
          _homeStations.clear();
          _homeStations.addAll(loaded);
          notifyListeners();
          _isLoading = false;
        }
      }).catchError((err) {
        _isLoading = false;
      });
    }
  }

  Future<bool> registerHomeStation(String mac, String password) async {
    return HomeStationService.registerHomeStation(
            await authenticationService.token, mac, password)
        .then((value) {
      if (value) load();
      return value;
    });
  }

  Future<bool> unregisterHomeStation(String id) async {
    return HomeStationService.unregisterHomeStation(
            await authenticationService.token, id)
        .then((value) {
      if (value) load();
      return value;
    });
  }

  Future<bool> editHomeStation(HomeStation homeStation) async {
    return HomeStationService.editHomeStation(
            await authenticationService.token, homeStation)
        .then((value) {
      if (value) load();
      return value;
    });
  }

  HomeStation getById(String id) {
    return _homeStations.firstWhere((element) => element.id == id,
        orElse: null);
  }

  Future<List<Member>> getMembers(String id) async {
    return HomeStationService.getMembers(await authenticationService.token, id);
  }

  void notify() {
    notifyListeners();
  }
}
