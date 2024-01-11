//
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:vidhaalay_app/screen/User_Screens/drawer_user.dart';
// import 'package:vidhaalay_app/screen/User_Screens/user_home_screen.dart';
// import 'package:vidhaalay_app/screen/User_Screens/user_more_screen.dart';
// import 'package:vidhaalay_app/screen/User_Screens/videos_screen.dart';
//
// import '../../controller/bottom_controller.dart';
// import '../../resourses/app_assets.dart';
// import '../../widgets/appTheme.dart';
// import 'drawer_user.dart';
// import 'drawer_user.dart';
// import 'drawer_user.dart';
//
// class BottomBarScreen extends StatefulWidget {
//   const BottomBarScreen({super.key});
//
//   @override
//   State<BottomBarScreen> createState() => _BottomBarScreenState();
// }
//
// class _BottomBarScreenState extends State<BottomBarScreen> {
//   BottomController bottomController  = Get.put(BottomController());
//
//   final screens = [
//     const UserHomeScreen(),
//     const VideoScreen(),
//     // const MyLecturesScreen(),
//     // const NotificationScreenUser(),
//     // const DrawerForUser(),
//     const UserMoreScreen(),
//   ];
//
//
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var deviceHeight = MediaQuery.of(context).size.height;
//     var deviceWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: IndexedStack(
//         index: bottomController.currentIndex.value,
//         children: screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         elevation: 0,
//         useLegacyColorScheme: false,
//         selectedFontSize: 14,
//         selectedItemColor: AppThemes.white,
//         unselectedItemColor: AppThemes.whiteOff,
//         showUnselectedLabels: true,
//         type: BottomNavigationBarType.fixed,
//         backgroundColor: Colors.black,
//         // showSelectedLabels: false,
//         items: [
//           BottomNavigationBarItem(
//             label: "Home",
//             icon: Image.asset(
//               AppAssets.homeIcon,
//               width: 22,
//               height: 22,
//               color: bottomController.currentIndexUser.value == 0
//                   ? AppThemes.white
//                   : AppThemes.whiteOff,
//             ),
//           ),
//
//           BottomNavigationBarItem(
//             label: "Video",
//             icon:  Image.asset(
//               AppAssets.videoIcon,
//               color: bottomController.currentIndexUser.value == 1
//                   ? AppThemes.white
//                   : AppThemes.whiteOff,
//               width: 22,
//               height: 22,
//             ),
//           ),
//           BottomNavigationBarItem(
//             label: "More",
//             icon:  Image.asset(
//               AppAssets.moreIcon,
//               width: 22,
//               height: 22,
//               color: bottomController.currentIndexUser.value == 2
//                   ? AppThemes.white
//                   : AppThemes.whiteOff,
//             ),
//           ),
//
//         ],
//         onTap: (value) {
//           setState(() {
//             bottomController.currentIndex.value = value;
//           });
//           if (value == 0) {
//             // profileController.RefreshTokenApiCall();
//             // profileController.ProfileApiCall();
//           } else if (value == 1) {
//             // Get.offAll(()=>BottomBarScreen(),arguments: {bottomController.currentIndex.value = 1});
//           }else if(value == 2){
//             // Get.offAll(()=>BottomBarScreen(),arguments: {bottomController.currentIndex.value = 2});
//             // bottomController.scaffoldKeyUser.currentState!.openDrawer();
//           }
//         },
//       ),
//     );
//   }
// }
