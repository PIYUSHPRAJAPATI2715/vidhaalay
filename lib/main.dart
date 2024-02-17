import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vidhaalay_app/PractiseScreen/calendar_screen.dart';
import 'package:vidhaalay_app/PractiseScreen/piechart.dart';
import 'package:vidhaalay_app/PractiseScreen/practise.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/resourses/local_notification_service.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/no_internet_screen.dart';
import '../../widgets/appTheme.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'notification_service/local_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

bool isInternetOn = false;
bool isScreenOpen = false;

void checkstatus() async {
  var connectionactivityresult = await (Connectivity().checkConnectivity());
  if (connectionactivityresult == ConnectivityResult.mobile) {
    isInternetOn = true;
    // isScreenOpen = false;
    if (isInternetOn && isScreenOpen) {
      Get.back();
      isScreenOpen = false;
    }
    // futureAdss = getad;
  } else if (connectionactivityresult == ConnectivityResult.wifi) {
    isInternetOn = true;
    if (isInternetOn && isScreenOpen) {
      Get.back();
      isScreenOpen = false;
    }
    // futureAdss = getad;
  } else if (connectionactivityresult == ConnectivityResult.none) {
    isInternetOn = false;
    isScreenOpen = true;
    if (isScreenOpen == true) {
      await Get.to(() => NoConnectionScreen(), arguments: []);
    } else {
      Get.back();
    }
  }
}

// Brandcards

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('A bg message just showed up :  ${message.messageId}');
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    description: 'This channel is used for important notifications',
    showBadge: false,
    importance: Importance.high,
    playSound: true);

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<String> imageToBase64String(String imageUrl) async {
  final response = await http.get(Uri.parse(imageUrl));

  if (response.statusCode == 200) {
    final List<int> imageBytes = response.bodyBytes;
    final String base64String = base64Encode(imageBytes);
    return base64String;
  } else {
    throw Exception('Failed to load image from URL');
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();

  // LocalNotificationService.initialize();
  FirebaseMessaging.instance.subscribeToTopic("All");

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  const oneSeconds = const Duration(seconds: 1);
  Timer.periodic(oneSeconds, (Timer t) => checkstatus());
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentSessionYear();
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      // AndroidNotification? android = message.notification?.android;
      // if (android != null) {
        // String? image = message.notification?.android?.imageUrl;
        // print('ImageUrl $image');
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification!.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(channel.id, channel.name,
                    channelDescription: channel.description,
                    // fullScreenIntent: true,
                    importance: Importance.high,
                    // channel.description,
                    channelShowBadge: true,
                    color: Colors.blue,
                    playSound: true,
                    icon: '@mipmap/ic_launcher'),
              ));
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return GetMaterialApp(
      title: 'vidhaalay',
      theme: ThemeData(
        fontFamily: "Poppins",
        appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(color: Colors.white),
            actionsIconTheme: IconThemeData(color: Colors.white),
            iconTheme: IconThemeData(color: Colors.white)
        ),
        useMaterial3: true,
        primaryColor: AppThemes.primaryColor,
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: "/bottomNavigationUserScreen",
      // initialRoute: "/drawerForUser",
      initialRoute: "/",
      // home: CalndarScreen(),
      // MyFormPage(),
      // initialRoute: "/drawerForTeacher",
      getPages: MyRouters.route,
      // home: MainColumn(),
    );
  }
}