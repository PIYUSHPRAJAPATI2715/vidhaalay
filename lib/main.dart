import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vidhaalay_app/PractiseScreen/piechart.dart';
import 'package:vidhaalay_app/PractiseScreen/practise.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/no_internet_screen.dart';
import '../../widgets/appTheme.dart';
import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
// import 'notification_service/local_notifications.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

bool ischeck = false;
bool isdailogopen = false;

void checkstatus() async {
  var connectionactivityresult = await (Connectivity().checkConnectivity());
  if (connectionactivityresult == ConnectivityResult.mobile) {
    ischeck = true;
    // futureAdss = getad;
  } else if (connectionactivityresult == ConnectivityResult.wifi) {
    ischeck = true;
    // futureAdss = getad;
  } else if (connectionactivityresult == ConnectivityResult.none) {
    ischeck = false;
    if (isdailogopen == false) {
      // showmydailog();
      await Get.to(() => NoConnectionScreen(), arguments: []);
    }
  }
}

//https://vidhaalay-a464e.firebaseapp.com/__/auth/handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore, // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = MyHttpOverrides();
  // NotificationService().initializeNotification();
  await FirebaseMessaging.instance.setAutoInitEnabled(true);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const oneSeconds = const Duration(seconds: 1);
  Timer.periodic(oneSeconds, (Timer t) => checkstatus());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
            iconTheme: IconThemeData(color: Colors.white)),
        useMaterial3: true,
        primaryColor: AppThemes.primaryColor,
        primarySwatch: Colors.blueGrey,
      ),
      debugShowCheckedModeBanner: false,
      // initialRoute: "/bottomNavigationUserScreen",
      // initialRoute: "/drawerForUser",
      initialRoute: "/",
      // home: MyFormPage(),
      // home: PieChartSample1(),
      // initialRoute: "/drawerForTeacher",
      getPages: MyRouters.route,
      // home: MainColumn(),
    );
  }
}