import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_editable_profile.dart';
import 'package:flutter_inus_pray/models/settings.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/pray_add.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_inus_pray/utils/admob.dart';

class My extends StatefulWidget {
  static const String id = 'my';

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<My> {
  AdMob _adMob = AdMob();

  Future _confirmDeletePray(int index, Function deleteUserPray) {
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
                  _adMob.showVideoAd();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  _shareMyPrays(User user) async {
    if (user.prays.isEmpty) {
      Fluttertoast.showToast(
        msg: '공유가능한 기도제목이 없습니다.',
      );
    } else {
      String downloadURL = await Settings().getStoreURL();
      String prays = "# ${user.name}님의 기도제목\n\n";
      for (int i = 0; i < user.prays.length; i++) {
        prays += "${i + 1}. ${user.prays[i]}\n";
      }
      prays += "\n$downloadURL";
      Share.share(prays);
    }
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
                    background: Container(
                      decoration: BoxDecoration(color: Colors.black),
                      child: Stack(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.center,
                            child: CircleEditableProfile(
                              name: user.name,
                              profileImagePath: user.profileImage,
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Text(
                                      '기도공유',
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                    ),
                                    Icon(
                                      Icons.send,
                                      color: Theme.of(context).primaryColor,
                                      size: 12.0,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () => _shareMyPrays(user),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SliverList(
                    delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return user.prays.length == 0
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
                        : index < user.prays.length
                            ? Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 5),
                                child: Card(
                                  elevation: 1.5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 20.0, left: 20.0, right: 20.0),
                                        child: Container(
                                          constraints:
                                              BoxConstraints(minHeight: 40),
                                          child: Text(
                                            user.prays[index],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                          width: 110,
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: <Widget>[
                                              InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    '삭제',
                                                    style: TextStyle(
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                                onTap: () {
                                                  _confirmDeletePray(
                                                    index,
                                                    user.deleteUserPray,
                                                  );
                                                },
                                              ),
                                              InkWell(
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      12.0),
                                                  child: Text(
                                                    '수정',
                                                    style: TextStyle(
                                                        color: Colors.grey),
                                                  ),
                                                ),
                                                onTap: () =>
                                                    Navigator.pushNamed(
                                                  context,
                                                  PrayAdd.idUpdate,
                                                  arguments: {
                                                    'pray': user.prays[index],
                                                    'index': index,
                                                  },
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : SizedBox(
                                height: 80,
                              );
                  },
                  childCount:
                      user.prays.length == 0 ? 1 : user.prays.length + 1,
                )),
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
