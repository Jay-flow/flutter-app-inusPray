import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/pray_card.dart';
import 'package:flutter_inus_pray/screen/pray_list.dart';

class PrayTopTab extends StatelessWidget {
  static const String id = 'pray_top_tab';

  final List<Widget> prayScreens = [
    PrayCard(),
    PrayList(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: prayScreens.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: <Widget>[
                Container(
                  height: 58,
                  child: Center(
                    child: Tab(
                      icon: Icon(
                        Icons.filter_none,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 58,
                  child: Center(
                    child: Tab(
                      icon: Icon(
                        Icons.list,
                      ),
                    ),
                  ),
                ),
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
