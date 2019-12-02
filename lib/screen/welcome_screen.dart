import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/User.dart';
import 'package:flutter_inus_pray/screen/register_screen.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_inus_pray/components/rounded_button.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

const double iconSize = 80.0;

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();

  _kakaoLogin() async {
    await kakaoSignIn.logIn();
    final KakaoLoginResult result = await kakaoSignIn.getUserMe();
    if (result != null && result.status != KakaoLoginStatus.error) {
      final KakaoAccountResult account = result.account;
      final userEmail = account.userEmail;
      final userPhoneNumber = account.userPhoneNumber;
      final userNickname = account.userNickname;
      final userProfileImagePath = account.userProfileImagePath;
      final userThumbnailImagePath = account.userThumbnailImagePath;

      final user = User(
          email: userEmail,
          name: userNickname,
          profileImagePath: userProfileImagePath,
          thumbnailImagePath: userThumbnailImagePath,
          phonNumber: userPhoneNumber);

          _localUserDataSave(user);
          _cloudUserDataSave(user);
    } else {
      // 로그인 실패 처리
    }
  }

  _localUserDataSave(User user) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('email', user.email);
      prefs.setString('name', user.name);
      prefs.setString('profileImagePath', user.profileImagePath);
      prefs.setString('thumbnailImagePath', user.thumbnailImagePath);
      prefs.setString('phonNumber', user.phonNumber);
  }

  _cloudUserDataSave(User user) {
    
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
                onPressed: _kakaoLogin,
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
