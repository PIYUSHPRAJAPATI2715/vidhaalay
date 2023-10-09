import 'package:flutter/material.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

import '../../widgets/appTheme.dart';

class SchoolsDetailsScreen extends StatefulWidget {
  const SchoolsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SchoolsDetailsScreen> createState() => _SchoolsDetailsScreenState();
}

class _SchoolsDetailsScreenState extends State<SchoolsDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Washington University',
          style: TextStyle(
              color: AppThemes.black,
              fontWeight: FontWeight.w600,
              fontSize: 15
          ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: AppThemes.white
                // gradient: LinearGradient(
                //   colors: [
                //     Colors.white,
                //     Colors.white,
                //     AppThemes.white,
                //     AppThemes.white,
                //   ],
                //   end: Alignment.centerRight,
                //   begin: Alignment.centerLeft,
                //   stops: [0, .5, .501, 1],
                // ),
              ),
            ),

            Container(
              height: 220,
              decoration: const BoxDecoration(
                color: AppThemes.signupBg,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(170)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(100)),
                child: Image.asset(AppAssets.collageImg,fit: BoxFit.cover,width: double.maxFinite,),
              ),
            ),
            Positioned.fill(
              top: 170,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(70),topLeft: Radius.circular(10)),
                ),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Washington University",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                      ),
                      // const Text(
                      //   "Hello please login to continue",
                      //   style: TextStyle(
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.w500,
                      //     color: AppThemes.textGray,
                      //   ),
                      // ),
                      SizedBox(
                        height: size.height * 0.020,
                      ),
                    ],
                  )
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
