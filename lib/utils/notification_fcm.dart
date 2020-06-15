import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

import 'package:flutter_inus_pray/models/user.dart';

// Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
//   if (message.containsKey('data')) {
//     // Handle data message
//     final dynamic data = message['data'];
//   }

//   if (message.containsKey('notification')) {
//     // Handle notification message
//     final dynamic notification = message['notification'];
//   }

//   // Or do other work.
// }

class NotificationFCM {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  User user;
  String deviceToken;

  NotificationFCM(User user) {
    this.user = user;
    if (Platform.isIOS) _iOSPermission();
    _getDeviceToken();
    _firebaseConfigure();
  }

  void _firebaseConfigure() {
    // TODO:: 앱이 켜져 있을때는 Notification이 전송 안됨 onMessage에서 메세지 표현 하는거 구현
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
      },
    );
  }

  void _getDeviceToken() {
    _firebaseMessaging.getToken().then((deviceToken) {
      this.user.saveDeviceTokenInCloudFirestore(deviceToken);
      print('Token: $deviceToken');
    });
  }

  void _iOSPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
