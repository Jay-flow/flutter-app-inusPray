import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/edge_decoration_list_tile.dart';
import 'package:flutter_inus_pray/components/circle_button.dart';
import 'package:flutter_inus_pray/screen/edit_profile.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_slidable/flutter_slidable.dart';

class My extends StatefulWidget {
  static const String id = 'my';

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.purple,
    Colors.orange,
    Asset.Colors.blueBlack,
    Asset.Colors.green,
    Asset.Colors.yellow,
    Asset.Colors.mint,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              expandedHeight: 210.0,
              flexibleSpace: FlexibleSpaceBar(
                background: Profile(),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.25,
                    child: EdgeDecorationListTile(
                      title: Container(
                        child: Text(
                          UserMock.prays[0],
                        ),
                      ),
                      edgeColor: colors[Random().nextInt(8)],
                    ),
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: '삭제',
                        color: Theme.of(context).accentColor,
                        icon: Icons.delete_outline,
                        onTap: () {},
                      ),
                      IconSlideAction(
                        caption: '수정',
                        color: Theme.of(context).primaryColorLight,
                        icon: Icons.mode_edit,
                        onTap: () {},
                      ),
                    ],
                  );
                },
                childCount: 10,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, PrayAdd.id),
        ),
      ),
    );
  }
}

class Profile extends StatelessWidget {
  const Profile({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Stack(
          children: <Widget>[
            CircleImage(
              imagePath: UserMock.profileImagePath,
            ),
            Positioned(
              bottom: 0,
              right: -25,
              child: CircleButton(
                child: Icon(
                  Icons.create,
                ),
                onPressed: () => Navigator.pushNamed(context, EditProfile.id),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          UserMock.name,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
