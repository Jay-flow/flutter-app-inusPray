import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/pray_cards.dart';

class PrayCardScreen extends StatefulWidget {
  static const String id = 'pray_card_screen';

  @override
  _PrayCardScreenState createState() => _PrayCardScreenState();
}

class _PrayCardScreenState extends State<PrayCardScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<User, Mediator>(
      builder:
          (BuildContext context, User user, Mediator mediator, Widget widget) {
        if (user.prays.isEmpty && user.mediators.isEmpty) {
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
        } else {
          return PrayCards();
        }
      },
    );
  }
}
