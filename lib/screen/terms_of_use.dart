import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class TermsOfUse extends StatelessWidget {
  static const String id = "terms_of_use";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "이용약관",
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "제1조(목적)",
                style: kContentsTextStyle,
              ),
              Text(
                "이 약관은 김성암(개인)이 운영하는 우리안에기도"
                "(이하 \"기도앱\"이라 한다)에서 제공하는 인터넷 관련 "
                "서비스(이하 \"서비스\"라 한다)를 이용함에 있어 이용자의 권리·의무"
                "및 책임사항을 규정함을 목적으로 합니다.\n"
                "※「PC통신, 무선 등을 이용하는 전자상거래에 대해서도 그 성질에 "
                "반하지 않는 한 이 약관을 준용합니다.」",
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "제2조(정의)",
                style: kContentsTextStyle,
              ),
              Text(
              "① \"우리안에기도\"란 기독교의 종교행위 중 하나인 기도에 대해 "
                "회원간에 서로 공유할 수 있도록 돕는 가상의 공간을 제공하는 서비스를 말합니다.\n"
                  "② \"이용자\"란 \"우리안에기도\"에 접속하여 이 약관에 따라 \"우리안에기도\""
                  "가 제공하는 서비스를 받는 회원 및 비회원을 말합니다.",
              )
            ],
          ),
        ),
      ),
    );
  }
}
