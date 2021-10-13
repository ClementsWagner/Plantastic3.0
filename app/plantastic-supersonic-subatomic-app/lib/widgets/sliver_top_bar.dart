import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SliverTopBar extends StatefulWidget {
  const SliverTopBar(
      {Key key,
      @required this.title,
      @required this.child,
      @required this.appBarFunctions,
      this.tabBar, this.tabBarHeight, this.customTitle})
      : super(key: key);

  @override
  _SliverTopBarState createState() => _SliverTopBarState();

  final String title;
  final Widget child;
  final Map<Icon, Function> appBarFunctions;
  final TabBar tabBar;
  final double tabBarHeight;
  final Widget customTitle;
}

class _SliverTopBarState extends State<SliverTopBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overscroll) {
          overscroll.disallowGlow();
          return;
        },
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                iconTheme: IconThemeData(
                  color: Theme.of(context).cursorColor,
                ),
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(50),
                        bottomRight: Radius.circular(50))),
                actions: <Widget>[
                  for (int i = 0; i < widget.appBarFunctions.length; i++)
                    IconButton(
                      icon: widget.appBarFunctions.keys.elementAt(i),
                      onPressed: widget.appBarFunctions.values.elementAt(i),
                    )
                ],
                expandedHeight: 150.0,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  titlePadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 12.0),
                  title: widget.customTitle ?? Text(widget.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize:
                            Theme.of(context).textTheme.headline5.fontSize,
                      )),
                ),
              ),
              if (widget.tabBar != null)
                SliverPersistentHeader(
                  delegate: _SliverAppBarDelegate(
                    widget.tabBar,
                    widget.tabBarHeight
                  ),
                  pinned: true,
                ),
            ];
          },
          body: widget.child,
        ),
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar, this.tabBarHeight);

  final TabBar _tabBar;
  final double tabBarHeight;

  @override
  double get minExtent => tabBarHeight ?? _tabBar.preferredSize.height;

  @override
  double get maxExtent =>  tabBarHeight ?? _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      margin: EdgeInsets.only(top: 5),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
