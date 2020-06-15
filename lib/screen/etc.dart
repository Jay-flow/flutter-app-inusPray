import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/screen/ad_banner.dart';

class Etc extends StatefulWidget {
  @override
  _EtcState createState() => _EtcState();
}

class _EtcState extends State<Etc> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleImage(
                imagePath:
                    "https://yachuk.com/news/photo/201911/107817_62310_3259.jpg",
                size: 70,
              ),
              SizedBox(
                width: 10,
              ),
              Text('블로그: https://medium.com/@kimpetro153\n' +
                  'Github: https://github.com/Jay-flow'),
            ],
          ),
          Container(
            child: Text(
                '안녕하세요. 우리안에기도 앱 개발자 김성암입니다.\n해당앱은 100% 무료로 제공되고 있으나 서비스를 운영하는데에 있어 비용이 발생되고 있습니다.\n지속적인 서비스 제공을 위해 마지못해 광고를 개시하고 있으니 양해 부탁드립니다 😭\n후원과 후기, 광고 비디오 시청은 저에게 큰힘이 됩니다.\n보다 좋은 앱이 되도록 노력하겠습니다. 감사합니다!'),
          )
        ],
      ),
    );
  }
}
