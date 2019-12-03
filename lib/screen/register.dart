import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';

import 'package:flutter_inus_pray/models/user_data.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  static const String id = 'register';

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final PageController _pageController = PageController();
  String _email;
  String _name;
  String _church;
  bool _isLoading = false;
  
  // 하드 코딩 해놓음  3 = pages.length.toDouble() 인데... 좋은 방법 찾기
  double progressValue = 1.0 / 3;
  
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
  // _validate() {}

  // // 메일 인증 작업 추가하기 (카카오로그인x, 카카오로그인o 메일 없는사람)
  _mailAuthMessage() {}

  List<Widget> createPage(context) {
    final UserData userData = Provider.of<UserData>(context);
    // bool _isMailAuth = userData.user.email.isEmpty;
    bool _isMailAuth = false;

    return [
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이메일',
          hintText: '이메일을 입력해주세요',
          keyboardType: TextInputType.emailAddress,
          buttonText: '다음',
          buttonOnPressed: _isMailAuth ? _mailAuthMessage : nextPage,
          textValue: userData.user.email,
          onChange: (email) => _email = email,
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이름',
          hintText: '이름을 입력해주세요.',
          keyboardType: TextInputType.text,
          buttonText: '다음',
          buttonOnPressed: nextPage,
          textValue: userData.user.name,
          onChange: (name) => _name = name,
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '교회 이름',
          hintText: '출석 하시는 교회 이름을 입력해주세요.',
          keyboardType: TextInputType.text,
          buttonText: '완료',
          buttonOnPressed: () {
            _loadingStateChange(true);
            userData.user.email = _email;
            userData.user.name = _name;
            userData.user.church = _church;

            userData.cloudUserDataSave();
            userData.localUserDataSave();
            _loadingStateChange(false);
          },
          textValue: userData.user.church,
          onChange: (church) => _church = church,
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = createPage(context);
    
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
