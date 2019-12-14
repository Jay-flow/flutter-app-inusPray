import 'package:flutter/material.dart';

import 'package:flutter_inus_pray/mocks/user_mock.dart';
import 'package:flutter_inus_pray/models/user.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_inus_pray/components/pray_card.dart';
import 'package:flutter_inus_pray/utils/asset.dart' as Asset;
import 'package:flutter_inus_pray/utils/constants.dart';
import 'dart:developer' as developer;

class PrayCardScreen extends StatelessWidget {
  static const String id = 'pray_card_screen';

  final List<User> _users = [
    User(email: 'army@bagstation.io', name: "아미", church: "우리안에교회"),
    User(email: 'enhyn@gmail.com', name: "조은현", church: "우리안에교회"),
    User(email: 'choi@gmail.com', name: "최진욱", church: "우리안에교회")
  ];

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width * 0.8;
    developer.log(MediaQuery.of(context).size.height.toString());
    final screenHeight = MediaQuery.of(context).size.height * 0.95;
    double itemHeight;
    double paginationDotPadding;
    if (screenHeight > 850) {
      itemHeight = 550;
      paginationDotPadding = 25.0;
    } else {
      itemHeight = screenHeight - 220.0;
      paginationDotPadding = 10.0;
    }
    return Container(
      padding: EdgeInsets.symmetric(vertical: paginationDotPadding),
      child: Swiper(
        itemCount: _users.length,
        pagination: SwiperPagination(
          alignment: Alignment.bottomCenter,
          builder: DotSwiperPaginationBuilder(
            color: Asset.Colors.grey,
            activeColor: Colors.blue,
          ),
        ),
        layout: SwiperLayout.STACK,
        loop: true,
        itemWidth: itemWidth,
        itemHeight: itemHeight,
        itemBuilder: (BuildContext context, int index) {
          return PrayCard(
            name: UserMock.name,
            imagePath: UserMock.profileImagePath,
            content: Expanded(
              child: SingleChildScrollView(
                child: Text(
                  UserMock.prays[0],
                  style: kContentsTextStyle,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
