import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MediatorList extends StatefulWidget {
  MediatorList({
    this.mediators,
    this.closeMediatorSearch,
  });

  final List<User> mediators;
  final Function closeMediatorSearch;

  @override
  _MediatorListState createState() => _MediatorListState();
}

class _MediatorListState extends State<MediatorList> {
  User myUser;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myUser = Provider.of<User>(context);
  }

  void _infoMessage(isIAddedMediatorForYou) {
    String msg = isIAddedMediatorForYou ? '중보자가 등록되었습니다.' : '중보자가 삭제되었습니다.';
    Fluttertoast.showToast(msg: msg);
  }

  void _addMediator(User mediator) {
    myUser.updateMediators(mediator.phoneNumber);
    Provider.of<Mediator>(context).setMediators(myUser);
    setState(() {
      mediator.isIAddedMediatorForYou = true;
    });
    if (widget.closeMediatorSearch != null) {
      widget.closeMediatorSearch(context, null);
    }
  }

  void _deleteMediator(User mediator) {
    myUser.deleteMediators(mediator.phoneNumber);
    Provider.of<Mediator>(context).setMediators(myUser);
    setState(() {
      mediator.isIAddedMediatorForYou = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<User> mediators = widget.mediators;
    return ListView.builder(
      itemCount: mediators.length,
      itemBuilder: (_, index) {
        User mediator = mediators[index];
        return MediatorItem(
          imagePath: mediator.profileImage,
          title: mediator.name,
          subtitle: mediator.church,
          chipBackgroundColor:
              mediator.isIAddedMediatorForYou ? Colors.grey : Colors.pink,
          label: mediator.isIAddedMediatorForYou
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
            if (mediator.isIAddedMediatorForYou) {
              _deleteMediator(mediator);
            } else {
              _addMediator(mediator);
            }
            _infoMessage(mediator.isIAddedMediatorForYou);
          },
        );
      },
    );
  }
}
