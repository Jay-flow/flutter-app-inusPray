import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:developer' as developer;

class Register extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final PageController _pageController = PageController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User user;
  bool _isPhoneAuth;
  bool _isLoading = false;

  // 하드 코딩 해놓음  3 = pages.length.toDouble() 인데... 좋은 방법 찾기
  double progressValue = 1.0 / 3;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    user = ModalRoute.of(context).settings.arguments ?? User();
    _isPhoneAuth =
        (user.phonNumber == null || user.phonNumber == '') ? true : false;
  }

  void nextPage() {
    _pageController.nextPage(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  void _loadingStateChange(isLoading) {
    setState(() => _isLoading = isLoading);
  }

  // 값 비어있는거 걸러내기
  _validate() {
    if (user.name == null ||
        user.name == '' ||
        user.church == null ||
        user.church == '' ||
        user.phonNumber == null ||
        user.phonNumber == '') {
      Fluttertoast.showToast(
        msg: "모든 항목은 필수 입력사항입니다.\n누락된 부분을 입력해주세요.",
        gravity: ToastGravity.CENTER,
      );
    } else {
      _loadingStateChange(true);
      user.cloudUserDataSave();
      user.localUserDataSave();
      _loadingStateChange(false);
    }
  }

  _phoneAuthMessage() {
    developer.log(user.phonNumber);
//    _firebaseAuth.verifyPhoneNumber(
//      phoneNumber: '+82 ${user.phonNumber}',
//      timeout: Duration(seconds: 60),
//      verificationCompleted: phoneVerificationCompleted,
//      verificationFailed: phoneVerificationFailed,
//      codeSent: phoneCodeSent,
//      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
//    );
  }

  phoneCodeSent(String verificationId, [int forceResendingToken]) async {
    Fluttertoast.showToast(msg: "phoneCodeSent");
    developer.log(verificationId);
  }

  phoneCodeAutoRetrievalTimeout(String verificationId) {
    Fluttertoast.showToast(msg: "phoneCodeAutoRetrievalTimeout");
  }

  phoneVerificationFailed(AuthException authException) {
    developer.log(authException.message);
    Fluttertoast.showToast(msg: "phoneVerificationFailed");
  }

  phoneVerificationCompleted(AuthCredential auth) {
    Fluttertoast.showToast(msg: "phoneVerificationCompleted");
    _firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
      } else {}
    }).catchError((error) {});
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
            if (_isPhoneAuth) {
              if (key.currentState.validate()) {
                _phoneAuthMessage();
              }
            } else {
              nextPage();
            }
          },
          textValue: user.phonNumber,
          onChange: (phoneNumber) => user.phonNumber = phoneNumber,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이름',
          validator: (String value) {
            if (value.length > 5)
              return '이름은 너무깁니다. (5자 이하로 입력)';
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
          onChange: (name) => user.name = name,
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '교회 이름',
          validator: (String value) {
            if (value.length > 15)
              return '교회 이름이 너무깁니다. (15자 이하로 입력)';
            else
              return null;
          },
          hintText: '출석 하시는 교회 이름을 입력해주세요.',
          keyboardType: TextInputType.text,
          buttonText: '완료',
          buttonOnPressed: (GlobalKey<FormState> key) {
            if (key.currentState.validate()) {
              _validate();
            } else {}
          },
          textValue: user.church,
          onChange: (church) => user.church = church,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = createPage();

    return Scaffold(
      body: SafeArea(
        child: LoadingContainer(
          isLoading: _isLoading,
          child: Column(
            children: <Widget>[
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: Theme.of(context).primaryColorLight,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).accentColor,
                ),
              ),
              Expanded(
                child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  itemBuilder: (context, position) {
                    return pages[position];
                  },
                  itemCount: pages.length,
                  onPageChanged: (currentPosition) {
                    setState(() {
                      progressValue = (currentPosition + 1) / pages.length;
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
