import 'package:flutter/widgets.dart';

class User { 
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phonNumber; 

  User({
    @required this.email,
    @required this.name,
    this.profileImagePath,
    this.thumbnailImagePath,
    this.phonNumber
  });
}