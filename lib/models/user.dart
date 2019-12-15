import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as developer;
import 'package:flutter/foundation.dart';

class User extends ChangeNotifier {
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phoneNumber;
  String church;
  String deviceToken;

  User({
    this.email,
    this.name,
    this.profileImagePath,
    this.thumbnailImagePath,
    this.phoneNumber,
    this.church,
    this.deviceToken,
  });

  Future localUserDataSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> cloudUserDataSave() async {
    await Firestore.instance.collection('users').document(phoneNumber).setData({
      'email': email,
      'name': name,
      'profileImagePath': profileImagePath,
      'thumbnailImagePath': thumbnailImagePath,
      'phoneNumber': phoneNumber,
      'church': church,
    });
  }

  static Future<String> getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  static Future<User> getCloudUserData(String phoneNumber) async {
    DocumentSnapshot user = await Firestore.instance
        .collection('users')
        .document(phoneNumber)
        .get();

    Map<String, dynamic> userData = user.data;

    return User(
      name: userData['name'],
      profileImagePath: userData['profileImagePath'],
      church: userData['church'],
    );
  }
}
