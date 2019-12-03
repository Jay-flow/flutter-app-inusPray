import 'package:flutter/foundation.dart';
import 'user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserData extends ChangeNotifier {
  User _user;

  User get user => _user;

  set user(User user) {
    _user = user;
    notifyListeners();
  }

  setUserChurch(String church) {
    _user.church = church;
  }

  void localUserDataSave() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', user.email);
    prefs.setString('name', user.name);
    prefs.setString('profileImagePath', user.profileImagePath);
    prefs.setString('thumbnailImagePath', user.thumbnailImagePath);
    prefs.setString('phonNumber', user.phonNumber);
    prefs.setString('church', user.church);
  }

  void cloudUserDataSave() {
    Firestore.instance.collection('user').document().setData({
      'email': user.email,
      'name': user.name,
      'profileImagePath': user.profileImagePath,
      'thumbnailImagePath': user.thumbnailImagePath,
      'phonNumber': user.phonNumber,
      'church': user.church,
    });
  }
}
