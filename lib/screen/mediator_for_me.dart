import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class MediatorForMe extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorForMeState createState() => _MediatorForMeState();
}

class _MediatorForMeState extends State<MediatorForMe> {
  User myUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myUser = Provider.of<User>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: myUser.mediators.isEmpty ? NoExistMediatorsForMe() :Container()
      ),
    );
  }
}


class NoExistMediatorsForMe extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              FontAwesomeIcons.gift,
              size: 100,
            ),
            Icon(
              FontAwesomeIcons.child,
              size: 100,
            ),
          ],
        ),
        SizedBox(
          height: 40,
        ),
        Text('아직 나를 중보해주는 사람이 없습니다.\n지인에게 해당 앱을 소개하여 같이 기도해보세요!'),
        SizedBox(
          height: 20,
        ),
        RaisedButton(
          color: Theme.of(context).primaryColorLight,
          onPressed: () => Share.share(
            'check out my website https://example.com',
          ),
          child: Text(
            '기도앱 공유하기',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
