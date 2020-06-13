import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/mediator_search.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter_inus_pray/components/mediator_list.dart';

class MediatorForYou extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorForYouState createState() => _MediatorForYouState();
}

class _MediatorForYouState extends State<MediatorForYou> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => showSearch(
            context: context,
            delegate: MediatorSearch(),
          ),
          child: Icon(Icons.search),
        ),
        body: Consumer2<User, Mediator>(
          builder: (BuildContext context, User user, Mediator mediator, Widget widget) {
            user.checkMyMediators(mediators: mediator.users);
            if (mediator.users.isEmpty) {
              return NoExistMediators();
            } else {
              return MediatorList(
                mediators: mediator.users,
              );
            }
          },
        ),
      ),
    );
  }
}

class NoExistMediators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                FontAwesomeIcons.child,
                size: 100,
              ),
              Icon(
                FontAwesomeIcons.child,
                size: 100,
              ),
            ],
          ),
          onTap: () => showSearch(
            context: context,
            delegate: MediatorSearch(),
          ),
        ),
        SizedBox(
          height: 40,
        ),
        InkWell(
          child: Text(
            '등록된 중보자가 없습니다.\n오른쪽 하단 돋보기 또는 해당글을 터치하여\n같이 기도할 중보자를 추가해주세요.',
          ),
          onTap: () => showSearch(
            context: context,
            delegate: MediatorSearch(),
          ),
        ),
      ],
    );
  }
}
