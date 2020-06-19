import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_inus_pray/components/icon_button_with_text.dart';
import 'package:flutter_inus_pray/components/admob.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';

//TODO:: 상단에 광고 달기
//TODO:: 개발자 광고 데이터 베이스에서 불러오기
//TODO:: 개발자 사진 경로 데이터 베이스에서 불러와서 세팅하기
//TODO:: 하단 버튼들 기능 추가
class Etc extends StatefulWidget {
  @override
  _EtcState createState() => _EtcState();
}

class _EtcState extends State<Etc> {
  bool _isLoading = false;
  AdMob _adMob = AdMob();

  @override
  void initState() {
    super.initState();
    _adMob.showBanner(adSize: AdSize.mediumRectangle, anchorOffset: 70);
  }

  void _videoCallback(RewardedVideoAdEvent event) {
    if (event == RewardedVideoAdEvent.loaded) {
      RewardedVideoAd.instance.show();
      setState(() {
        _isLoading = false;
      });
    }
    if (event == RewardedVideoAdEvent.closed) {
      Fluttertoast.showToast(
          msg: "감사합니다. 광고 비디오 시청은 저에게 큰 힘이 됩니다.",
          toastLength: Toast.LENGTH_LONG);
    }
    if (event == RewardedVideoAdEvent.failedToLoad) {
      Fluttertoast.showToast(
          msg: "광고 비디오를 불러오지 못했습니다. 관리자에게 문의 바랍니다.",
          toastLength: Toast.LENGTH_LONG);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _adMob.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              height: 80,
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButtonWithText(
                    text: '앱 사용법',
                    icon: Icons.description,
                    onPress: () {},
                  ),
                  IconButtonWithText(
                    text: '앱 공유',
                    icon: Icons.mobile_screen_share,
                    onPress: () => {},
                  ),
                  IconButtonWithText(
                    text: '광고후원',
                    icon: Icons.videocam,
                    onPress: () {
                      setState(() {
                        _isLoading = true;
                      });
                      _adMob.showVideo(_videoCallback);
                    },
                  ),
                  IconButtonWithText(
                    text: '광고제거',
                    icon: Icons.favorite,
                    onPress: () => _adMob.removeBanner(),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        CircleImage(
                          imagePath:
                              "https://yachuk.com/news/photo/201911/107817_62310_3259.jpg",
                          size: 70,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: RichText(
                            overflow: TextOverflow.fade,
                            text: TextSpan(
                              style: TextStyle(
                                color: Colors.black,
                                height: 1.3,
                              ),
                              children: [
                                TextSpan(text: '#개발자 정보\n'),
                                TextSpan(
                                  text:
                                      'Blog: https://medium.com/@kimpetro153\n',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => launch(
                                        'https://medium.com/@kimpetro153'),
                                ),
                                TextSpan(
                                  text: 'Github: https://github.com/Jay-flow',
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () =>
                                        launch('https://github.com/Jay-flow'),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          '안녕하세요. 우리안에기도 앱 개발자 김성암입니다.\n해당앱은 100% 무료로 제공되고 있으나 서비스를 운영하는데에 있어 지속적인 비용이 발생되고 있습니다.\n계속해서 서비스 제공을 위해 마지못해 광고를 표시하고 있으니 양해 부탁드립니다 😭\n후원과 광고 비디오 시청은 저에게 큰힘이 됩니다.\n보다 좋은 앱이 되도록 노력하겠습니다. 감사합니다.\n\n날 더운데 몸 조심하시고 늘 건강하세요',
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 280,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
