import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/mediator_item.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/components/no_exist_pray.dart';
import 'package:provider/provider.dart';

class PrayList extends StatefulWidget {
  static const String id = 'pray_list';

  @override
  _PrayListState createState() => _PrayListState();
}

class _PrayListState extends State<PrayList> {
  List<User> users;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Mediator mediator = Provider.of<Mediator>(context);
    User myUser = Provider.of<User>(context);
    users = [...mediator.users, myUser];
  }

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return NoExistPrays();
    } else {
      return ListView.builder(
          itemCount: users.length,
          itemBuilder: (_, userIndex) {
            User user = users[userIndex];
            return ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: user.prays.length,
                itemBuilder: (_, indexPray) {
                  return MediatorItem(
                    imagePath: user.profileImage,
                    title: user.name,
                    subtitle: user.prays[indexPray],
                  );
                });
          });
    }
  }
}
