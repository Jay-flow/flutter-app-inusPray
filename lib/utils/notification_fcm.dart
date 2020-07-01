import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_inus_pray/models/user.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
  }

  // Or do other work.
}

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

//  Future<void> showNotification({String title = appName, String text}) async {
//    var android =
//        AndroidNotificationDetails('inusPray', appName, '우리안에기도 앱 알림 채널');
//    var iOS = IOSNotificationDetails();
//    var platform = NotificationDetails(android, iOS);
//
//    await FlutterLocalNotificationsPlugin().show(0, title, text, platform);
//  }

  void _firebaseConfigure() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
//        showNotification(
//          title: message["notification"]["title"],
//          text: message["notification"]["body"],
//        );
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
//        showNotification(
//          title: message["notification"]["title"],
//          text: message["notification"]["body"],
//        );
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
//        showNotification(
//          title: message["notification"]["title"],
//          text: message["notification"]["body"],
//        );
      },
      onBackgroundMessage: Platform.isIOS ? null : myBackgroundMessageHandler,
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
      IosNotificationSettings(
        sound: true,
        badge: true,
        alert: true,
        provisional: false,
      ),
    );
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }
}
