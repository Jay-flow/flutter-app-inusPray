import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_list.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/settings.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MediatorForMe extends StatefulWidget {
  static const String id = 'mediator';

  @override
  _MediatorForMeState createState() => _MediatorForMeState();
}

class _MediatorForMeState extends State<MediatorForMe> {
  bool _isLoading = true;
  User myUser;
  List<User> users;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    myUser = Provider.of<User>(context);
    _findPrayForMe();
  }

  _findPrayForMe() async {
    // List<String> whoPrayForMePhoneNumbers = List();
    // myUser.whoPrayForMe.forEach((phoneNumber) {
    //   if (!myUser.mediators.contains(phoneNumber)) {
    //     whoPrayForMePhoneNumbers.add(phoneNumber);
    //   }
    // });
    users = await Mediator.findUsers(myUser.whoPrayForMe);
    setState(() {
      _isLoading = false;
    });
  }

  _addMediator(BuildContext context, User mediator) {
    myUser.updateMediators(mediator.phoneNumber);
    Provider.of<Mediator>(context).setMediators(myUser);
    Provider.of<Mediator>(context).setMediatorListener(mediator.phoneNumber);
  }

  void _deleteMediator(User mediator) {
    myUser.deleteMediators(mediator.phoneNumber);
    Provider.of<Mediator>(context).setMediators(myUser);
    Provider.of<Mediator>(context).cancelMediatorListener(mediator.phoneNumber);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? Container(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                ),
              )
            : users.isEmpty
                ? NoExistMediatorsForMe(myUser: myUser)
                : MediatorList(
                    mediators: users,
                    addMediator: _addMediator,
                    deleteMediator: _deleteMediator,
                  ),
      ),
    );
  }
}

class NoExistMediatorsForMe extends StatelessWidget {
  NoExistMediatorsForMe({this.myUser});

  final User myUser;

  _shareButtonOnPress() async {
    String dowonloadUrl = await Settings().getStoreURL();
    Share.share(
        "${myUser.name}님이 기도제목을 공유하기 원합니다.\n" + "함께 기도해주세요\n\n" + dowonloadUrl);
  }

  @override
  Widget build(BuildContext context) {
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
          onPressed: _shareButtonOnPress,
          child: Text(
            '기도앱 공유하기',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
