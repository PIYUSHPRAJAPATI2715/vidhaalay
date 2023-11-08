import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/resourses/bottom_nav_screen.dart';

import '../../controller/bottom_controller.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'bottom_navbar_teacher.dart';

class DrawerForTeacher extends StatefulWidget {
  const DrawerForTeacher({Key? key}) : super(key: key);

  @override
  State<DrawerForTeacher> createState() => _DrawerForTeacherState();
}

class _DrawerForTeacherState extends State<DrawerForTeacher> {
  final bottomController = Get.put(BottomController());
  double value = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Align(
        alignment: Alignment.centerRight,
        child: Stack(
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
            SafeArea(
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
                          title: bottomController.currentIndexTeacher.value == 0
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
                            color: bottomController.currentIndexTeacher.value ==
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
                          title: bottomController.currentIndexTeacher.value == 0
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
                            color: bottomController.currentIndexTeacher.value ==
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
                          title: bottomController.currentIndexTeacher.value == 0
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
                            color: bottomController.currentIndexTeacher.value ==
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
                          title: bottomController.currentIndexTeacher.value == 0
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
                            color: bottomController.currentIndexTeacher.value ==
                                0 ? AppThemes.white : AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        SizedBox(height: size.height*.16,),
                        Container(
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
                      ],
                    ),
                  ),
                )),
            TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: value),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInCirc,
                builder: (_, double val, __) {
                  return (Transform(
                    transform: Matrix4.identity()
                      ..setEntry(3, 2, 0.001)..setEntry(0, 3, 200 * val)
                      ..rotateY((pi / 6) * val),
                    child: const Scaffold(
                      body:  BottomNavbarTeacher(),
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
      ),
    );
  }

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Switch Account'),
          content: const Text('Do you want to switch account?'),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Get.back();
                },

                child: const Text('No')
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed(MyRouters.signInPage);
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}
