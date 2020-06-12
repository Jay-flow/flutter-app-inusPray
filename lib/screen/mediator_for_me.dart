import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/components/loading_container.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class MediatorForMe extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorForMeState createState() => _MediatorForMeState();
}

class _MediatorForMeState extends State<MediatorForMe> {
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
                          FontAwesomeIcons.gift,
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
                    Text('아직 나를 중보해주는 사람이 없습니다.\n지인에게 해당 앱을 소개하여 같이 기도해보세요!'),
                    SizedBox(
                      height: 20,
                    ),
                    RaisedButton(
                      color: Theme.of(context).primaryColorLight,
                      onPressed: () => {},
                      child: Text(
                        '기도 공유하기',
                        style: TextStyle(
                          color: Colors.white,
                        ),
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
