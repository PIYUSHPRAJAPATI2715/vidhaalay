import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../widgets/appTheme.dart';

void main() {
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
      initialRoute: "/",
      getPages:MyRouters.route,
    );
  }
}

