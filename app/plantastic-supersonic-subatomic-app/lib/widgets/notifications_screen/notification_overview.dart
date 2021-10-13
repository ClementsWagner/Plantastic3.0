import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/utils/snackbars.dart';

class NotificationOverview extends StatefulWidget {
  @override
  _NotificationOverviewState createState() => _NotificationOverviewState();
}

class _NotificationOverviewState extends State<NotificationOverview> {
  var notifications = [
    "Notification 1",
    "Notification 2",
    "Notification 3",
    "Notification 4",
    "Notification 5",
    "Notification 6",
    "Notification 7",
    "Notification 8",
    "Notification 9",
    "Notification 10",
    "Notification 11",
    "Notification 12",
    "Notification 13",
    "Notification 14",
    "Notification 15",
    "Notification 16",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final item = notifications[index];

          return Dismissible(
            key: Key(item),
            onDismissed: (direction) {
              setState(() {
                notifications.removeAt(index);
              });
              // Scaffold.of(context).showSnackBar(
              // SnackBar(
              //   content: Text("$item dismissed"),
              //   behavior: SnackBarBehavior.floating,
              // ),
              // SnackBar(
              //   content: Container(
              //     decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(10)),
              //     margin: EdgeInsets.fromLTRB(0, 0, 0, 35),
              //     child: Padding(
              //       padding: const EdgeInsets.all(12.0),
              //       child: Text("$item dismissed"),
              //     ),
              //   ),
              //   backgroundColor: Colors.transparent,
              //   backgroundColor: Colors.transparent,
              //   elevation: 1000,
              //   behavior: SnackBarBehavior.floating,
              // ),

              // );
             SnackBars.bottomFlushBar("$item dismissed")..show(context);
            },
            background: Container(color: Colors.red),
            child: ListTile(title: Text('$item')),
          );
        },
      ),
    );
  }
}
