import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NoExistPrays extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(
          FontAwesomeIcons.pray,
          size: 100,
        ),
        SizedBox(
          height: 40,
        ),
        Text('등록된 기도가 없습니다.\n내 기도 또는 같이 기도할 중보자를 추가해주세요.'),
      ],
    );
  }
}