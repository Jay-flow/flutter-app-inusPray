
import 'package:flutter_inus_pray/models/user.dart';

class MediatorData {
  List<User> _users = [
    User(email: 'army@bagstation.io', name: "아미", church: "우리안에교회"),
    User(email: 'enhyn@gmail.com', name: "조은현", church: "우리안에교회"),
    User(email: 'choi@gmail.com', name: "최진욱", church: "우리안에교회")
  ];

  get users {
    return _users;
  }

  int get userCount {
    return _users.length;
  }
}