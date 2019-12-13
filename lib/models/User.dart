import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String email;
  String name;
  String profileImagePath;
  String thumbnailImagePath;
  String phonNumber;
  String church;
  String deviceToken;

  User(
      {this.email,
      this.name,
      this.profileImagePath,
      this.thumbnailImagePath,
      this.phonNumber,
      this.church,
      this.deviceToken});

  Future localUserDataSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('name', name);
    prefs.setString('profileImagePath', profileImagePath);
    prefs.setString('thumbnailImagePath', thumbnailImagePath);
    prefs.setString('phonNumber', phonNumber);
    prefs.setString('church', church);
  }

  Future<void> cloudUserDataSave() async {
    await Firestore.instance.collection('user').document(phonNumber).setData({
      'email': email,
      'name': name,
      'profileImagePath': profileImagePath,
      'thumbnailImagePath': thumbnailImagePath,
      'phonNumber': phonNumber,
      'church': church,
    });
  }
}
