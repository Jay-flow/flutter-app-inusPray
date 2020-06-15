import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_inus_pray/utils/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User extends ChangeNotifier {
  CollectionReference userCollection = Firestore.instance.collection('users');
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
  List whoPrayForMe;
  bool isIAddedMediatorForYou;

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
    this.mediators = const [],
    this.whoPrayForMe = const [],
    this.isPayment = false,
    this.isIAddedMediatorForYou = false,
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
      'whoPrayForMe': whoPrayForMe,
      'mediators': mediators,
      'createAt': Timestamp.now(),
    });
  }

  Future<String> getLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('phoneNumber');
  }

  Future<Map<String, dynamic>> getCloudUserData(phoneNumber) async {
    DocumentSnapshot user = await userCollection.document(phoneNumber).get();
    return user.data;
  }

  setUserListener(phoneNumber) async {
    DocumentSnapshot user = await userCollection.document(phoneNumber).get();
    user.reference.snapshots().listen((event) {
      setUser(event.data);
      notifyListeners();
    });
  }

  deleteLocalUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }

  setUser(userData) {
    this.phoneNumber = userData['phoneNumber'];
    this.name = userData['name'];
    this.isPayment = userData['isPayment'];
    this.profileImagePath = userData['profileImagePath'];
    this.church = userData['church'];
    this.prays = userData['prays'].toList();
    this.mediators = userData['mediators'].toList();
    this.whoPrayForMe = userData['whoPrayForMe'].toList();
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

  updateUserProfileImage(String path) {
    setUpdateDataTime();
    this.profileImagePath = path;
    userCollection
        .document(phoneNumber)
        .updateData({'profileImagePath': this.profileImagePath});
    notifyListeners();
  }

  updateUserName(String name) {
    setUpdateDataTime();
    this.name = name;
    userCollection.document(phoneNumber).updateData({'name': this.name});
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

  updateMediators(mediatorPhoneNumber) {
    setUpdateDataTime();
    _updateMyMediators(mediatorPhoneNumber);
    _updateMediatorWhoPrayForMe(mediatorPhoneNumber);
    notifyListeners();
  }

  void _updateMyMediators(mediatorPhoneNumber) {
    this.mediators = [...this.mediators, mediatorPhoneNumber];
    userCollection
        .document(this.phoneNumber)
        .updateData({'mediators': this.mediators});
  }

  _updateMediatorWhoPrayForMe(mediatorPhoneNumber) async {
    DocumentSnapshot mediatorUser =
        await userCollection.document(mediatorPhoneNumber).get();
    List whoPrayForMe = mediatorUser.data['whoPrayForMe'] ?? [];
    whoPrayForMe = [...whoPrayForMe, this.phoneNumber];
    userCollection
        .document(mediatorPhoneNumber)
        .updateData({'whoPrayForMe': whoPrayForMe});
  }

  deleteMediators(mediatorPhoneNumber) {
    setUpdateDataTime();
    _deleteMyMediators(mediatorPhoneNumber);
    _deleteMediatorWhoPrayForMe(mediatorPhoneNumber);
    notifyListeners();
  }

  _deleteMyMediators(mediatorPhoneNumber) {
    this.mediators = this
        .mediators
        .where((phoneNumber) => phoneNumber != mediatorPhoneNumber)
        .toList();
    userCollection.document(this.phoneNumber).updateData({
      'mediators': this.mediators,
    });
  }

  _deleteMediatorWhoPrayForMe(mediatorPhoneNumber) async {
    DocumentSnapshot mediatorUser =
        await userCollection.document(mediatorPhoneNumber).get();
    List whoPrayForMe = mediatorUser.data['whoPrayForMe'];
    if (whoPrayForMe != null) {
      whoPrayForMe = whoPrayForMe
          .where((phoneNumber) => phoneNumber != this.phoneNumber)
          .toList();
      userCollection
          .document(mediatorPhoneNumber)
          .updateData({'whoPrayForMe': whoPrayForMe});
    }
  }

  void saveDeviceTokenInCloudFirestore(String deviceToken) {
    userCollection.document(this.phoneNumber).updateData({'deviceToken': deviceToken});
  }

  void checkMyMediators({List<User> mediators}) {
    for (User user in mediators) {
      for (String myMediatorPhoneNumber in this.mediators) {
        if (user.phoneNumber == myMediatorPhoneNumber) {
          user.isIAddedMediatorForYou = true;
        }
      }
    }
  }
}
