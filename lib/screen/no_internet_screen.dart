import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

import '../main.dart';

class NoConnectionScreen extends StatelessWidget {
  // final Widget child;
  //
  // const CheckInternet({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isInternetOn && isScreenOpen) {
          return true;
        } else {
          showToast(message:"You are still not connected with internet. Please check the internet connection.");
          return false;
        }
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.65,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                      child: ImageIcon(AssetImage('assets/images/no-wifi.png'),
                          size: 200)),
                  // Icon(
                  //   Icons.signal_wifi_connected_no_internet_4,
                  //   size: 50,
                  //   color: AppThemes.black,
                  // )
                  // Image.asset('assets/images/no-wifi.png',fit: BoxFit.cover,)
                ),
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/Ellipse 20.png',
                        fit: BoxFit.fill,
                        color: AppThemes.primaryColor,
                      ),
                    ),
                    Positioned(
                      top: 80,
                      child: Text(
                        'No Internet Connection',
                        style: GoogleFonts.poppins(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: AppThemes.white,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 120,
                      child: Container(
                        width: 300,
                        // height: 50.h,
                        child: Text(
                          'You are not connected to the internet. Please connect to the internet.',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: GestureDetector(
                        onTap: () {
                          // setSt
                          if (isInternetOn && isScreenOpen) {
                            Navigator.pop(context);
                          } else {
                            showToast(message:"You are still not connected with internet. Please check the internet connection.");
                          }
                        },
                        child: Card(
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 35),
                            // alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: AppThemes.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Refresh",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppThemes.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
