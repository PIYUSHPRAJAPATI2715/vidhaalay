
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/setting_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class PrivacyPolicyScreen extends StatefulWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  State<PrivacyPolicyScreen> createState() => _PrivacyPolicyScreenState();
}

class _PrivacyPolicyScreenState extends State<PrivacyPolicyScreen> {
  SettingController settingController = Get.put(SettingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingController.privacypolicyAPICall();
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Privacy Policy",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: AppThemes.textBrown,
              fontSize: 19,
              fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Image.asset(
            AppAssets.arrowBack,
            width: 19,
            color: AppThemes.textBrown,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(
            () => SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: deviceWidth * 0.02, vertical: deviceHeight * 0.02),
            child: settingController.privacypolicyContent.value.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  settingController.privacypolicyContent.value.toString(),
                  style: TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ],
            )
                : Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
