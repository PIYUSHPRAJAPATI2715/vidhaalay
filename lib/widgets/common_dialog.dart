import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay/widgets/appTheme.dart';

class CommonDailog {
  static confirmationDialog(
      {required BuildContext context,
        required String confirmationSubTitle,
        VoidCallback? firstButtonOnTap = null,
        VoidCallback? secButtonOnTap = null,
        String title = "Confirmation",
        String secButtonText = "close",
        String firstButtonText = "Confirm",
      }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async {
            return true;
          },
          child: StatefulBuilder(
              builder: (context, setState1) => AlertDialog(
                titlePadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                contentPadding:
                EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                actionsPadding:
                EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                backgroundColor: AppThemes.white,
                surfaceTintColor: AppThemes.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  // Adjust the border radius here
                  side: BorderSide(
                    color: AppThemes.red,
                    width: 1.5, // Set the border width here
                  ),
                ),
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundColor: Colors.transparent,
                      // AppThemes.whiteOff,
                      child: Icon(CupertinoIcons.delete,color: AppThemes.red,)
                      // ImageIcon(
                      //   AssetImage(ConstAsset.warningIcon),
                      //   size: 24,
                      //   color: AppThemes.white,
                      // ),
                    ),
                    SizedBox(width: 10),
                    Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black)),
                  ],
                ),
                content: Text(confirmationSubTitle,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black)
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: secButtonOnTap == null ? () => Get.back() : firstButtonOnTap,
                    // onPressed:
                    //     () {
                    //   Navigator.of(context).pop(); // Close alert dialog
                    // },
                    child: Text(secButtonText.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black)
                    ),
                  ),
                  ElevatedButton(
                    onPressed: firstButtonOnTap == null ? () => Get.back() : firstButtonOnTap,
                    //     () {
                    //   Navigator.of(context).pop();
                    //   successDialog(context, successfullSubTitle);
                    // },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppThemes.red,
                      // Set the button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    child: Text(firstButtonText.toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.white)),
                  ),
                ],
              )),
        );
      },
    );
  }
}
