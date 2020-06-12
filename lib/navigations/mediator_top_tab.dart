import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/mediator_for_me.dart';
import 'package:flutter_inus_pray/screen/mediator_for_you.dart';

class MediatorTopTab extends StatelessWidget {
  static const String id = 'mediator_top_tab';

  final List<Widget> mediatorScreens = [
    MediatorForYou(),
    MediatorForMe(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: mediatorScreens.length,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            bottom: TabBar(
              indicatorWeight: 4.0,
              tabs: <Widget>[
                Container(
                  height: 46,
                  child: Center(
                    child: Text(
                      '내가 중보중인 사람',
                    ),
                  ),
                ),
                Container(
                  height: 46,
                  child: Center(
                    child: Text(
                      '나를 중보해주는 사람',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: mediatorScreens,
        ),
      ),
    );
  }
}
