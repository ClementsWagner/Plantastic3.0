import 'package:flutter/material.dart';
import 'package:plantastic/entities/sensor.dart';
import 'package:plantastic/models/sensor_model.dart';
import 'package:plantastic/utils/dialogs.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/utils/snackbars.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';
import 'package:provider/provider.dart';

class SensorSettings extends StatefulWidget {
  final Sensor sensor;

  const SensorSettings({Key key, @required this.sensor}) : super(key: key);

  @override
  _SensorSettingsState createState() => _SensorSettingsState();
}

class _SensorSettingsState extends State<SensorSettings> {
  TextEditingController _controller;
  FocusNode _focusNode;
  bool enabled = false;

  @override
  void initState() {
    _controller = TextEditingController();
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverTopBar(
      title: widget.sensor.displayName,
      customTitle: titleWidget(),
      appBarFunctions: {
        Icon(
          Icons.edit,
        ): () {
          setState(() {
            enabled = true;
            WidgetsBinding.instance
                .addPostFrameCallback((_) => _focusNode.requestFocus());
          });
        }
      },
      child: Container(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocalLanguages.information,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Divider(color: Colors.black),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(LocalLanguages.mac,
                            style: TextStyle(fontSize: 18)),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(widget.sensor.mac,
                              style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(LocalLanguages.power,
                            style: TextStyle(fontSize: 18)),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text((widget.sensor.power *100).toInt().toString() + " %",
                              style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget titleWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: TextField(
          focusNode: _focusNode,
          controller: _controller,
          textAlign: TextAlign.center,
          enabled: enabled,
          style: TextStyle(
              color: Theme.of(context).cursorColor,
              fontSize: Theme.of(context).textTheme.headline5.fontSize),
          decoration: InputDecoration(
            border: enabled ? null : InputBorder.none,
            hintText: widget.sensor.displayName,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
            ),
          ),
          onSubmitted: (text) async {
            widget.sensor.displayName = text;
            await Dialogs.yesNoDialog(context, LocalLanguages.onChangeNameTitle,
                LocalLanguages.onChangeNameText,
                onAccept: () => Provider.of<SensorModel>(context, listen: false)
                    .editSensor(widget.sensor)
                    .then((value) {
                      if(!value) SnackBars.bottomFlushBar(LocalLanguages.errorDuringRenaming)..show(context);
                }));
            setState(() {
              enabled = false;
            });
          }),
    );
  }
}
