import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

const double iconSize = 80.0;

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: iconSize,
                height: iconSize,
                padding: EdgeInsets.all(12),
                margin: EdgeInsets.only(bottom: 25.0),
                child: Asset.Icons.icLogo,
                decoration: kIconBoxStyle,
              ),
              Expanded(
                child: TypewriterAnimatedTextKit(
                  text: [Asset.Text.appName],
                  textStyle: kTitleTextStyle,
                ),
              ),
              Material(
                elevation: 5.0,
                color: Colors.amber,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {},
                  height: 50.0,
                  minWidth: double.infinity,
                  child: Text(
                    '카카오 로그인',
                    style: kRoundButtonTextStyle
                  ),
                ),
              ),
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: Asset.Images.loginScreenBackground,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
