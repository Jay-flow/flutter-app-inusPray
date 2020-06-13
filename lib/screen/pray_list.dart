import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';

class PrayList extends StatefulWidget {
  static const String id = 'pray_list';

  @override
  _PrayListState createState() => _PrayListState();
}

class _PrayListState extends State<PrayList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Mediator>(
      builder: (BuildContext context, Mediator mediator, Widget widget) {
        return ListView.builder(
            itemCount: mediator.users.length,
            itemBuilder: (_, userIndex) {
              User user = mediator.users[userIndex];
              return ListView.builder(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: user.prays.length,
                  itemBuilder: (_, indexPray) {
                    return MediatorItem(
                      imagePath: user.profileImage,
                      title: user.name,
                      subtitle: user.prays[indexPray],
                    );
                  });
            });
      },
    );
  }
}

//if (_prays.isEmpty) {
//return Column(
//mainAxisAlignment: MainAxisAlignment.center,
//children: <Widget>[
//Icon(
//FontAwesomeIcons.pray,
//size: 100,
//),
//SizedBox(
//height: 40,
//),
//Text('등록된 기도가 없습니다.\n내 기도 또는 같이 기도할 중보자를 추가해주세요.'),
//],
//);
//} else {
//return ListView.builder(
//itemCount: _prays.length,
//itemBuilder: (_, index) {
//return MediatorItem(
//imagePath: _prays[index].profileImage,
//title: _prays[index].name,
//subtitle: _prays[index].content,
//);
//},
//);
//}
