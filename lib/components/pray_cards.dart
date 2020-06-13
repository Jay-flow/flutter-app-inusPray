import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/pray_card.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

class PrayCards extends StatefulWidget {
  @override
  _PrayCardsState createState() => _PrayCardsState();
}

class _PrayCardsState extends State<PrayCards> {
  User _user;
  Mediator _mediator;
  List<Widget> _prayCards = List();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<User>(context);
    _mediator = Provider.of<Mediator>(context);
    _getPrayCards();
  }

  _removePrayCard(index) {
    setState(() {
      this._prayCards.removeAt(index);
    });
  }

  _getPrayCards() {
    List<User> users = [...this._mediator.users, this._user];
    for (int userIndex = 0; userIndex < users.length; userIndex++) {
      double position = (userIndex + 1.0) * 10;
      String name = users[userIndex].name;
      String imagePath = users[userIndex].profileImage;
      List prays = users[userIndex].prays;
      for (int prayIndex = 0; prayIndex < prays.length; prayIndex++) {
        this._prayCards.add(
          Positioned(
            //TODO:: 스와이프 이후 스와이프 하는 중간으로 나머지 이동!
//            left: position,
            child: Draggable(
              onDragEnd: (drag) {
                // TODO:: 삭제시 index 디버깅
                print(userIndex + prayIndex);
                _removePrayCard(userIndex + prayIndex);
              },
              childWhenDragging: Container(),
              feedback: PrayCard(
                name: name,
                imagePath: imagePath,
                content: Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      prays[prayIndex],
                      style: kContentsTextStyle,
                    ),
                  ),
                ),
              ),
              child: PrayCard(
                name: name,
                imagePath: imagePath,
                content: Expanded(
                  child: SingleChildScrollView(
                    child: Text(
                      prays[prayIndex],
                      style: kContentsTextStyle,
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: this._prayCards,
    );
  }
}
