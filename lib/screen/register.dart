import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/main.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:fluttertoast/fluttertoast.dart';

// ignore: non_constant_identifier_names
int INPUT_LIMIT_TIME = 30;

class Register extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final PageController _pageController = PageController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User user;
  bool _isLoading = false;
  String _verificationId;
  String _smsCode;
  Timer _timer;
  int _inputLimitTime = INPUT_LIMIT_TIME;
  List<Widget> _pages;
  double _progressValue;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context).settings.arguments ?? User();
  }

  void nextPage() {
    _pageController.nextPage(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  void _loadingStateChange(isLoading) {
    setState(() => _isLoading = isLoading);
  }

  void _inputLimitTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_inputLimitTime < 1) {
            timer.cancel();
          } else {
            _inputLimitTime = _inputLimitTime - 1;
          }
        },
      ),
    );
  }

  // 값 비어있는거 걸러내기
  _validate() async {
    user.name = user.name.trim();
    user.church = user.church.trim();
    user.phoneNumber = user.phoneNumber.trim();
    if (user.name == null ||
        user.name == '' ||
        user.church == null ||
        user.church == '' ||
        user.phoneNumber == null ||
        user.phoneNumber == '') {
      Fluttertoast.showToast(
        msg: "모든 항목은 필수 입력사항입니다.\n누락된 부분을 입력해주세요.",
        gravity: ToastGravity.CENTER,
      );
    } else {
      _loadingStateChange(true);
      await user.cloudUserDataSave();
      await user.localUserDataSave();
      _loadingStateChange(false);
    }
  }

  _phoneAuthFail(String message) {
    Fluttertoast.showToast(
      msg: message,
      gravity: ToastGravity.BOTTOM,
    );
    _previousPage();
    _timer.cancel();
    _inputLimitTime = INPUT_LIMIT_TIME;
  }

  _phoneAuthMessage() {
    _firebaseAuth
        .verifyPhoneNumber(
      phoneNumber: '+82 ${user.phoneNumber}',
      timeout: Duration(seconds: _inputLimitTime),
      verificationCompleted: _phoneVerificationCompleted,
      verificationFailed: _phoneVerificationFailed,
      codeSent: _phoneCodeSent,
      codeAutoRetrievalTimeout: _phoneCodeAutoRetrievalTimeout,
    )
        .catchError((e) {
      _phoneAuthFail("인증과정 중 에러가 발생했습니다");
    });
  }

  _phoneCodeSent(String verificationId, [int forceResendingToken]) async {
    _verificationId = verificationId;
  }

  _phoneCodeAutoRetrievalTimeout(String verificationId) {
    _phoneAuthFail(
        "인증 시간이 초과 되었습니다. 번호를 확인하신 후 재전송을 원할 경우 인증하기 버튼을 한번 더 클릭 해주세요.");
  }

  _phoneVerificationFailed(AuthException authException) {
    _phoneAuthFail("인증에 실패하였습니다.\n관리자에게 문의해주세요.");
  }

  _phoneVerificationCompleted(AuthCredential auth) {
    _firebaseAuth.signInWithCredential(auth).then((AuthResult value) async {
      if (value.user != null) {
        Fluttertoast.showToast(msg: '인증되었습니다.', gravity: ToastGravity.TOP);
        if (await _isExistUser()) return _alreadyRegistedUserHandling();
        nextPage();
      } else {
        _phoneAuthFail(
          "인증에 실패하였습니다. 번호를 확인하신 후 재전송을 원할 경우 인증하기 버튼을 한번 더 클릭 해주세요. 계속해서 실패할 경우 관리자에게 문의해주세요.",
        );
      }
    }).catchError((error) {
      _phoneAuthFail(
          "인증에 실패하였습니다.\n관리자에게 문의해주세요."
      );
    });
  }

  _verifyAuthNumber() {
    AuthCredential credential = PhoneAuthProvider.getCredential(
      verificationId: _verificationId,
      smsCode: _smsCode,
    );
    _phoneVerificationCompleted(credential);
  }

  Future<bool> _isExistUser() async {
    Map<String, dynamic> userData =
        await user.getCloudUserData(user.phoneNumber);
    if (userData != null) {
      return true;
    }
    return false;
  }

  _alreadyRegistedUserHandling() async {
    Fluttertoast.showToast(
      msg: "이미 가입된 회원 정보가 있습니다.",
      toastLength: Toast.LENGTH_LONG,
    );
    await user.localUserDataSave();
    Navigator.pushReplacementNamed(context, InusPrayApp.id);
  }

  List<Widget> createPage() {
    return [
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '휴대폰 번호',
          validator: (String value) {
            if (value == '')
              return '번호를 입력해주세요';
            else
              return null;
          },
          hintText: '휴대폰 번호를 입력해주세요 (\'-\'제외)',
          keyboardType: TextInputType.phone,
          buttonText: '인증하기',
          buttonOnPressed: (GlobalKey<FormState> key) {
            if (key.currentState.validate()) {
              _phoneAuthMessage();
              nextPage();
              _inputLimitTimer();
            }
          },
          textValue: user.phoneNumber,
          onChange: (phoneNumber) => user.phoneNumber = phoneNumber.trim(),
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '인증 번호',
          validator: (String value) {
            if (value == '')
              return '인증 번호를 입력해주세요';
            else
              return null;
          },
          hintText: '인증 번호를 입력해주세요 (\'-\'제외) $_inputLimitTime',
          keyboardType: TextInputType.phone,
          buttonText: '확인',
          buttonOnPressed: (GlobalKey<FormState> key) {
            if (key.currentState.validate()) {
              _verifyAuthNumber();
            }
          },
          onChange: (smsCode) => _smsCode = smsCode.trim(),
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이름',
          validator: (String value) {
            if (value == '') return '이름을 공백으로 둘 수는 없습니다.';
            if (value.length > 10)
              return '이름이 너무깁니다. (10자 이하로 입력)';
            else
              return null;
          },
          hintText: '이름을 입력해주세요.',
          keyboardType: TextInputType.text,
          buttonText: '다음',
          buttonOnPressed: (GlobalKey<FormState> key) {
            if (key.currentState.validate()) {
              nextPage();
            } else {}
          },
          textValue: user.name,
          onChange: (name) => user.name = name.trim(),
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '교회 이름',
          validator: (String value) {
            if (value == '') return '교회 이름을 공백으로 둘 수는 없습니다.';
            if (value.length > 15)
              return '교회 이름이 너무깁니다. (15자 이하로 입력)';
            else
              return null;
          },
          hintText: '출석 하시는 교회 이름을 입력해주세요.',
          keyboardType: TextInputType.text,
          buttonText: '완료',
          buttonOnPressed: (GlobalKey<FormState> key) async {
            if (key.currentState.validate()) {
              await _validate();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  Register.id, (Route<dynamic> route) => false);
              Navigator.pushReplacementNamed(context, InusPrayApp.id);
            }
          },
          textValue: user.church,
          onChange: (church) => user.church = church.trim(),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    _pages = createPage();
    _progressValue = 1.0 / _pages.length;
    return Scaffold(
      body: SafeArea(
        child: LoadingContainer(
          isLoading: _isLoading,
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: _progressValue,
                backgroundColor: Asset.Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor),
              ),
              Expanded(
                child: PageView.builder(
                  // TODO:: 스와이프 방지 주석 꼭 풀기!!
//                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, position) {
                    return _pages[position];
                  },
                  itemCount: _pages.length,
                  onPageChanged: (currentPosition) {
                    setState(() {
                      _progressValue = (currentPosition + 1) / _pages.length;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
