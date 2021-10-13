import 'package:flutter/material.dart';
import 'localizations.dart';

class Dialogs {
  static Future<bool> yesNoDialog(BuildContext context, String title, String text, {String yes, String no, Function() onAccept}) {
      return showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(text),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text(no ?? LocalLanguages.cancel),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text(yes ?? LocalLanguages.ok),
                onPressed: () {
                  onAccept != null ? onAccept() : null;
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
  }
}
