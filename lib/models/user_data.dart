import 'package:flutter/foundation.dart';
import 'user.dart';

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
}
