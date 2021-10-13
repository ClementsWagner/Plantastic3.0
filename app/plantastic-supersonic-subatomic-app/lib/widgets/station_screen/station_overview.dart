import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/entities/home_station.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/services/authentication_service.dart';
import 'package:plantastic/services/home_station_service.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/widgets/qr_code_scanner.dart';
import 'package:plantastic/widgets/station_screen/station_detail.dart';
import 'package:provider/provider.dart';

class StationOverview extends StatefulWidget {
  @override
  _StationOverviewState createState() => _StationOverviewState();
}

class _StationOverviewState extends State<StationOverview> {

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeStationModel>(
        builder: (context, homeStationModel,child) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: generateList(homeStationModel.homeStations),
                      padding: EdgeInsets.only(top: 0),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        elevation: 0,
                        backgroundColor: Theme
                            .of(context)
                            .accentColor,
                        onPressed: () => addStationDialog(),
                      ),
                    ),
                  ],
                ),
              ),
            );
        }
    );
  }

  List<Widget> generateList(List<HomeStation> stations) {
    List<Widget> list = [];
    for (int i = 0; i < stations.length; i++) {
      list.add(Card(
        child: ListTile(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StationDetail(homeStation: stations[i]))),
          contentPadding: EdgeInsets.only(left: 7),
          leading: Container(
            width: 25.0,
            height: 25.0,
            decoration: new BoxDecoration(
              color: i == 2 ? Colors.red : Colors.green,
              shape: BoxShape.circle,
            ),
          ),
          title: Text(stations[i].name),
        ),
      ));
    }
    return list;
  }

  Future addStationDialog() {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        TextEditingController mac;
        TextEditingController password;
        bool error = false;
        final _key = GlobalKey<FormState>();

        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(LocalLanguages.addStation),
              IconButton(
                icon: Icon(Icons.qr_code),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => QrCodeScanner())).then((value) async {
                  if (value != null) {
                    print(value);
                    try{
                      if(await Provider.of<HomeStationModel>(context, listen: false).registerHomeStation(value.toString().split(",")[0], value.toString().split(",")[1])){
                        Navigator.of(context).pop(true);
                      }
                      else{
                        setState(() {
                          mac.text = value.toString().split(",")[0];
                          password.text = value.toString().split(",")[1];
                        });
                      }
                    }catch(e){}
                  }
                  setState(() {
                    error = true;
                    _key.currentState.validate();
                  });
                }),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: _key,
              child: ListBody(
                children: <Widget>[
                  TextFormField(
                    validator: (value) {
                      if (error) {
                        return LocalLanguages.onAddControllerError;
                      }
                      return null;
                    },
                    controller: mac = new TextEditingController(),
                    decoration:
                        InputDecoration(hintText: LocalLanguages.enterMac),
                  ),
                  TextFormField(
                    validator: (value) {
                      if (error) {
                        return LocalLanguages.onAddControllerError;
                      }
                      return null;
                    },
                    controller: password = new TextEditingController(),
                    decoration:
                        InputDecoration(hintText: LocalLanguages.enterPassword),
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(LocalLanguages.cancel),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text(LocalLanguages.ok),
              onPressed: () async {
                if(await Provider.of<HomeStationModel>(context, listen: false).registerHomeStation(mac.text, password.text)){
                  Navigator.of(context).pop(true);
                }
                else{
                  setState(() {
                    error = true;
                    _key.currentState.validate();
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }
}

