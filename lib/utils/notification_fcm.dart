import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

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

  NotificationFCM(deviceToken) {
    if (Platform.isIOS) _iOSPermission();
    if (deviceToken == null) {
      _getDeviceToken();
      _firebaseConfigure();
    }
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
    _firebaseMessaging.getToken().then((token) {
      
      print('Token: $token');
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
