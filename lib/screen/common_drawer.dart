import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/controller/authentication/signin_controller.dart';
import 'package:vidhaalay_app/controller/new_botttom_controller.dart';
import 'package:vidhaalay_app/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay_app/models/login_model.dart';
import 'package:vidhaalay_app/repositories/teacher/class_list_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/videos_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/attendance_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/class_timetable_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/exam_result_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/exam_timetable_screen.dart';
import 'package:vidhaalay_app/screen/student_screen/syllabus_Screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/student_list_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/video_lecture_teacher_screen.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';

import '../login screens/splash.dart';
import '../models/multi_login_model.dart';

class commonDrawer extends StatefulWidget{

  @override
  State<commonDrawer> createState() => _commonDrawerState();
}

class _commonDrawerState extends State<commonDrawer> {
  final bottomController = Get.put(BottomNavBarController());
  // Rx<ClassList> getClassListModel = ClassList().obs;

  String username = '';

  @override
  void initState() {
    getUserName();
    super.initState();
  }

  getUserName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? name = await pref.getString('username');
    username = name!;
    setState(() {

    });
    print(username);
  }

  // Future getClassListData() async {
  //   isClassLoading = true;
  //   await getClassListRepo().then((value) {
  //     print("class value : $value");
  //     getClassListModel.value = value;
  //     isClassLoading = false;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Container(
      width: MediaQuery.of(context).size.width * 0.65, //<-- SEE HERE
      // color: AppThemes.primaryColor,
      child: Drawer(
        backgroundColor:  AppThemes.primaryColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              children: [
                Theme(
                  data: ThemeData(
                      dividerColor: Colors.transparent
                  ),
                  child: SizedBox(
                    height: size.height * 0.33,
                    child: DrawerHeader(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8dXNlcnxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=500&q=60', scale: 40),
                          ),
                          SizedBox(height: size.height * 0.016),
                          Text(
                            username,
                            style: TextStyle(
                              fontSize: 21,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.white,
                            ),
                          ),
                          Text(
                            bottomController.userType == 2 ?  "CLASS-${bottomController.userClassName}" : "", // Display user's name here
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: AppThemes.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                bottomController.userType == 0 ? Column(
                      children: [
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.myProfileScreen);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: const Text(
                            'My Profile',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Icon(
                            // Icons.person_2_outlined,
                            Icons.person,
                            color: AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.favoritesScreen);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: const Text(
                            'Favourite',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Icon(
                            Icons.favorite_border,
                            color: AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.notificationScreenUser);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: const Text(
                            'Notification',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Image.asset(
                            AppAssets.notification,
                            height: 20,
                            width: 24,
                            color: AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                        const SizedBox(height: 10,),
                        ListTile(
                          onTap: (){
                            Get.toNamed(MyRouters.settingScreenUser);
                          },
                          visualDensity:
                          const VisualDensity(
                              horizontal: -4, vertical: -4),
                          title: const Text(
                            'Settings',
                            style: TextStyle(
                                color: AppThemes.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w500),

                          ),
                          leading: Icon(
                            // "assets/icons/home.png",
                            Icons.settings_outlined,
                            color: AppThemes.white,
                            // width: 23,
                            // height: 23,
                          ),
                        ),
                      ],
                    )
                    : bottomController.userType == 1 ? Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.teacherAttendanceScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Attendance',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.personIcon,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: () {
                        Get.toNamed(MyRouters.teacherClassTimeScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Class Timetable',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.attendanceIcon,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.teacherExamTimeTableScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Exam Timetable',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      leading: Image.asset(
                        AppAssets.examTimeTableImg,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.createEventScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Create Event',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.eventsIcon,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        //styudent list
                        Get.to(()=>StudentListScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title:  Text(
                        'Student List',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Icon(
                        // "assets/icons/home.png",
                        Icons.person,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.sendNotificationScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Send Notification',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.notification,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.settingScreenUser);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Icon(
                        // "assets/icons/home.png",
                        Icons.settings_outlined,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                  ],
                ) :  Column(
                  children: [
                    ListTile(
                      onTap: (){
                        Get.to(() => VideoTeacherScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Video Lecture',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      leading: Image.asset(
                        AppAssets.videoIcon,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.to(() => SyllabusScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Syllabus',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      leading: Image.asset(
                        AppAssets.syllabusImg,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: () {
                        Get.to(() => ClassTimeTableScreen());

                        // Get.toNamed(MyRouters.teacherClassTimeScreen);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Class Timetable',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.attendanceIcon,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.to(() => ExamTimeTableScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Exam Timetable',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.examTimeTableImg,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.to(() => ExamResultScreen());
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Exam Result',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Image.asset(
                        AppAssets.examResultImg,
                        height: 20,
                        width: 24,
                        color: AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                    const SizedBox(height: 10,),
                    ListTile(
                      onTap: (){
                        Get.toNamed(MyRouters.settingScreenUser);
                      },
                      contentPadding: EdgeInsets.zero,
                      visualDensity:
                      const VisualDensity(
                          horizontal: -4, vertical: -4),
                      title: const Text(
                        'Settings',
                        style: TextStyle(
                            color: AppThemes.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),

                      ),
                      leading: Icon(
                        // "assets/icons/home.png",
                        Icons.settings_outlined,
                        color:  AppThemes.white,
                        // width: 23,
                        // height: 23,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: size.height*.05,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: (){
                      _showMultiLoginAlertDialog(context);
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          )
                      ),
                      child: Center(
                        child: Text(
                          'Multi Login'.toUpperCase(),
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height*.02,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: InkWell(
                    onTap: (){
                      // saveLoginData();
                      //
                      logOutUser();
                      // Get.offAllNamed(MyRouters.signInPage);
                    },
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          border: Border.all(
                              color: Colors.white,
                              width: 2
                          )
                      ),
                      child: Center(
                        child: const Text(
                          'LOGOUT',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  logOutUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    LoginModel modelSiteSettings = LoginModel();
    if (sharedPreference.getString("token") != null) {
      modelSiteSettings =
          LoginModel.fromJson(jsonDecode(sharedPreference.getString("token")!));
    }
    await sharedPreference.clear();
    Get.offAllNamed(MyRouters.signInPage);
    showToast("Logged out");
    if (modelSiteSettings.data != null) {
      sharedPreference.setString("token", jsonEncode(modelSiteSettings));
    }
    sharedPreference.setBool("isFirstTime", false);
  }

  // void _showMultiLoginAlertDialog(BuildContext context) {
  //   List<MultiLoginModel> loginData = [
  //     MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "student",email: "student6@yopmail.com",type :"student",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
  //   ];
  //
  //
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //     return Dialog(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(16.0),
  //       ),
  //       elevation: 0.0,
  //       backgroundColor: Colors.transparent,
  //       child: Container(
  //         padding: EdgeInsets.all(16.0),
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.circular(16.0),
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             Text(
  //               'Choose an Account',
  //               style: TextStyle(
  //                 fontSize: 18.0,
  //                 fontWeight: FontWeight.bold,
  //               ),
  //             ),
  //             SizedBox(height: 16.0),
  //             Column(
  //               children: loginData.map((user) {
  //                 return ListTile(
  //                   title: Text(user.toString()),
  //                   subtitle: Text(" "),
  //                   onTap: () {
  //                     // Handle user selection
  //                     // print('Selected user: ${user.name}');
  //                     Navigator.pop(context);
  //                   },
  //                 );
  //               }).toList(),
  //             ),
  //             SizedBox(height: 16.0),
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.pop(context);
  //               },
  //               child: Text('Cancel'),
  //             ),
  //           ],
  //         ),
  //       ),
  //     );
  //       },
  //   );
  // }

  // Future<void> saveLoginData(List<MultiLoginModel> data) async {
  //   List<MultiLoginModel> loginData = [
  //     MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "student",email: "student6@yopmail.com",type :"student",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
  //   ];
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  //   // List<String> encodedData = data.map((item) => json.encode(item.toJson())).toList();
  //   await prefs.setStringList('loginData', encodedData);
  // }

  // Future<void> saveLoginData() async {
  //   List<MultiLoginModel> loginData = [
  //     MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "student",email: "student6@yopmail.com",type :"student",password: "12@Mckumar"),
  //     MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
  //   ];
  //
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String> encodedData = loginData.map((item) => json.encode(item.toJson())).toList();
  //   await prefs.setStringList('loginData', encodedData);
  // }
  //
  // Future<List<MultiLoginModel>> getLoginData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   List<String>? encodedData = prefs.getStringList('loginData');
  //
  //   if (encodedData != null) {
  //     List<MultiLoginModel> data = encodedData.map((item) => MultiLoginModel.fromJson(json.decode(item))).toList();
  //     return data;
  //   } else {
  //     return [];
  //   }
  // }

  Future<void> _showMultiLoginAlertDialog(BuildContext context) async {
    final signInController = Get.put(SignInController());

    List<MultiLoginModel> loginData =
    // await getLoginData();
    [
      MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar"),
      MultiLoginModel(userName: "student",email: "student6@yopmail.com",type :"student",password: "12@Mckumar"),
      MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar"),
    ];
    
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
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: loginData.length, // Set your itemCount according to your data
              itemBuilder: (BuildContext context, int index) {
                var items = loginData[index];

                return Column(
                  children: [
                    Divider(
                      thickness: 1.0,
                      height: 2,
                    ),
                    ListTile(
                      // dense: true,
                      visualDensity: VisualDensity(vertical: -3),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                      leading: Icon(Icons.person),
                      title: Text(items.userName!),
                      subtitle: Text(items.email!),
                      onTap: () {
                        signInController.login(context: context,email: items.email!,
                          type: items.type!,
                          pass: items.password!,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),

          // actions: <Widget>[
          //   ElevatedButton(
          //     onPressed: () {
          //       Get.back();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: AppThemes.white,
          //       // Set the button color
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(4.0),
          //       ),
          //     ),
          //     child: Text('No'.toUpperCase(),
          //       style: GoogleFonts.poppins(
          //         fontSize: 14,
          //         fontWeight: FontWeight.w600,
          //         color: AppThemes.black,
          //       ),
          //     ),
          //   ),
          //
          //   ElevatedButton(
          //     onPressed: () {
          //       Get.back();
          //     },
          //     style: ElevatedButton.styleFrom(
          //       primary: AppThemes.primaryColor,
          //       // Set the button color
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(4.0),
          //       ),
          //     ),
          //     child: Text('Yes'.toUpperCase(),
          //         style: GoogleFonts.poppins(
          //           fontSize: 14,
          //           fontWeight: FontWeight.w600,
          //           color: AppThemes.white,
          //         ),
          //     ),
          //   ),
          // ],
        );
      },
    );
  }

}