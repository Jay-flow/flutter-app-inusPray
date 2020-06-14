import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/no_exist_pray.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/pray_card.dart';
import 'package:flutter_inus_pray/utils/constants.dart';

const CARD_HORIZONTAL_PADDING = 30.0;

class PrayCards extends StatefulWidget {
  @override
  _PrayCardsState createState() => _PrayCardsState();
}

class _PrayCardsState extends State<PrayCards> {
  User _user;
  Mediator _mediator;
  List<Widget> _prayCards = List();
  int _pratCardTotal;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _user = Provider.of<User>(context);
    _mediator = Provider.of<Mediator>(context);
    _getPrayCards();
    _pratCardTotal = this._prayCards.length;
  }

  _removePrayCard() {
    setState(() {
      this._prayCards.removeLast();
    });
  }

  _getPrayCards() {
    // 카드 크기 사이즈를 지정 해주지 않으면 에러남(드래그시 크기를 몰라서 그런것 같음)
    // 패딩이 아닌 Center 위젯이나 다른 걸 통해 가운데 정렬했을 경우
    // 클릭시 원래 위젯이 있는 자리로 돌아가는 버그가 있음 => CARD_HORIZONTAL_PADDING를 정한 이유
    double cardWidth = MediaQuery.of(context).size.width;
    double cardFeedbackWidth = cardWidth - CARD_HORIZONTAL_PADDING * 2;
    double cardHeight = MediaQuery.of(context).size.height - 210;

    List<User> users = [this._user, ...this._mediator.users];
    for (int userIndex = 0; userIndex < users.length; userIndex++) {
      String name = users[userIndex].name;
      String imagePath = users[userIndex].profileImage;
      List prays = users[userIndex].prays;
      for (int prayIndex = 0; prayIndex < prays.length; prayIndex++) {
        this._prayCards.add(
              Draggable(
                onDragEnd: (drag) {
                  _removePrayCard();
                },
                childWhenDragging: Container(),
                feedback: PrayCard(
                  cardWidth: cardFeedbackWidth,
                  cardHeight: cardHeight,
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
                  cardWidth: cardWidth,
                  cardHeight: cardHeight,
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
            );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (this._prayCards.isEmpty) {
      return NoExistPrays();
    } else {
      return (this._prayCards.length == 0)
          ? Center(
              child: Text('기도 카드가 모두 소진되었습니다.'),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: CARD_HORIZONTAL_PADDING,
                  ),
                  child: Stack(
                    children: this._prayCards,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "${this._prayCards.length.toString()}/$_pratCardTotal",
                  ),
                )
              ],
            );
    }
  }
}

