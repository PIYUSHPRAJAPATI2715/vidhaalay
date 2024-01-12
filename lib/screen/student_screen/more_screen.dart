import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';

class MoreScreen extends StatefulWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  State<MoreScreen> createState() => _MoreScreenState();
}

class _MoreScreenState extends State<MoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('More',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 50,horizontal: 20),
        child: Column(
          children: [
            // InkWell(
            //   onTap: (){
            //     Get.toNamed(
            //         MyRouters.drawerForUser
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.2),
            //           spreadRadius: 1,
            //           blurRadius: 2,
            //           offset: const Offset(0, 2),
            //         ),
            //       ],
            //     ),
            //     child:  Row(
            //       children: [
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: const [
            //                Text('Click here for User UI',style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 18
            //               ),),
            //
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
            // const SizedBox(
            //   height: 40,
            // ),
            // InkWell(
            //   onTap: (){
            //     Get.toNamed(
            //         MyRouters.drawerForTeacher
            //     );
            //   },
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 20),
            //     decoration: BoxDecoration(
            //       color: Colors.white,
            //       borderRadius: BorderRadius.circular(10),
            //       boxShadow: [
            //         BoxShadow(
            //           color: Colors.black.withOpacity(0.2),
            //           spreadRadius: 1,
            //           blurRadius: 2,
            //           offset: const Offset(0, 2),
            //         ),
            //       ],
            //     ),
            //     child:  Row(
            //       children: [
            //         Expanded(
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: const[
            //                Text('Click here for Teacher UI',style: TextStyle(
            //                   color: Colors.black,
            //                   fontWeight: FontWeight.w600,
            //                   fontSize: 18
            //               ),),
            //
            //             ],
            //           ),
            //         )
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
