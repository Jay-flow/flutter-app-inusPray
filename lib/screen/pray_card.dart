import 'package:flutter/material.dart';
import 'package:flutter_inus_pray/components/circle_image.dart';
import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:developer' as developer;

class PrayCard extends StatelessWidget {
  static const String id = 'pray_card';

  final List<User> _users = [
    User(email: 'army@bagstation.io', name: "아미", church: "우리안에교회"),
    User(email: 'enhyn@gmail.com', name: "조은현", church: "우리안에교회"),
    User(email: 'choi@gmail.com', name: "최진욱", church: "우리안에교회")
  ];

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width - 70.0;
    final itemHeight = MediaQuery.of(context).size.height - 220.0;

    return Container(
      padding: EdgeInsets.only(bottom: 5.0),
      child: Swiper(
        itemCount: _users.length,
        pagination: SwiperPagination(
          builder: DotSwiperPaginationBuilder(
            color: Colors.grey[350],
            activeColor: Colors.blue,
          ),
        ),
        layout: SwiperLayout.STACK,
        loop: true,
        itemWidth: itemWidth,
        itemHeight: itemHeight,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.grey[50],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              side: BorderSide(
                width: 0.5,
                color: Colors.grey[300],
              ),
            ),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 23.0),
              child: Column(
                children: <Widget>[
                  Text(
                    UserMock.name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 23.0,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    child: CircleImage(
                      imagePath: UserMock.profileImagePath,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10.0),
                    height: 1.0,
                    width: 100,
                    color: Theme.of(context).primaryColor,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Text(
                        UserMock.prays[0],
                        style: TextStyle(color: Colors.black, fontSize: 18.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
