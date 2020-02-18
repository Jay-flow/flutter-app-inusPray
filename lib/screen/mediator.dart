import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class Mediator extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorState createState() => _MediatorState();
}

class _MediatorState extends State<Mediator> {
  bool _isMediator = false;
  bool _isLoading = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('중보자 찾기'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: MediatorSearch(),
                );
                // var _mediators = await MediatorModel().findUserName("김");
              },
            )
          ],
        ),
        body: LoadingContainer(
          isLoading: _isLoading,
          child: Consumer<User>(
            builder: (BuildContext context, User user, Widget widget) {
              var mediators = user.mediators;
              if (mediators.isEmpty) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
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
                    SizedBox(
                      height: 40,
                    ),
                    Text(
                        '등록된 중보자가 없습니다.\n상단 오른쪽 돋보기 또는 해당 문구를\n클릭하여 같이 기도할 중보자를 추가해주세요.'),
                  ],
                );
              } else {
                return ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: ListTile(
                        leading: CircleImage(
                          size: 50,
                          imagePath: UserMock.profileImagePath,
                        ),
                        title: Text(
                          UserMock.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(UserMock.church),
                        trailing: _isMediator
                            ? ActionChip(
                                onPressed: () {},
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '기도하기',
                                      style: TextStyle(),
                                    ),
                                    Icon(
                                      Icons.check,
                                      color: Theme.of(context).accentColor,
                                    )
                                  ],
                                ),
                              )
                            : ActionChip(
                                onPressed: () {},
                                label: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    Text(
                                      '기도취소',
                                      style: TextStyle(),
                                    ),
                                    Icon(
                                      Icons.close,
                                      color: Colors.red[300],
                                    )
                                  ],
                                ),
                              ),
                      ),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Asset.Colors.grey,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class MediatorSearch extends SearchDelegate<User> {
  DateTime currentInputTime;

  @override
  String get searchFieldLabel => '이름을 입력해주세요';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(
          Icons.clear,
        ),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //TODO:: 일정 시간 되면 데이터 요청하기 (연속해서 입력할땐 x)
    if (query.length >= 2) {}

    return Text(query);
  }
}
