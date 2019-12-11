// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'dart:io';

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

// class NotificationFCM {
//   final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//   NotificationFCM() {
//     if (Platform.isIOS) _iOSPermission();
//     _getDeviceToken();
//     _firebaseConfigure();
//   }

//   void _firebaseConfigure() {
//     _firebaseMessaging.configure(
//       onMessage: (Map<String, dynamic> message) async {
//         print('on message $message');
//       },
//       onBackgroundMessage: myBackgroundMessageHandler,
//       onResume: (Map<String, dynamic> message) async {
//         print('on resume $message');
//       },
//       onLaunch: (Map<String, dynamic> message) async {
//         print('on launch $message');
//       },
//     );
//   }

//   void _getDeviceToken() {
//     _firebaseMessaging.getToken().then((token) {
//       print('Token: $token');
//     });
//   }

//   void _iOSPermission() {
//     _firebaseMessaging.requestNotificationPermissions(
//         IosNotificationSettings(sound: true, badge: true, alert: true));
//     _firebaseMessaging.onIosSettingsRegistered
//         .listen((IosNotificationSettings settings) {
//       print("Settings registered: $settings");
//     });
//   }
// }
