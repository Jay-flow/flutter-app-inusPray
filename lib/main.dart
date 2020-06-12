import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/input_type.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/navigations/main_bottom_tab.dart';
import 'package:flutter_inus_pray/screen/ad_banner.dart';
import 'package:flutter_inus_pray/screen/edit_profile.dart';
import 'package:flutter_inus_pray/screen/login.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/settings.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

void main() => runApp(InusPrayApp());

class InusPrayApp extends StatefulWidget {
  static const String id = 'inus_pray_app';

  @override
  _InusPrayAppState createState() => _InusPrayAppState();
}

class _InusPrayAppState extends State<InusPrayApp> {
  bool _isLoading = true;
  User _user;
  String _initialRoute;

  @override
  void initState() {
    super.initState();
    Settings().statusBarColor();
    _loginCheck();
  }

  void _loginCheck() async {
    _user = User();
    final String phoneNumber = await _user.getLocalUserData();
    bool existUserData = false;
    if (phoneNumber != null) {
      existUserData = await _user.getCloudUserData();
    }
    _initialRoute = existUserData ? MainBottomTab.id : Login.id;

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.black,
              body: SpinKitRipple(
                color: Colors.white,
                size: 100.0,
              ),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<User>.value(
                value: _user,
              ),
            ],
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
              initialRoute: _initialRoute,
              routes: {
                InusPrayApp.id: (context) => InusPrayApp(),
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
                AdBanner.id: (context) => AdBanner(),
              },
            ),
          );
  }
}
