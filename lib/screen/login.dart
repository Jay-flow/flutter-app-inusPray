import 'dart:io' show Platform;

import 'package:apple_sign_in/apple_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/components/image_button.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/register.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_kakao_login/flutter_kakao_login.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
    _addTitleAnimation();
    _initIOSLogin();
  }

  void _initIOSLogin() {
    if (Platform.isIOS) {
      AppleSignIn.onCredentialRevoked.listen((_) {
        print("Credentials revoked");
      });
    }
  }

  void _addTitleAnimation() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn);
    controller.forward();
  }

  _appleLogIn() async {
    if (await AppleSignIn.isAvailable()) {
      final AuthorizationResult appleResponse =
          await AppleSignIn.performRequests([
        AppleIdRequest(requestedScopes: [Scope.email, Scope.fullName])
      ]);
      setState(() {
        _isLoading = true;
      });
      await _appleAuthHandling(appleResponse);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _appleAuthHandling(AuthorizationResult appleResponse) async {
    final AppleIdCredential appleIdCredential = appleResponse.credential;
    User user;
    try {
      if (appleResponse.status == AuthorizationStatus.authorized) {
        FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
        if (firebaseUser == null) {
          user = await _addFirebaseAuth(appleIdCredential);
        } else {
          user = await _updateFirebaseAuth(appleIdCredential, firebaseUser);
        }
        Navigator.pushNamed(context, Register.id, arguments: user);
      } else if (appleResponse.status == AuthorizationStatus.error) {
        throw Exception;
      }
    } on PlatformException catch (e) {
      if (e.code == "ERROR_USER_NOT_FOUND") {
        return await _appleAuthHandling(appleResponse);
      }
      _printLoginError();
    } catch (e) {
      _printLoginError();
    }
  }

  _getAppleDisplayName(String displayName) {
    if (displayName == "null null") {
      return null;
    }
    return displayName;
  }

  _addFirebaseAuth(AppleIdCredential appleIdCredential) async {
    OAuthProvider oAuthProvider = new OAuthProvider(providerId: "apple.com");
    final AuthCredential credential = oAuthProvider.getCredential(
      idToken: String.fromCharCodes(appleIdCredential.identityToken),
      accessToken: String.fromCharCodes(appleIdCredential.authorizationCode),
    );
    final AuthResult _res =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return User(
      email: _res.user.email,
      name: _getAppleDisplayName(_res.user.displayName),
      phoneNumber: _res.user.phoneNumber,
      profileImagePath: _res.user.photoUrl,
      thumbnailImagePath: _res.user.photoUrl,
    );
  }

  _updateFirebaseAuth(
    AppleIdCredential appleIdCredential,
    FirebaseUser firebaseUser,
  ) async {
    UserUpdateInfo updateUser = UserUpdateInfo();
    updateUser.displayName =
        "${appleIdCredential.fullName.givenName} ${appleIdCredential.fullName.familyName}";
    await firebaseUser.updateProfile(updateUser);
    return User(
      name: _getAppleDisplayName(firebaseUser.displayName),
      phoneNumber: firebaseUser.phoneNumber,
      profileImagePath: firebaseUser.photoUrl,
      thumbnailImagePath: firebaseUser.photoUrl,
    );
  }

  void _printLoginError() {
    Fluttertoast.showToast(msg: "에러가 발생했습니다. 다른 방법으로 가입을 진행 해주세요.");
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
      _printLoginError();
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
          decoration: BoxDecoration(color: Theme.of(context).primaryColorDark),
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
                            color: Theme.of(context).primaryColor,
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
                    style: TextStyle(
                      color: Asset.Colors.white,
                    ),
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
                            onPressed: _appleLogIn,
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
