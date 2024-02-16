import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/setting_controller.dart';
import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class TermsAndConditionScreen extends StatefulWidget {
  const TermsAndConditionScreen({super.key});

  @override
  State<TermsAndConditionScreen> createState() =>
      _TermsAndConditionScreenState();
}

class _TermsAndConditionScreenState extends State<TermsAndConditionScreen> {
  SettingController settingController = Get.put(SettingController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingController.termAndConditionAPICall();
  }

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms & Condition",
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
        () => settingController.termsContent.value.isNotEmpty
            ?  SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: deviceWidth * 0.04, vertical: deviceHeight * 0.02),
            child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        settingController.termsContent.value.toString(),
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ],
                  )
          ),
        ) : Container(
          width: deviceWidth,
          height: deviceHeight,
          child : Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
