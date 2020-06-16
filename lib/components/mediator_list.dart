import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MediatorList extends StatefulWidget {
  MediatorList({
    @required this.mediators,
    this.deleteMediator,
    this.addMediator,
  });

  final List<User> mediators;
  final Function deleteMediator;
  final Function addMediator;

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
    String msg = isIAddedMediatorForYou ?  '중보자가 삭제되었습니다.': '중보자가 등록되었습니다.';
    Fluttertoast.showToast(msg: msg);
  }

  @override
  Widget build(BuildContext context) {
    List<User> mediators = widget.mediators;
    myUser.checkMyMediators(mediators: mediators);
    return ListView.builder(
      itemCount: mediators.length,
      itemBuilder: (_, index) {
        User mediator = mediators[index];
        return MediatorItem(
          imagePath: mediator.profileImage,
          title: mediator.name,
          subtitle: mediator.church,
          chipBackgroundColor:
              mediator.isIAddedMediatorForYou ? Colors.grey : Theme.of(context).primaryColorLight,
          label: mediator.isIAddedMediatorForYou
              ? Text(
                  '기도취소',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                )
              : Text(
                  '기도하기',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
          onPress: () {
            if (mediator.isIAddedMediatorForYou) {
              widget.deleteMediator(mediator);
            } else {
              widget.addMediator(context, mediator);
            }
            _infoMessage(mediator.isIAddedMediatorForYou);
          },
        );
      },
    );
  }
}
