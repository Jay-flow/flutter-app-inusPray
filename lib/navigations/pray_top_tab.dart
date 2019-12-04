import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/pray_card_view.dart';
import 'package:flutter_inus_pray/screen/pray_list_view.dart';

class PrayTopTab extends StatelessWidget {
  static const String id = 'pray_top_tab';

  final List<Widget> prayScreens = [
    PrayListView(),
    PrayCardView(),
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
              tabs: <Widget>[
                Tab(icon: Icon(Icons.list)),
                Tab(icon: Icon(Icons.filter_none)),
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: prayScreens,
        ),
      ),
    );
  }
}
