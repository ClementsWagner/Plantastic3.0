import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:plantastic/utils/localizations.dart';
import 'package:plantastic/widgets/notifications_screen/notification_overview.dart';
import 'package:plantastic/widgets/settings_screen/settings.dart';
import 'package:plantastic/widgets/sliver_top_bar.dart';

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {


  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SliverTopBar(
      title: LocalLanguages.notifications,
      appBarFunctions: {
        Icon(
          Icons.account_circle,
        ): () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Settings()));
        }
      },
      child: NotificationOverview(),
    );
  }
}