import 'package:flutter/widgets.dart';

class User { 
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phonNumber; 
  String church;
  String deviceToken;

  User({
    @required this.email,
    @required this.name,
    this.profileImagePath,
    this.thumbnailImagePath,
    this.phonNumber,
    this.church,
    this.deviceToken
  });
}