import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/input_type.dart';
import 'package:flutter_inus_pray/models/user_data.dart';
import 'package:flutter_inus_pray/navigations/main_bottom_tab.dart';
import 'package:flutter_inus_pray/screen/edit_profile.dart';
import 'package:flutter_inus_pray/screen/login.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
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
            body1: TextStyle(color: Asset.Colors.blueBlack),
            subhead: TextStyle(color: Asset.Colors.blueBlack),
            caption: TextStyle(color: Asset.Colors.blueBlack),
            title: TextStyle(
              color: Asset.Colors.blueBlack,
            ),
          ),
        ),
        initialRoute: MainBottomTab.id,
        routes: {
          Login.id: (context) => Login(),
          Register.id: (context) => Register(),
          MainBottomTab.id: (context) => MainBottomTab(),
          PrayAdd.idCreate: (context) => PrayAdd(
                inputType: InputType.Create,
              ),
          PrayAdd.idUpdate: (context) => PrayAdd(
                inputType: InputType.Update,
              ),
          EditProfile.id: (context) => EditProfile(),
        },
      ),
    );
  }
}
