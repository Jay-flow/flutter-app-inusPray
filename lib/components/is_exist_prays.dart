import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/no_exist_pray.dart';
import 'package:flutter_inus_pray/models/mediator.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:provider/provider.dart';

class IsExistPrays extends StatefulWidget {
  IsExistPrays({@required this.child, this.getUsers});

  final Function getUsers;
  final Widget child;
  
  @override
  _IsExistPraysState createState() => _IsExistPraysState();
}

class _IsExistPraysState extends State<IsExistPrays> {
  List<User> users;
  bool isPraysEmpty = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setUsers();
    if (widget.getUsers != null) {
      widget.getUsers(users);
    }
  }

  setUsers() {
    Mediator mediator = Provider.of<Mediator>(context);
    User myUser = Provider.of<User>(context);
    users = [...mediator.users, myUser];
    users.forEach((user) {
      if (user.prays.isNotEmpty) isPraysEmpty = false;
    });
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return isPraysEmpty
        ? NoExistPrays()
        : widget.child;
  }
}