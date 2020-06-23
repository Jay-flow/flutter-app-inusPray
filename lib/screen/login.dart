import 'dart:io' show Platform;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/components/image_button.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:google_fonts/google_fonts.dart';

const double iconSize = 80.0;

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  FlutterKakaoLogin kakaoSignIn = FlutterKakaoLogin();
  bool _isLoading = false;

  void _loadingStateChange(isLoading) {
    setState(() => _isLoading = isLoading);
  }

  @override
  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);

    controller.forward();
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
          padding: EdgeInsets.all(30),
          decoration: kGradientBackground,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Container(
                    child: FadeTransition(
                      opacity: animation,
                      child: Text(
                        "Pray for you",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.dancingScript(
                          textStyle: TextStyle(
                            fontSize: 50.0,
                            color: Asset.Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '로그인을 누르시면 ',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => print('HEY'),
                      ),
                      TextSpan(
                        text: '이용약관',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: ' 및 '),
                      TextSpan(
                        text: '개인정보',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                      ),
                      TextSpan(
                        text: '취급방침',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      TextSpan(text: '에 동의하는 것으로 간주됩니다.')
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: Platform.isIOS ? 170 : 120,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    ImageButton(
                      text: '전화번호로 로그인',
                      buttonColor: Theme.of(context).primaryColor,
                      iconImage: Asset.Icons.icPhone,
                      onPressed: () =>
                          Navigator.pushNamed(context, Register.id),
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
      ),
    );
  }
}
