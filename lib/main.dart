import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/user_data.dart';
import 'package:flutter_inus_pray/navigations/bottom_tab.dart';
import 'package:flutter_inus_pray/screen/login.dart';
import 'package:flutter_inus_pray/screen/mediator_add.dart';
import 'package:flutter_inus_pray/screen/my.dart';
import 'package:flutter_inus_pray/screen/pray.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _setStatusBarColor();
  }

  void _setStatusBarColor() async {
    await FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(true);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<UserData>.value(
      value: UserData(),
      child: MaterialApp(
        title: Asset.Text.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          primaryColor: Asset.Colors.yellow,
          primaryColorDark: Asset.Colors.blueBlack,
          primaryColorLight: Asset.Colors.green,
          
          appBarTheme: AppBarTheme(
            color: Colors.black,
          ),
          accentColor: Asset.Colors.mint,
          textTheme: TextTheme(
            caption: TextStyle(
              color: Asset.Colors.blueBlack
            ),
            title: TextStyle(
              color: Asset.Colors.blueBlack,
              fontSize: 43,
            ),
          ),
        ),
        initialRoute: BottomTab.id,
        routes: {
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          My.id: (context) => My(),
          Mediator.id: (context) => Mediator(),
          Pray.id: (context) => Pray(),
          BottomTab.id: (context) => BottomTab(),
        },
      ),
    );
  }
}
