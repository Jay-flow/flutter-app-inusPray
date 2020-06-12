import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/screen/mediator_search.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MediatorForYou extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorForYouState createState() => _MediatorForYouState();
}

class _MediatorForYouState extends State<MediatorForYou> {
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
        floatingActionButton: FloatingActionButton(
          onPressed: () => showSearch(
            context: context,
            delegate: MediatorSearch(),
          ),
          child: Icon(Icons.search),
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
