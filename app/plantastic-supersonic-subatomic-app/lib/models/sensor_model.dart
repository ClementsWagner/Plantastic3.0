import 'package:flutter/material.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/services/sensor_service.dart';
import 'package:collection/collection.dart';

class SensorModel extends ChangeNotifier{
  final AuthenticationService authenticationService;
  final HomeStationModel homeStationModel;

  Map<String,List<Sensor>> _sensors;


  SensorModel({
    @required this.authenticationService,
    @required this.homeStationModel,
  }) {
    _sensors = {};
    homeStationModel.addListener(() {
      var ids = homeStationModel.homeStations.map((e) => e.id);
      if(ids.any((e) =>  !_sensors.keys.contains(e)) || _sensors.keys.any((e) => ids.contains(e))){
        if(_sensors.length == 0){
          _loadAll(ids);
        }
        else{
          _sensors.removeWhere((key, value) => !ids.contains(key));
          Future.forEach(ids.where((e) => !_sensors.keys.contains(e)), (e) => _load(e));
        }
      }
    });
    _loadAll(homeStationModel.homeStations.map((e) => e.id).toList());
  }

  Future _loadAll(List<String> ids) async {
    if(authenticationService.isLoggedIn){
      return Future.forEach(ids, (e) async => SensorService.getSensors(await authenticationService.token,e).then((loaded) {
        _sensors[e] = loaded;
        notifyListeners();
      }).catchError((err) {
      }));

    }
  }
  
  Future _load(String id) async {
    if(authenticationService.isLoggedIn){
      return SensorService.getSensors(await authenticationService.token,id).then((loaded) {
        if (!ListEquality().equals(loaded.toList(), _sensors[id].toList())) {
          _sensors[id] = loaded;
          notifyListeners();
        }
      }).catchError((err) {
      });
    }
  }

  Sensor getById(String homeStationId, String id){
    return _sensors[homeStationId]?.firstWhere((e) => e.id == id);
  }

  List<Sensor> getByHomeStationId(String id){
    _load(id);
    return _sensors[id]?.toList();
  }

  void notify() {
    notifyListeners();
  }

  Future<bool> editSensor(Sensor sensor) async {
    return SensorService.editSensor(
        await authenticationService.token, sensor)
        .then((value) {
      if (value) _load(sensor.homeStationId);
      return value;
    });
  }

}