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
          preferredSize: Size.fromHeight(60.0),
          child: AppBar(
            bottom: TabBar(
              indicatorColor: Colors.black,
              tabs: <Widget>[
                Container(
                  height: 58,
                  child: Center(
                    child: Text(
                      '내가 기도 중인 사람',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 58,
                  child: Center(
                    child: Text(
                      '나를 기도 해주는 사람',
                      style: TextStyle(
                        color: Colors.black,
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
          children: mediatorScreens,
        ),
      ),
    );
  }
}
