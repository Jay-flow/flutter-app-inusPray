import 'dart:developer' as developer;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  CollectionReference userCollection = Firestore.instance.collection('users');
  String defaultProfileImagePath =
      'https://firebasestorage.googleapis.com/v0/b/flutter-inuspray.appspot.com/o/profile_images%2Fdefault.png?alt=media&token=693025b1-27e3-4237-80a7-d1f51d7bf821';
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phoneNumber;
  String church;
  String deviceToken;
  bool isPayment;
  List prays;
  List mediators;

  // 사진이 없는 사람을 위한 기본 사진 경로 설정
  // 사진 관련 호출시 user.profileImagePath 아닌 아래 profileImage 사용
  String get profileImage => profileImagePath ?? defaultProfileImagePath;

  User({
    this.email,
    this.name,
    this.profileImagePath,
    this.thumbnailImagePath,
    this.phoneNumber,
    this.church,
    this.deviceToken,
    this.prays = const [],
    this.mediators,
    this.isPayment = false,
  });

  Future localUserDataSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('phoneNumber', phoneNumber);
  }

  Future<void> cloudUserDataSave() async {
    await userCollection.document(phoneNumber).setData({
      'isPayment': isPayment,
      'email': email,
      'name': name,
      'profileImagePath': profileImagePath,
      'thumbnailImagePath': thumbnailImagePath,
      'phoneNumber': phoneNumber,
      'church': church,
      'prays': prays,
      'mediators': mediators,
      'createAt': Timestamp.now(),
    });
  }

  Future<String> getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    this.phoneNumber = prefs.getString('phoneNumber');
    return prefs.getString('phoneNumber');
  }

  Future<void> getCloudUserData() async {
    DocumentSnapshot user = await userCollection.document(phoneNumber).get();

    Map<String, dynamic> userData = user.data;

    this.name = userData['name'];
    this.isPayment = userData['isPayment'];
    this.profileImagePath = userData['profileImagePath'];
    this.church = userData['church'];
    this.prays = userData['prays'].toList();
    developer.log(this.prays.toString());
    this.mediators = userData['mediators'];
  }

  setUpdateDataTime() {
    userCollection.document(phoneNumber).updateData({
      'modifyAt': Timestamp.now(),
    });
  }

  createUserPray(String value) {
    setUpdateDataTime();
    this.prays = [...this.prays, value];
    userCollection.document(phoneNumber).updateData({'prays': this.prays});
    notifyListeners();
  }

  updateUserPray(int index, String value) {
    setUpdateDataTime();
    this.prays[index] = value;
    userCollection.document(phoneNumber).updateData({'prays': this.prays});
    notifyListeners();
  }

  deleteUserPray(int index) {
    setUpdateDataTime();
    this.prays.removeAt(index);
    userCollection.document(phoneNumber).updateData({
      'prays': this.prays,
    });
    notifyListeners();
  }
}
