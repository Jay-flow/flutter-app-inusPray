import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/navigations/mediator_top_tab.dart';
import 'package:flutter_inus_pray/navigations/pray_top_tab.dart';
import 'package:flutter_inus_pray/screen/my.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainBottomTab extends StatefulWidget {
  static const String id = 'main_bottom_tab';

  @override
  _MainBottomTabState createState() => _MainBottomTabState();
}

class _MainBottomTabState extends State<MainBottomTab> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    My(),
    MediatorTopTab(),
    PrayTopTab(),
    // Etc(),
  ];

  void _onTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    _initLocalPushNotification();
  }

  void _initLocalPushNotification() async {
    WidgetsFlutterBinding.ensureInitialized();
    var initAndroidSetting =
        AndroidInitializationSettings('@drawable/ic_notification');
    var initIosSetting = IOSInitializationSettings();
    var initSetting =
        InitializationSettings(initAndroidSetting, initIosSetting);
    await FlutterLocalNotificationsPlugin().initialize(initSetting);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12.0,
        unselectedFontSize: 12.0,
        showUnselectedLabels: true,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: _onTab,
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
              '중보자',
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
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.more_horiz),
          //   title: Text(
          //     '기타',
          //     style: TextStyle(
          //       color: Theme.of(context).primaryColorDark,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
