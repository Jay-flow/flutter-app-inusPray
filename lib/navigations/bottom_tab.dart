import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/mediator.dart';
import 'package:flutter_inus_pray/screen/my.dart';
import 'package:flutter_inus_pray/screen/pray.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BottomTab extends StatefulWidget {
  static const String id = 'bottom_tab';

  @override
  _BottomTabState createState() => _BottomTabState();
}

class _BottomTabState extends State<BottomTab> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    My(),
    Mediator(),
    Pray(),
  ];

  void _onTabTabpped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTabpped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text(
              '내 기도',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            title: Text(
              '중보자 찾기',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.5),
              child: Icon(
                FontAwesomeIcons.prayingHands,
                size: 18.0,
              ),
            ),
            title: Text(
              '기도 하기',
              style: TextStyle(
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          )
        ],
      ),
    );
  }
}
