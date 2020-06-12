import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_list.dart';
import 'package:flutter_inus_pray/components/mediator_searching_text.dart';
import 'package:flutter_inus_pray/models/mediator_model.dart';

class MediatorRecommendList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return MediatorSearchingText(
            text: "추천 중보자 검색중...",
          );
        }
        if (snap.connectionState == ConnectionState.done) {
          if (snap.data.length == 0) {
            return MediatorSearchingText(
              text: "추천 중보자가 없습니다.",
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.only(top: 10, left: 10),
                width: double.infinity,
                height: 30,
                child: Text(
                  '추천 중보자 목록',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
              Expanded(
                child: MediatorList(
                  snap: snap,
                ),
              ),
            ],
          );
        }
        return Container();
      },
      future: MediatorModel().recommendUser(context),
    );
  }
}
