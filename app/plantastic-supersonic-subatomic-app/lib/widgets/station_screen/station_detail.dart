import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/entities/home_station.dart';
import 'package:plantastic/entities/member.dart';
import 'package:plantastic/models/home_station_model.dart';
import 'package:plantastic/utils/dialogs.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/utils/snackbars.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';
import 'package:provider/provider.dart';

class StationDetail extends StatefulWidget {
  const StationDetail({Key key, @required this.homeStation}) : super(key: key);

  @override
  _StationDetailState createState() => _StationDetailState();

  final HomeStation homeStation;
}

class _StationDetailState extends State<StationDetail> {
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
      title: widget.homeStation.name,
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
                          child: Text(widget.homeStation.mac,
                              style: TextStyle(color: Colors.grey)))
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocalLanguages.members,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              Divider(color: Colors.black),
              FutureBuilder(
                future: Provider.of<HomeStationModel>(context, listen: false)
                    .getMembers(widget.homeStation.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: generateList(snapshot.data),
                      padding: EdgeInsets.only(top: 0),
                    );
                  } else {
                    return Container();
                  }
                },
              ),
              Divider(color: Colors.black),
              Align(
                alignment: Alignment.centerLeft,
                child: FlatButton(
                  onPressed: () =>
                      Provider.of<HomeStationModel>(context, listen: false)
                          .unregisterHomeStation(widget.homeStation.id)
                          .then((value) => Navigator.of(context).pop(value)),
                  child: Text(LocalLanguages.leave,
                      style: TextStyle(fontSize: 18, color: Colors.red)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> generateList(List<Member> members) {
    return members
        .map((m) => Card(
              child: ListTile(
                contentPadding: EdgeInsets.only(left: 7),
                leading: Icon(
                  Icons.account_circle,
                  color: Theme.of(context).buttonColor,
                ),
                title: Column(
                  children: <Widget>[
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(m.username ?? "",
                            style: TextStyle(fontSize: 15))),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(m.email ?? "",
                            style: TextStyle(color: Colors.grey, fontSize: 13)))
                  ],
                ),
              ),
            ))
        .toList();
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
            hintText: widget.homeStation.name,
            hintStyle: TextStyle(
              color: Colors.white,
              fontSize: Theme.of(context).textTheme.headline5.fontSize,
            ),
          ),
          onSubmitted: (text) async {
            widget.homeStation.name = text;
            await Dialogs.yesNoDialog(
                context,
                LocalLanguages.onChangeNameTitle,
                LocalLanguages.onChangeNameText,
                onAccept: () =>
                    Provider.of<HomeStationModel>(context, listen: false)
                        .editHomeStation(widget.homeStation).then((value) {
                      if(!value) SnackBars.bottomFlushBar(LocalLanguages.errorDuringRenaming)..show(context);
                    }));
            setState(() {
              enabled = false;
            });
          }),
    );
  }
}
