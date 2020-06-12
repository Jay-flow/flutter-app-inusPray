import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MediatorList extends StatefulWidget {
  MediatorList({
    this.snap,
    this.closeMediatorSearch,
  });

  final AsyncSnapshot<dynamic> snap;
  final Function closeMediatorSearch;

  @override
  _MediatorListState createState() => _MediatorListState();
}

class _MediatorListState extends State<MediatorList> {
  void _checkMyMediators(my, users) {
    for (User user in users) {
      for (String myMediatorPhoneNumber in my.mediators) {
        if (user.phoneNumber == myMediatorPhoneNumber) {
          user.isIAddedMediatorForYou = true;
        }
      }
    }
  }

  void _infoMessage(isIAddedMediatorForYou) {
    String msg = isIAddedMediatorForYou ? '중보자가 등록되었습니다.' : '중보자가 삭제되었습니다.';
    Fluttertoast.showToast(msg: msg);
  }

  void _addMediator(my, user) {
    my.updateMediators(user.phoneNumber);
    setState(() {
      user.isIAddedMediatorForYou = true;
    });
    if (widget.closeMediatorSearch != null) {
      widget.closeMediatorSearch(context, null);
    }
  }

  void _deleteMediator(my, user) {
    my.deleteMediators(user.phoneNumber);
    setState(() {
      user.isIAddedMediatorForYou = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<User> users = widget.snap.data;
    return Consumer<User>(
      builder: (BuildContext context, User my, Widget widget) {
        _checkMyMediators(my, users);
        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, index) {
            User _user = users[index];
            return MediatorItem(
              imagePath: _user.profileImage,
              title: _user.name,
              subtitle: _user.church,
              chipBackgroundColor:
                  _user.isIAddedMediatorForYou ? Colors.grey : Colors.pink,
              label: _user.isIAddedMediatorForYou
                  ? Text(
                      '중보취소',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )
                  : Text(
                      '중보하기',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
              onPress: () {
                if (_user.isIAddedMediatorForYou) {
                  _deleteMediator(my, _user);
                } else {
                  _addMediator(my, _user);
                }
                _infoMessage(_user.isIAddedMediatorForYou);
              },
            );
          },
        );
      },
    );
  }
}
