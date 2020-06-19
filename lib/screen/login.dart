import 'dart:io' show Platform;
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/components/image_button.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_inus_pray/components/rounded_button.dart';

const double iconSize = 80.0;

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  bool _isLoading = false;

  void _loadingStateChange(isLoading) {
    setState(() => _isLoading = isLoading);
  }

  _kakaoLogin(context) async {
    _loadingStateChange(true);
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

        User user = User(
          email: userEmail,
          name: userNickname,
          profileImagePath: userProfileImagePath,
          thumbnailImagePath: userThumbnailImagePath,
          phoneNumber: userPhoneNumber,
        );
        Navigator.pushNamed(context, Register.id, arguments: user);
      }
    } catch (e) {
      // 로그인 에러
    }
    _loadingStateChange(false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Container(
          constraints: BoxConstraints.expand(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 20,
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
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                '로그인을 누르시면 이용약관 및 개인정보 취급 방침에 동의하는 것으로 간주됩니다.',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => print('HEY')),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: Platform.isIOS ? 170 : 130,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      ImageButton(
                        text: '전화번호로 로그인',
                        buttonColor: Theme.of(context).primaryColor,
                        iconImage: Asset.Icons.icPhone,
                        onPressed: () => Navigator.pushNamed(context, Register.id),
                      ),
                      ImageButton(
                        text: '카카오 로그인',
                        buttonColor: Theme.of(context).primaryColor,
                        iconImage: Asset.Icons.icKakao,
                        onPressed: () => _kakaoLogin(context),
                      ),
                      Platform.isIOS
                          ? ImageButton(
                              text: 'Apple로 로그인',
                              buttonColor: Colors.white,
                              iconImage: Asset.Icons.icApple,
                              onPressed: () async {
                                // https://pub.dev/packages/sign_in_with_apple#-readme-tab-
                                // final credential =
                                //     await SignInWithApple.getAppleIDCredential(
                                //   scopes: [
                                //     AppleIDAuthorizationScopes.email,
                                //     AppleIDAuthorizationScopes.fullName,
                                //   ],
                                // );
                              },
                            )
                          : Container(),
                    ],
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
      ),
    );
  }
}
