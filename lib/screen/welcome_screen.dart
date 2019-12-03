import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/models/user_data.dart';
import 'package:flutter_inus_pray/screen/register_screen.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_inus_pray/components/rounded_button.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

const double iconSize = 80.0;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  _kakaoLogin(context) async {
    try {
      await kakaoSignIn.logIn();
      final KakaoLoginResult result = await kakaoSignIn.getUserMe();
      if (result != null && result.status != KakaoLoginStatus.error) {
        final KakaoAccountResult account = result.account;
        final userEmail = account.userEmail;
        final userPhoneNumber = account.userPhoneNumber;
        final userNickname = account.userNickname;
        final userProfileImagePath = account.userProfileImagePath;
        final userThumbnailImagePath = account.userThumbnailImagePath;

        final UserData userData = Provider.of<UserData>(context);
        userData.user = User(
          email: userEmail,
          name: userNickname,
          profileImagePath: userProfileImagePath,
          thumbnailImagePath: userThumbnailImagePath,
          phonNumber: userPhoneNumber,
        );

        Navigator.pushNamed(context, RegisterScreen.id);
      }
    } catch (e) {
      // 로그인 에러
    }
  }

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
                text: '카카오 로그인',
                buttonColor: Theme.of(context).primaryColor,
                onPressed: () => _kakaoLogin(context),
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
