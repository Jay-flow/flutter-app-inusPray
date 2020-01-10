import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;

class PrayList extends StatelessWidget {
  static const String id = 'pray_list';

  final List<User> _users = [
    User(email: 'army@bagstation.io', name: "아미", church: "우리안에교회"),
    User(email: 'enhyn@gmail.com', name: "김유지", church: "우리안에교회"),
    User(email: 'choi@gmail.com', name: "최진욱", church: "우리안에교회")
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (_, index) {
        String name = _users[index].name;
        return Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: ListTile(
            leading: CircleImage(
              size: 50,
              imagePath: UserMock.profileImagePath,
            ),
            title: Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(UserMock.prays[0]),
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
    );
  }
}
