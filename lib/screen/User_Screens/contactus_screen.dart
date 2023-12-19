
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/setting_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  SettingController settingController = Get.put(SettingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingController.contactUsAPICall();
  }
  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Contact Us",
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
            child: settingController.contactUsContent.value.isNotEmpty
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  settingController.contactUsContent.value.toString(),
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
