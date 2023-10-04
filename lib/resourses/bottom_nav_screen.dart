import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/bottom_controller.dart';
import '../widgets/appTheme.dart';
import 'custon_drawer.dart';


class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  static var bottomNavigationScreen = "/bottomNavigationScreen";

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  final controller = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      key: controller.scaffoldKey,
      drawer: const CustomDrawer(),
      body: WillPopScope(
        onWillPop: ( ) async => false,
        child: Obx(() {
          return controller.screens[controller.currentIndex.value];
        }),
      ),
      bottomNavigationBar: Obx(() {
        return SizedBox(
          height: 70,
          child: Column(
            children: [
               Divider(
                color: AppThemes.textGray,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () => controller.currentIndex.value = 0,
                    child: Image.asset(
                      "assets/icons/home.png",
                      width: 25,
                      height: 25,
                      color: controller.currentIndex.value == 0 ? AppThemes
                          .primaryColor : AppThemes.white,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.currentIndex.value = 1,
                    child: Image.asset(
                      "assets/icons/calendar.png",
                      color: controller.currentIndex.value == 1 ? AppThemes
                          .primaryColor : AppThemes.white,
                      width: 25,
                      height: 25,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => controller.currentIndex.value = 2,
                    child: Image.asset(
                      "assets/icons/logs.png",
                      color: controller.currentIndex.value == 2 ? AppThemes
                          .primaryColor : AppThemes.white,
                      width: 25,
                      height: 25,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
