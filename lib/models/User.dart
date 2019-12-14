import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phoneNumber;
  String church;
  String deviceToken;

  User(
      {this.email,
      this.name,
      this.profileImagePath,
      this.thumbnailImagePath,
      this.phoneNumber,
      this.church,
      this.deviceToken});

  Future localUserDataSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('name', name);
    prefs.setString('profileImagePath', profileImagePath);
    prefs.setString('thumbnailImagePath', thumbnailImagePath);
    prefs.setString('phonNumber', phoneNumber);
    prefs.setString('church', church);
  }

  Future<void> cloudUserDataSave() async {
    await Firestore.instance.collection('user').document(phoneNumber).setData({
      'email': email,
      'name': name,
      'profileImagePath': profileImagePath,
      'thumbnailImagePath': thumbnailImagePath,
      'phonNumber': phoneNumber,
      'church': church,
    });
  }
}
