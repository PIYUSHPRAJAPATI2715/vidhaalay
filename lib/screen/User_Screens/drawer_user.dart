// import 'package:flutter/material.dart';
// import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';
//
// import '../../resourses/app_assets.dart';
// import '../../widgets/appTheme.dart';
// import 'bottom_nav_user.dart';
//
// class DrawerForUser extends StatefulWidget {
//   const DrawerForUser({super.key});
//
//   @override
//   State<DrawerForUser> createState() => _DrawerForUserState();
// }
//
// class _DrawerForUserState extends State<DrawerForUser> {
//   List<ScreenHiddenDrawer> pages = [];
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     pages = [
//       // ScreenHiddenDrawer(
//       //     ItemHiddenMenu(
//       //       name: 'Home Page',
//       //       baseStyle: const TextStyle(
//       //         fontSize: 14
//       //       ),
//       //       selectedStyle: TextStyle()
//       //     ),
//       //     BottomNavigationScreen()
//       // ),
//       ScreenHiddenDrawer(
//           ItemHiddenMenu(
//               name: '',
//               baseStyle: const TextStyle(fontSize: 14),
//               selectedStyle: TextStyle()),
//           const BottomNavigationUserScreen()),
//     ];
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return Drawer();
//     return HiddenDrawerMenu(
//       tittleAppBar: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: const [
//           Icon(
//             Icons.location_pin,
//             color: AppThemes.primaryColor,
//             size: 20,
//           ),
//           SizedBox(
//             width: 4,
//           ),
//           Text(
//             '2282 Lakewood Drive',
//             style: TextStyle(
//                 color: AppThemes.black,
//                 fontWeight: FontWeight.w600,
//                 fontSize: 15),
//           ),
//         ],
//       ),
//       actionsAppBar: [
//         Padding(
//           padding: const EdgeInsets.only(right: 12.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               ClipOval(
//                 child: Image.asset(
//                   AppAssets.studentImg,
//                   height: 35,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//       disableAppBarDefault: false,
//       backgroundColorMenu: Colors.deepOrange,
//       screens: pages,
//       initPositionSelected: 0,
//       slidePercent: 50,
//     );
//   }
// }
