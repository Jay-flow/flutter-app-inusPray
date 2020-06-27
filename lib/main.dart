import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/models/input_type.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/navigations/main_bottom_tab.dart';
import 'package:flutter_inus_pray/screen/ad_banner.dart';
import 'package:flutter_inus_pray/screen/edit_church_name.dart';
import 'package:flutter_inus_pray/screen/edit_profile.dart';
import 'package:flutter_inus_pray/screen/edit_user_name.dart';
import 'package:flutter_inus_pray/screen/login.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/notification_fcm.dart';
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
  Mediator _mediator;
  String _initialRoute;

  @override
  void initState() {
    super.initState();
    Settings().statusBarColor();
    _checkLocalUserData();
  }

  void _checkLocalUserData() async {
    _user = User();
    _initialRoute = Login.id;
    final String phoneNumber = await _user.getLocalUserData();
    if (phoneNumber != null) {
      await _checkCloudUserData(phoneNumber);
    }
    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _checkCloudUserData(phoneNumber) async {
    Map<String, dynamic> userData = await _user.getCloudUserData(phoneNumber);
    if (userData != null) {
      _user.setUserListener(phoneNumber);
      _user.setUser(userData);
      _initialRoute = MainBottomTab.id;
      _mediator = Mediator();
      await _mediator.setMediators(_user);
      _setMediatorListener();
      NotificationFCM(_user);
    } else {
      _user.deleteLocalUserData();
    }
  }

  _setMediatorListener() {
    _user.mediators.forEach((phoneNumber) {
      _mediator.setMediatorListener(phoneNumber);
    });
  }

  void _preventLandscape() {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  }

  @override
  Widget build(BuildContext context) {
    _preventLandscape();
    return _isLoading
        ? MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: SpinKitFadingCircle(
                color: Colors.black,
              ),
            ),
          )
        : MultiProvider(
            providers: [
              ChangeNotifierProvider<User>.value(
                value: _user,
              ),
              ChangeNotifierProvider<Mediator>.value(
                value: _mediator,
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
                    color: Colors.white,
                    textTheme: TextTheme(
                      title: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    iconTheme: IconThemeData(
                      color: Colors.black,
                    )),
                accentColor: Asset.Colors.mint,
                textTheme: TextTheme(
                  body1: TextStyle(color: Asset.Colors.blueBlack),
                  subhead: TextStyle(color: Asset.Colors.blueBlack),
                  caption: TextStyle(color: Asset.Colors.blueBlack),
                  title: TextStyle(
                    color: Asset.Colors.blueBlack,
                  ),
                ),
                floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Asset.Colors.green,
                ),
                tabBarTheme: TabBarTheme(labelColor: Colors.black),
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
                EditUserName.id: (context) => EditUserName(),
                EditChurchName.id: (context) => EditChurchName(),
                AdBanner.id: (context) => AdBanner(),
              },
            ),
          );
  }
}
