import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/screen/User_Screens/setting_screen.dart';
import 'package:vidhaalay_app/screen/User_Screens/user_home_screen.dart';

import '../../controller/bottom_controller.dart';
import '../../resourses/api_constant.dart';
import '../../resourses/app_assets.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

import 'bottom_nav_user.dart';

// import '../../resourses/app_assets.dart';
// import '../../widgets/appTheme.dart';
// import 'bottom_nav_user.dart';
//

class DrawerForUser extends StatefulWidget {
  const DrawerForUser({super.key});

  @override
  State<DrawerForUser> createState() => _DrawerForUserState();
}

class _DrawerForUserState extends State<DrawerForUser> {

  final bottomController = Get.put(BottomController());
  logOutUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    LoginModel modelSiteSettings = LoginModel();
    if (sharedPreference.getString("token") != null) {
      modelSiteSettings =
          LoginModel.fromJson(jsonDecode(sharedPreference.getString("token")!));
    }
    await sharedPreference.clear();
    Get.offAllNamed(MyRouters.signInPage);
    showToast("Logged out");
    if (modelSiteSettings.data != null) {
      sharedPreference.setString("token", jsonEncode(modelSiteSettings));
    }
    sharedPreference.setBool("isFirstTime", false);
  }
  double value = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppThemes.primaryColor,
                    AppThemes.primaryColor,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                )),
          ),
          Align(
            alignment: Alignment.topRight,
            child: SafeArea(
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Theme(
                          data: ThemeData(
                              dividerColor: Colors.transparent
                          ),
                          child: SizedBox(
                            height: size.height * 0.33,
                            child: DrawerHeader(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const CircleAvatar(
                                    radius: 60,
                                    backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', scale: 40),
                                  ),
                                  SizedBox(height: size.height * 0.016),
                                  const Text(
                                    "User", // Display user's name here
                                    style: TextStyle(
                                      fontSize: 21,
                                      fontWeight: FontWeight.w600,
                                      color: AppThemes.white,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.myProfileScreen);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: bottomController.currentIndex.value == 0
                              ? const Text(
                            'My Profile',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                              : const Text(
                            'My Profile',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                           leading: Icon(
                             // Icons.person_2_outlined,
                             Icons.person,
                             color: bottomController.currentIndex.value ==
                                 0 ? AppThemes.white : AppThemes.white,
                             // width: 23,
                             // height: 23,
                           ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.favoritesScreen);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: bottomController.currentIndex.value == 0
                              ? const Text(
                            'Favourite',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                              : const Text(
                            'Favourite',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Icon(
                            Icons.favorite_border,
                            color: bottomController.currentIndex.value ==
                                0 ? AppThemes.white : AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.notificationScreenUser);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: bottomController.currentIndex.value == 0
                              ? const Text(
                            'Notification',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                              : const Text(
                            'Notification',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Image.asset(
                            AppAssets.notification,
                            height: 20,
                            width: 24,
                            color: bottomController.currentIndex.value ==
                                0 ? AppThemes.white : AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.settingScreenUser);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: bottomController.currentIndex.value == 0
                              ? const Text(
                            'Settings',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),
                          )
                              : const Text(
                            'Settings',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Icon(
                            // "assets/icons/home.png",
                            Icons.settings_outlined,
                            color: bottomController.currentIndex.value ==
                                0 ? AppThemes.white : AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        SizedBox(height: size.height*.16,),
                        InkWell(
                          onTap: () async{
                           await logOutUser();
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.white,
                                    width: 2
                                )
                            ),
                            child: const Text(
                              'LOGOUT',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ),
          TweenAnimationBuilder(
              tween: Tween<double>(begin: 0, end: value),
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInCirc,
              builder: (_, double val, __) {
                return (Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)..setEntry(0, 3, -200 * val)
                    ..rotateY((pi / 6) * val),
                  child: const Scaffold(
                    body:  BottomNavigationUserScreen(),
                  ),
                ));
              }),
          GestureDetector(
            onHorizontalDragUpdate: (e) {
              if (e.delta.dx > 0) {
                setState(() {
                  value = 1;
                });
              }
              else {
                setState(() {
                  value = 0;
                });
              }
            },
          )
        ],
      ),
    );
  }
}
