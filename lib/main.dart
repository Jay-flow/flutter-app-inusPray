import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/register_screen.dart';
import 'package:flutter_inus_pray/screen/welcome_screen.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

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
    return MaterialApp(
      title: Asset.Text.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Asset.Colors.yellow,
        primaryColorDark: Asset.Colors.blueBlack,
        primaryColorLight: Asset.Colors.green,
        accentColor: Asset.Colors.mint,
        textTheme: TextTheme(
          title: TextStyle(
            color: Asset.Colors.blueBlack,
            fontSize: 43,
          ),
        ),
      ),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        RegisterScreen.id: (context) => RegisterScreen(),
      },
    );
  }
}
