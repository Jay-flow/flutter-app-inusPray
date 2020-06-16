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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40.0),
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '등록된 기도가 없습니다.\n내 기도 또는 같이 기도할 중보자를 등록해주세요',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                  text:
                      '\n(중보자를 등록했다고 하더라도 중보자가 기도제목을 추가하지 않으면 해당 문구가 표시될 수 있습니다.)',
                  style: TextStyle(
                    color: Colors.grey[400],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
