import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'dart:developer' as developer;

import 'package:flutter_inus_pray/models/user_data.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final PageController _pageController = PageController();

  void nextPage() {
    _pageController.nextPage(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  List<Widget> createPage(context) {
    final UserData userData = Provider.of<UserData>(context);
    return [
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이메일',
          hintText: '이메일을 입력해주세요',
          keyboardType: TextInputType.emailAddress,
          buttonText: '다음',
          buttonOnPressed: nextPage,
          textValue: userData.user.email,
        ),
      ),
      Container(
        padding: EdgeInsets.all(25.0),
        child: InputPage(
          title: '이름',
          hintText: '이름을 입력해주세요',
          keyboardType: TextInputType.text,
          buttonText: '완료',
          buttonOnPressed: () {
            userData.cloudUserDataSave();
            userData.localUserDataSave();
          },
          textValue: userData.user.name,
        ),
      ),
    ];
  }

  

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = createPage(context);
    double progressValue = 1.0 / pages.length.toDouble();

    return Scaffold(
      body: SafeArea(
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
    );
  }
}
