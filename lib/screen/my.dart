import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_editable_profile.dart';
import 'package:flutter_inus_pray/components/edge_decoration_list_tile.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as developer;

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

  Future _confirmDeletePray(
      int index, BuildContext context, Function deleteUserPray) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('기도 삭제'),
            content: const Text('삭제하신 뒤에는 복구 할 수 없습니다.\n정말 삭제하시겠습니까?'),
            actions: <Widget>[
              FlatButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: const Text('삭제'),
                onPressed: () {
                  deleteUserPray(index);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<User>(
          builder: (BuildContext context, User user, Widget widget) {
            return CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 210.0,
                  flexibleSpace: FlexibleSpaceBar(
                    background: CircleEditableProfile(
                      name: user.name,
                      profileImagePath: user.profileImagePath,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return Slidable(
                        actionPane: SlidableDrawerActionPane(),
                        actionExtentRatio: 0.25,
                        child: user.prays.length == 0
                            ? ListTile(
                                title: Text(
                                  '등록된 기도가 없습니다.',
                                ),
                                subtitle: Text('우측 하단의 + 버튼을 눌러 기도를 등록해주세요.'),
                                leading: Icon(
                                  Icons.info_outline,
                                  color: Colors.red,
                                ),
                              )
                            : EdgeDecorationListTile(
                                title: Container(
                                  child: Text(
                                    user.prays[index],
                                  ),
                                ),
                                edgeColor: colors[Random().nextInt(8)],
                              ),
                        secondaryActions: <Widget>[
                          IconSlideAction(
                            caption: '삭제',
                            color: Theme.of(context).accentColor,
                            icon: Icons.delete_outline,
                            onTap: () => _confirmDeletePray(
                              index,
                              context,
                              user.deleteUserPray,
                            ),
                          ),
                          IconSlideAction(
                            caption: '수정',
                            color: Theme.of(context).primaryColorLight,
                            icon: Icons.mode_edit,
                            onTap: () => Navigator.pushNamed(
                              context,
                              PrayAdd.idUpdate,
                              arguments: {
                                'pray': user.prays[index],
                                'index': index,
                              },
                            ),
                          ),
                        ],
                      );
                    },
                    childCount: user.prays.length == 0 ? 1 : user.prays.length,
                  ),
                ),
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => Navigator.pushNamed(context, PrayAdd.idCreate),
        ),
      ),
    );
  }
}
