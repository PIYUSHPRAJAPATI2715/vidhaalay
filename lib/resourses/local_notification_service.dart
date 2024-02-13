// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
//
// class NotificationHelper{
//
//
//   static Future<void> initialize(
//       FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
//     var androidInitialize =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     // var iOSInitialize = new IOSInitializationSettings();
//     var initializationsSettings = new InitializationSettings(
//         android: androidInitialize,);
//
//     flutterLocalNotificationsPlugin.initialize(initializationsSettings,
//         // onSelectNotification: (String? payload) async {
//         //   try {
//         //     if (payload != null && payload != '') {
//         //       PayLoadBody payLoadBody = PayLoadBody.fromJson(jsonDecode(payload));
//         //       if (payLoadBody.topicName == 'Order Notification') {
//         //         Get.to(() => OrderView());
//         //       }
//         //     }
//         //   } catch (e) {}
//         //   return;
//         // }
//         );
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       NotificationHelper.showNotification(
//           message, flutterLocalNotificationsPlugin, false);
//
//       try {
//         if (message != null && message.data.isNotEmpty) {
//           NotificationBody _notificationBody =
//           convertNotification(message.data);
//
//           if (_notificationBody.topic == 'Order Notification') {
//             Get.to(() => OrderView());
//           }
//         }
//       } catch (e) {
//         print(e.toString());
//       }
//     });
//
//     FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
//       // try {
//       //   if (message != null && message.data.isNotEmpty) {
//       //     NotificationBody _notificationBody =
//       //     convertNotification(message.data);
//       //     if (_notificationBody.topic == 'general') {
//       //       Get.to(() => OrderView());
//       //     }
//       //   }
//       // } catch (e) {
//       //   print(e.toString());
//       // }
//     });
//   }
//
//   // static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   // FlutterLocalNotificationsPlugin();
//   //
//   // static void initialize() {
//   //   const InitializationSettings initializationSettings =
//   //   InitializationSettings(
//   //     android: AndroidInitializationSettings("@mipmap/ic_launcher"),
//   //   );
//   //
//   //   _notificationsPlugin.initialize(
//   //     initializationSettings,
//   //   );
//   // }
//   //
//   // AndroidNotificationChannel channel = AndroidNotificationChannel(
//   //   "my_foreground",
//   //   "MY FOREGROUND SERVICE",
//   //   description:
//   //   'This channel is used for important notifications.',
//   //   importance: Importance.high,
//   //   playSound: false,
//   //   enableVibration: false,
//   // );
//   //
//   // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   // FlutterLocalNotificationsPlugin();
//   //
//   // await flutterLocalNotificationsPlugin
//   //     .resolvePlatformSpecificImplementation<
//   //     AndroidFlutterLocalNotificationsPlugin>()
//   //     ?.createNotificationChannel(channel);
//
// }
