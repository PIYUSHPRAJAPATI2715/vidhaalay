import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controller/bottom_controller.dart';
import '../widgets/appTheme.dart';


class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final bottomController = Get.put(BottomController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Obx(() {
      return SizedBox(
        height: size.height,
        child: Drawer(
          width: size.width * .84,
          backgroundColor: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.height * .20,
                        child: DrawerHeader(
                          child: ListTile(
                            visualDensity:
                            const VisualDensity(horizontal: -4, vertical: -4),
                            title:const Text(
                             'User',
                              style:  TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppThemes.white),
                            ),
                            subtitle: const Text(
                             'user@gmail.com',
                              style:  TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                  color: AppThemes.white),
                            ),
                            onTap: () {
                              //  Get.toNamed(MyRouter.taskScreen);
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: size.width * .08).copyWith(left: size.width * .03),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(left: size.width * .05),
                                  child:  Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceBetween,
                                    children: [
                                      const Text(
                                        "Language",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500,
                                            color: AppThemes.white),
                                      ),
                                      Row(
                                        children: [
                                          const Text(
                                            "EN",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w500,
                                                color: AppThemes.white),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_outlined,
                                            color: AppThemes.primaryColor,
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                  SizedBox(
                        height: size.height * .03,
                      ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: bottomController.currentIndex.value == 0
                                      ? Text(
                                    'Home',
                                    style: const TextStyle(
                                        color: AppThemes.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                      : const Text(
                                    'Home',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: Image.asset(
                                    "assets/icons/home.png",
                                    color: bottomController.currentIndex.value ==
                                        0 ? AppThemes.primaryColor : AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppThemes.white,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    bottomController.currentIndex.value = 0;
                                    Get.back();
                                  },
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: bottomController.currentIndex.value == 2
                                      ? Text(
                                    'Logs',
                                    style: const TextStyle(
                                        color: AppThemes.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                      : const Text(
                                    'Logs',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: Image.asset(
                                    "assets/icons/logs.png",
                                    color: bottomController.currentIndex.value ==
                                        2 ? AppThemes.primaryColor : AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppThemes.white,
                                    size: 20,
                                  ),
                                  onTap: () {
                                    bottomController.currentIndex.value = 2;
                                    Get.back();
                                  },
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: bottomController.currentIndex.value == 1
                                      ? Text(
                                    'Scheduler',
                                    style: const TextStyle(
                                        color: AppThemes.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                      : const Text(
                                    'Scheduler',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: Image.asset(
                                    "assets/icons/calendar.png",
                                    color: bottomController.currentIndex.value ==
                                        1 ? AppThemes.primaryColor : AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppThemes.white,
                                    size: 20,
                                  ),
                                  onTap: () {bottomController.currentIndex.value = 1;
                                  Get.back();
                                  },
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: bottomController.currentIndex.value == 3
                                      ? Text(
                                    'Billing',
                                    style: const TextStyle(
                                        color: AppThemes.primaryColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  )
                                      : const Text(
                                    'Billing',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: SvgPicture.asset(
                                    "assets/images/billing.svg",
                                    color: bottomController.currentIndex.value ==
                                        3 ? AppThemes.primaryColor : AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppThemes.white,
                                  ),
                                  onTap: () {
                                    bottomController.currentIndex.value = 3;
                                    Get.back();
                                    // BillingScreen
                                  },
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title:  const Text(
                                    'Devices',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: SvgPicture.asset(
                                    "assets/icons/laptop.svg",
                                    color: AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppThemes.white,
                                  ),
                                  onTap: (){
                                    bottomController.currentIndex.value = 4;
                                    Get.back();
                                    // Get.toNamed(ConnectedDevicesScreen.connectedDevicesScreen);
                                    },
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text(
                                    'Switch Location',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: SvgPicture.asset(
                                    "assets/images/switch.svg",
                                    color: AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppThemes.white,
                                  ),
                                  onTap: () {
                                    // Get.toNamed(SwitchLocationScreen.switchLocationScreen);
                                  }
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title:  const Text(
                                    'Settings',
                                    style: TextStyle(
                                        color: AppThemes.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),

                                  ),
                                  leading: SvgPicture.asset(
                                    "assets/images/Group 1203.svg",
                                    color: AppThemes.white,
                                    width: 23,
                                    height: 23,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: AppThemes.white,
                                  ),
                                  // onTap: () => Get.toNamed(ConnectedDevicesScreen.connectedDevicesScreen),
                                ),
                                const Divider(
                                  color: AppThemes.textGray,
                                ),
                                ListTile(
                                  visualDensity:
                                  const VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title:  const Text(
                                    'Logout',
                                    style: TextStyle(
                                        color: Color(0xFFF7931E),
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  leading: Image.asset(
                                    "assets/icons/logoutIcon.png",
                                    // color: AppThemes.white,
                                    width: 25,
                                    height: 25,
                                  ),
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Color(0xFFF7931E),
                                  ),
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
