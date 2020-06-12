import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/pray_card_screen.dart';
import 'package:flutter_inus_pray/screen/pray_list.dart';

class PrayTopTab extends StatelessWidget {
  static const String id = 'pray_top_tab';

  final List<Widget> prayScreens = [
    PrayList(),
    PrayCardScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: prayScreens.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            bottom: TabBar(
              indicatorWeight: 4.0,
              tabs: <Widget>[
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.filter_none)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: prayScreens,
        ),
      ),
    );
  }
}
