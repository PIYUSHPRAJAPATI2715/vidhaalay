import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

class NotificationScreenUser extends StatefulWidget {
  const NotificationScreenUser({Key? key}) : super(key: key);

  @override
  State<NotificationScreenUser> createState() => _NotificationScreenUserState();
}

class _NotificationScreenUserState extends State<NotificationScreenUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: AppThemes.white,
        title: Text("Event Calender",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
              color: AppThemes.black,
              fontSize: 19,
              fontWeight: FontWeight.w600
          ),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Text("today".toUpperCase(),
                style: GoogleFonts.poppins(
                    color: AppThemes.black,
                    fontSize: 21,
                    fontWeight: FontWeight.w600
                ),),
            ),
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                itemCount: 5 ,
                shrinkWrap: true,
                itemBuilder:  (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 18),
                          color: const Color(0xffecffd2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           Row(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Image.asset(AppAssets.notificaationIcon, height: 16,),
                              const SizedBox(
                                 width: 10,
                               ),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                   Text("Holi Celebration",
                                     style: GoogleFonts.poppins(
                                         color: AppThemes.primaryColor,
                                         fontSize: 15,
                                         fontWeight: FontWeight.w500
                                     ),),
                                   Text("Holi Celebration ",
                                     style: GoogleFonts.poppins(
                                         color: Colors.grey,
                                         fontSize: 10,
                                         fontWeight: FontWeight.w500
                                     ),),
                                 ],
                               ),
                             ],
                           ),
                            Text("12:30 PM",
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400
                              ),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                },
            )
          ],
        ),
      ),
    );
  }
}
