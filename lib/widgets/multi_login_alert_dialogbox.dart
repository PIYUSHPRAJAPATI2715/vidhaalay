import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/authentication/signin_controller.dart';
import 'package:vidhaalay_app/login%20screens/signin_screen.dart';
import 'package:vidhaalay_app/models/multi_login_model.dart';
import 'package:vidhaalay_app/repositories/multi_login_repo.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

Future<void> showMultiLoginAlertDialog(BuildContext context) async {
  List<MultiLoginModel> loginData = await getLoginData();
  // [
  //   MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar"),
  //   MultiLoginModel(userName: "student",email: "student6@yopmail.com",type :"student",password: "12@Mckumar"),
  //   MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
  //   MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
  // ];

  // loginData.add(MultiLoginModel(userName: , email: email, type: type, password: password))

  print("loginData : $loginData");

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        // titlePadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
          title: Text('Switch Account',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppThemes.black,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              loginData.length + 2, (index)  {
              if (index < loginData.length) {
                var items = loginData[index];
                return Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -3),
                      leading: Icon(Icons.person),
                      title: Text(items.userName!),
                      subtitle: Text(items.email!),
                      onTap: () {
                        final signInController = Get.put(SignInController());

                        signInController.login(
                          context: context,
                          email: items.email!,
                          type: items.type!,
                          pass: items.password!,
                        );
                      },
                    ),
                  ],
                );
              } else if (index == loginData.length) {
                return Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -3),
                      leading: Icon(Icons.add),
                      title: Text("Add another account"),
                      onTap: () {
                        Get.offAll(() => SignInPage());
                      },
                    ),
                  ],
                );
              } else {
                return Column(
                  children: [
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      visualDensity: VisualDensity(vertical: -3),
                      leading: Icon(Icons.logout),
                      title: Text("Sign out of all accounts"),
                      onTap: () {
                        deleteAllRecord();
                      },
                    ),
                  ],
                );
              }
            },),
          )
        // SingleChildScrollView(
        //   child: Container(
        //     height: 300,
        //     width: MediaQuery.of(context).size.width,
        //     // padding: EdgeInsets.symmetric(vertical: 5),
        //     // Adjust padding as needed
        //     // padding: EdgeInsets.all(8.0),
        //
        //     // Use a ListView.builder to build the list dynamically
        //     child: ListView.builder(
        //       // shrinkWrap: true,
        //       itemCount: loginData.length + 2,
        //       // Additional items for "Add another account" and "Sign out of all accounts" options
        //       itemBuilder: (BuildContext context, int index) {
        //         if (index < loginData.length) {
        //           var items = loginData[index];
        //           return Column(
        //             children: [
        //               Divider(
        //                 height: 1,
        //                 thickness: 1,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(vertical: -3),
        //                 leading: Icon(Icons.person),
        //                 title: Text(items.userName!),
        //                 subtitle: Text(items.email!),
        //                 onTap: () {
        //                   final signInController = Get.put(SignInController());
        //
        //                   signInController.login(
        //                     context: context,
        //                     email: items.email!,
        //                     type: items.type!,
        //                     pass: items.password!,
        //                   );
        //                 },
        //               ),
        //             ],
        //           );
        //         } else if (index == loginData.length) {
        //           return Column(
        //             children: [
        //               Divider(
        //                 height: 1,
        //                 thickness: 1,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(vertical: -3),
        //                 leading: Icon(Icons.add),
        //                 title: Text("Add another account"),
        //                 onTap: () {
        //                   Get.offAll(() => SignInPage());
        //                 },
        //               ),
        //             ],
        //           );
        //         } else {
        //           return Column(
        //             children: [
        //               Divider(
        //                 height: 1,
        //                 thickness: 1,
        //                 color: Colors.grey,
        //               ),
        //               ListTile(
        //                 visualDensity: VisualDensity(vertical: -3),
        //                 leading: Icon(Icons.logout),
        //                 title: Text("Sign out of all accounts"),
        //                 onTap: () {
        //                   deleteAllRecord();
        //                 },
        //               ),
        //               // No divider after the last item
        //             ],
        //           );
        //         }
        //       },
        //     ),
        //   ),
        // )
      );
    },
  );
}
