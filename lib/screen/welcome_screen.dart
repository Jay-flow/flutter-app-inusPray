import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/screen/login_screen.dart';
import 'package:flutter_inus_pray/screen/register_screen.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_inus_pray/components/rounded_button.dart';

const double iconSize = 80.0;

class WelcomeScreen extends StatelessWidget {
  static const String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 60,
              ),
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
              RoundedButton(
                text: '회원가입',
                buttonColor: Colors.white,
                onPressed: () =>
                    Navigator.pushNamed(context, RegisterScreen.id),
              ),
              SizedBox(
                height: 20,
              ),
              RoundedButton(
                text: '로그인',
                buttonColor: Theme.of(context).primaryColor,
                onPressed: () => Navigator.pushNamed(context, LoginScreen.id),
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
