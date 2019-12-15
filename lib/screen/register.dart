import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/main.dart';
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
        (user.phoneNumber == null || user.phoneNumber == '') ? true : false;
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
  _validate() async {
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

  _phoneAuthMessage() {
    developer.log(user.phoneNumber);
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+82 ${user.phoneNumber}',
      timeout: Duration(seconds: 30),
      verificationCompleted: phoneVerificationCompleted,
      verificationFailed: phoneVerificationFailed,
      codeSent: phoneCodeSent,
      codeAutoRetrievalTimeout: phoneCodeAutoRetrievalTimeout,
    );
  }

  phoneCodeSent(String verificationId, [int forceResendingToken]) async {
    Fluttertoast.showToast(
      msg: '인증코드를 메세지로 보냈습니다.\n메시지를 수신시 코드를 입력하지 않아도 자동으로 인증됩니다.',
      toastLength: Toast.LENGTH_LONG,
    );
    developer.log(verificationId);
  }

  phoneCodeAutoRetrievalTimeout(String verificationId) {
    Fluttertoast.showToast(
      msg: '인증 시간이 초과 되었습니다. 번호를 확인하신 후 재전송을 원할 경우 인증하기 버튼을 한번 더 클릭 해주세요.',
      toastLength: Toast.LENGTH_LONG,
    );
  }

  phoneVerificationFailed(AuthException authException) {
    Fluttertoast.showToast(msg: '인증에 실패하였습니다.\n관리자에게 문의해주세요.');
  }

  phoneVerificationCompleted(AuthCredential auth) {
    Fluttertoast.showToast(msg: "phoneVerificationCompleted");
    _firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        Fluttertoast.showToast(msg: '인증되었습니다.');
        _checkExistUser();
        nextPage();
      } else {
        Fluttertoast.showToast(
          msg:
              '인증에 실패하였습니다. 번호를 확인하신 후 재전송을 원할 경우 인증하기 버튼을 한번 더 클릭 해주세요. 계속해서 실패할 경우 관리자에게 문의해주세요.',
          toastLength: Toast.LENGTH_LONG,
        );
      }
    }).catchError((error) {
      Fluttertoast.showToast(msg: '인증에 실패하였습니다.\n관리자에게 문의해주세요.');
    });
  }

  _checkExistUser() {
    //TODO: 기존에 등록된 휴대폰 번호가 있는지 확인, 있으면 가입 없이 그냥 바로 로그인 처리
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
          textValue: user.phoneNumber,
          onChange: (phoneNumber) => user.phoneNumber = phoneNumber,
          inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이름',
          validator: (String value) {
            if (value.length > 5)
              return '이름이 너무깁니다. (5자 이하로 입력)';
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
          buttonOnPressed: (GlobalKey<FormState> key) async {
            if (key.currentState.validate()) {
              await _validate();
              Navigator.pushReplacementNamed(context, InusPrayApp.id);
            }
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
//                  physics: NeverScrollableScrollPhysics(),
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
