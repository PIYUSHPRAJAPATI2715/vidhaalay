import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:vidhaalay_app/screen/User_Screens/setting_screen.dart';
import 'package:vidhaalay_app/screen/User_Screens/user_home_screen.dart';

import '../../controller/bottom_controller.dart';
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
  List<ScreenHiddenDrawer> pages = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: 'Home Page',
            baseStyle: const TextStyle(
              fontSize: 14
            ),
            selectedStyle: TextStyle()
          ),
          const UserHomeScreen()
      ),
      ScreenHiddenDrawer(
          ItemHiddenMenu(
              name: 'Settings',
              baseStyle: const TextStyle(fontSize: 14),
              selectedStyle: TextStyle()),
          const SettingScreenUser()),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // return Drawer();
    return HiddenDrawerMenu(
      typeOpen: TypeOpen.FROM_RIGHT,
      // tittleAppBar: Row(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   mainAxisAlignment: MainAxisAlignment.start,
      //   children: const [
      //     Icon(
      //       Icons.location_pin,
      //       color: AppThemes.primaryColor,
      //       size: 20,
      //     ),
      //     SizedBox(
      //       width: 4,
      //     ),
      //     Text(
      //       '2282 Lakewood Drive',
      //       style: TextStyle(
      //           color: AppThemes.black,
      //           fontWeight: FontWeight.w600,
      //           fontSize: 15),
      //     ),
      //   ],
      // ),
      actionsAppBar: [
        Padding(
          padding: const EdgeInsets.only(right: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ClipOval(
                child: Image.asset(
                  AppAssets.studentImg,
                  height: 35,
                ),
              )
            ],
          ),
        ),
      ],
      disableAppBarDefault: false,
      backgroundColorMenu: Colors.deepOrange,
      screens: pages,
      initPositionSelected: 0,
      slidePercent: 50,
      leadingAppBar:  Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: const [
          Icon(
            Icons.location_pin,
            color: AppThemes.primaryColor,
            size: 20,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            '2282 Lakewood Drive',
            style: TextStyle(
                color: AppThemes.black,
                fontWeight: FontWeight.w600,
                fontSize: 15),
          ),
        ],
      ),
    );

  }
}


//
// class DrawerForUser extends StatefulWidget {
//   const DrawerForUser({Key? key}) : super(key: key);
//
//   @override
//   State<DrawerForUser> createState() => _DrawerForUserState();
// }
//
// class _DrawerForUserState extends State<DrawerForUser> {
//   final bottomController = Get.put(BottomController());
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Obx(() {
//       return Drawer(
//         width: size.width * .78,
//         backgroundColor: AppThemes.primaryColor,
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Theme(
//                 data: ThemeData(
//                     dividerColor: Colors.transparent
//                 ),
//                 child: SizedBox(
//                   height: size.height * 0.33,
//                   child: DrawerHeader(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         const CircleAvatar(
//                           radius: 60,
//                           backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', scale: 40),
//                         ),
//                         SizedBox(height: size.height * 0.016),
//                         const Text(
//                           "User", // Display user's name here
//                           style: TextStyle(
//                             fontSize: 21,
//                             fontWeight: FontWeight.w600,
//                             color: AppThemes.white,
//                           ),
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               ListTile(
//                 visualDensity:
//                 const VisualDensity(
//                     horizontal: -4, vertical: -4),
//                 title: bottomController.currentIndex.value == 0
//                     ? const Text(
//                   'Cart',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 )
//                     : const Text(
//                   'Cart',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//
//                 ),
//                 leading: Image.asset(
//                   AppAssets.cartIcon,
//                   height: 20,
//                   width: 24,
//                   color: bottomController.currentIndex.value ==
//                       0 ? AppThemes.white : AppThemes.white,
//                   // width: 23,
//                   // height: 23,
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               ListTile(
//                 visualDensity:
//                 const VisualDensity(
//                     horizontal: -4, vertical: -4),
//                 title: bottomController.currentIndex.value == 0
//                     ? const Text(
//                   'My Subscription',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 )
//                     : const Text(
//                   'My Subscription',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//
//                 ),
//                 leading: Image.asset(
//                 AppAssets.mySubcription,
//                   height: 20,
//                   width: 24,
//                   color: bottomController.currentIndex.value ==
//                       0 ? AppThemes.white : AppThemes.white,
//                   // width: 23,
//                   // height: 23,
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               ListTile(
//                 visualDensity:
//                 const VisualDensity(
//                     horizontal: -4, vertical: -4),
//                 title: bottomController.currentIndex.value == 0
//                     ? const Text(
//                   'Notification',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 )
//                     : const Text(
//                   'Notification',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//
//                 ),
//                 leading: Image.asset(
//                   AppAssets.notification,
//                   height: 20,
//                   width: 24,
//                   color: bottomController.currentIndex.value ==
//                       0 ? AppThemes.white : AppThemes.white,
//                   // width: 23,
//                   // height: 23,
//                 ),
//               ),
//               const SizedBox(height: 10,),
//               ListTile(
//                 onTap: (){
//                   Get.toNamed(MyRouters.settingScreenUser);
//                 },
//                 visualDensity:
//                 const VisualDensity(
//                     horizontal: -4, vertical: -4),
//                 title: bottomController.currentIndex.value == 0
//                     ? const Text(
//                   'Settings',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//                 )
//                     : const Text(
//                   'Settings',
//                   style: TextStyle(
//                       color: AppThemes.white,
//                       fontSize: 18,
//                       fontWeight: FontWeight.w500),
//
//                 ),
//                 leading: Icon(
//                   // "assets/icons/home.png",
//                   Icons.settings_outlined,
//                   color: bottomController.currentIndex.value ==
//                       0 ? AppThemes.white : AppThemes.white,
//                   // width: 23,
//                   // height: 23,
//                 ),
//               ),
//                SizedBox(height: size.height*.16,),
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 48.0,vertical: 8),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(50),
//                     border: Border.all(
//                         color: Colors.white,
//                         width: 2
//                     )
//                 ),
//                 child: const Text(
//                   'LOGOUT',
//                   style: TextStyle(
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
