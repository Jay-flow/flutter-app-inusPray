import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/input_page.dart';
import 'package:flutter_inus_pray/utils/logger.dart';

class RegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static final PageController _pageController = PageController();

  static void nextPage() {
    _pageController.nextPage(
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  static List<Widget> pages = [
    Container(
      padding: EdgeInsets.all(25.0),
      child: InputPage(
        title: '이메일',
        hintText: '이메일을 입력해주세요',
        keyboardType: TextInputType.emailAddress,
        buttonText: '다음',
        buttonOnPressed: nextPage,
      ),
    ),
    Container(
      padding: EdgeInsets.all(25.0),
      child: InputPage(
        title: '비밀번호',
        hintText: '비밀번호를 입력해주세요',
        keyboardType: TextInputType.visiblePassword,
        buttonText: '다음',
        buttonOnPressed: nextPage,
      ),
    ),
    Container(
      padding: EdgeInsets.all(25.0),
      child: InputPage(
        title: '이름',
        hintText: '이름을 입력해주세요',
        keyboardType: TextInputType.text,
        buttonText: '다음',
        buttonOnPressed: () {},
      ),
    ),
  ];

  double progressValue = 1.0 / pages.length.toDouble();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            LinearProgressIndicator(
              value: progressValue,
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
                    DLog.d(currentPosition);
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
