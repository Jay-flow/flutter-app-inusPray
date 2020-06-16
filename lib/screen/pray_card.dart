import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/no_exist_pray.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/pray_cards.dart';

class PrayCard extends StatefulWidget {
  static const String id = 'pray_card_screen';

  @override
  _PrayCardState createState() => _PrayCardState();
}

class _PrayCardState extends State<PrayCard> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<User, Mediator>(
      builder:
          (BuildContext context, User user, Mediator mediator, Widget widget) {
        if (user.prays.isEmpty && user.mediators.isEmpty) {
          return NoExistPrays();
        } else {
          return PrayCards();
        }
      },
    );
  }
}
