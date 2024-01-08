import 'package:get/get.dart';
import 'package:vidhaalay_app/screen/User_Screens/address_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/create_exam_timetable.dart';
import 'package:vidhaalay_app/screen/teacher_flow/exam_timetable_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/student_list_screen.dart';
import 'package:vidhaalay_app/screen/teacher_flow/teacher_event_screen.dart';

import '../controller/bottom_controller.dart';
import '../login screens/create_new_pass.dart';
import '../login screens/forget_email_screen.dart';
import '../login screens/forgot_otp_sms.dart';
import '../login screens/forgot_otp_sms.dart';
import '../login screens/forgot_pass_screen.dart';
import '../login screens/forgot_sms_screen.dart';
import '../login screens/intro_page_screen.dart';
import '../login screens/otp_for_email.dart';
import '../login screens/otp_screen.dart';
import '../login screens/otp_sms_screen.dart';
import '../login screens/signin_screen.dart';
import '../login screens/signup_screen.dart';
import '../login screens/splash.dart';
import '../login screens/verifyWithMobile.dart';
import '../login screens/verify_screen_sms_mail.dart';
import '../login screens/verify_with_mail.dart';
import '../login screens/verify_with_sms_screen.dart';
import '../resourses/bottom_nav_screen.dart';
import '../resourses/custon_drawer.dart';
import '../screen/User_Screens/bottom_nav_user.dart';
import '../screen/User_Screens/change_password_user.dart';
import '../screen/User_Screens/drawer_user.dart';
import '../screen/User_Screens/favorites_screen.dart';
import '../screen/User_Screens/my_profile_screen.dart';
import '../screen/User_Screens/notification_user_screen.dart';
import '../screen/User_Screens/registrtion_screens.dart';
import '../screen/User_Screens/schools_details_Screen.dart';
import '../screen/User_Screens/setting_screen.dart';
import '../screen/student_screen/celebration_screen.dart';
import '../screen/student_screen/class_timetable_screen.dart';
import '../screen/student_screen/exam_result_screen.dart';
import '../screen/student_screen/exam_timetable_screen.dart';
import '../screen/student_screen/my_profile_student.dart';
import '../screen/student_screen/syllabus_Screen.dart';
import '../screen/teacher_flow/create_class_timeTable.dart';
import '../screen/teacher_flow/create_event_screen.dart';
import '../screen/teacher_flow/drawer_teacher.dart';
import '../screen/teacher_flow/exam_result_Screen_teacher.dart';
import '../screen/teacher_flow/my_profile_teacher_screen.dart';
import '../screen/teacher_flow/send_notification_screen.dart';
import '../screen/teacher_flow/student_details_screen.dart';
import '../screen/teacher_flow/teacher_attendance_Screen.dart';
import '../screen/teacher_flow/teacher_classTime_table.dart';



class MyRouters{
  static var splash = "/splash";
  static var introPageScreen = "/introPageScreen";
  static var signInPage = "/signInPage";
  static var signupScreen = "/signupScreen";
  static var forgotPasswordScreen = "/forgotPasswordScreen";
  static var verifyOtpLogin = "/verifyOtpLogin";
  static var verifyOtpLoginSms = "/verifyOtpLoginSms";
  static var otpScreen = "/otpScreen";
  static var otpScreenEmail = "/otpScreenEmail";
  static var forgetEmailScreen = "/forgetEmailScreen";
  static var forgetSmsScreen = "/forgetSmsScreen";
  static var verifyWithSms = "/verifyWithSms";
  static var createPasswordScreen = "/createPasswordScreen";
  static var bottomNavigationScreen = "/bottomNavigationScreen";
  static var schoolsDetailsScreen = "/schoolsDetailsScreen";
  static var settingScreenUser = "/settingScreenUser";
  static var changePasswordUser = "/changePasswordUser";
  static var myProfileScreen = "/myProfileScreen";
  static var favoritesScreen = "/favoritesScreen";
  static var registrationScreen = "/registrationScreen";
  static var drawerForUser = "/drawerForUser";
  static var customDrawer = "/customDrawer";
  static var bottomNavigationUserScreen = "/bottomNavigationUserScreen";
  static var notificationScreenUser = "/notificationScreenUser";
  static var myProfileScreenStu = "/myProfileScreenStu";
  static var syllabusScreen = "/syllabusScreen";
  static var classTimeTableScreen = "/classTimeTableScreen";
  static var examTimeTableScreen = "/examTimeTableScreen";
  static var examResultScreen = "/examResultScreen";
  static var celebrationScreenStu = "/celebrationScreenStu";
  static var myProfileTeacher = "/myProfileTeacher";
  static var verifyWithMail = "/verifyWithMail";

  // user
  static var addressScreen = "/addressScreen";


  //teacher
  static var drawerForTeacher = "/drawerForTeacher";
  static var sendNotificationScreen = "/sendNotificationScreen";
  static var studentListScreen = "/studentListScreen";
  static var studentDetailsScreen = "/studentDetailsScreen";
  static var createEventScreen = "/createEventScreen";
  static var teacherEventsScreen = "/teacherEventsScreen";
  static var examResultScreenTeacher = "/examResultScreenTeacher";
  static var teacherExamTimeTableScreen = "/teacherExamTimeTableScreen";
  static var teacherClassTimeScreen = "/teacherClassTimeScreen";
  static var teacherAttendanceScreen = "/teacherAttendanceScreen";
  static var createTimeTableScreen = "/createTimeTableScreen";
  static var createExamTimeTable = "/createExamTimeTable";
  static var otpSmsScreen = "/otpSmsScreen";
  static var forgotOtpSmsScreen = "/forgotOtpSmsScreen";
  static var studenListScreen = "/forgotOtpSmsScreen";


  static var route = [

    // auth screens
    GetPage(name: '/', page: () =>  const Splash()),
    GetPage(name: '/introPageScreen', page: () =>  const IntroPageScreen()),
    GetPage(name: '/signInPage', page: () =>  const SignInPage()),
    GetPage(name: '/signupScreen', page: () =>  const SignupScreen()),
    GetPage(name: '/forgotPasswordScreen', page: () =>  const ForgotPasswordScreen()),
    GetPage(name: '/verifyOtpLogin', page: () =>  const VerifyOtpLogin()),
    GetPage(name: '/forgetEmailScreen', page: () =>  const ForgetEmailScreen()),
    GetPage(name: '/verifyWithMail', page: () =>  const VerifyWithMail()),
    GetPage(name: '/forgetSmsScreen', page: () =>  const ForgetSmsScreen()),
    GetPage(name: '/otpScreen', page: () =>  const OtpScreen()),
    GetPage(name: '/otpScreenEmail', page: () =>  const OtpScreenEmail()),
    GetPage(name: '/otpSmsScreen', page: () =>  const OtpSmsScreen()),
    GetPage(name: '/createPasswordScreen', page: () =>  const CreatePasswordScreen()),
    GetPage(name: '/verifyWithSms', page: () =>  const VerifyWithSms()),
    GetPage(name: '/verifyOtpLoginSms', page: () =>  const VerifyOtpLoginSms()),
    GetPage(name: '/forgotOtpSmsScreen', page: () =>  const ForgotOtpSmsScreen()),

    //student screens
    GetPage(name: '/bottomNavigationScreen', page: () =>  const BottomNavigationScreen()),
    GetPage(name: '/myProfileScreenStu', page: () =>  const MyProfileScreenStu()),

    //user screens
    GetPage(name: '/bottomNavigationUserScreen', page: () =>  const BottomNavigationUserScreen()),
    // GetPage(name: '/schoolsDetailsScreen', page: () =>   SchoolsDetailsScreen()),
    GetPage(name: '/settingScreenUser', page: () =>  const SettingScreenUser()),
    GetPage(name: '/addressScreen', page: () =>  const AddressScreen()),
    GetPage(name: '/changePasswordUser', page: () =>  const ChangePasswordUser()),
    GetPage(name: '/myProfileScreen', page: () =>  const MyProfileScreen()),
    GetPage(name: '/favoritesScreen', page: () =>  const FavoritesScreen()),
    GetPage(name: '/registrationScreen', page: () =>   RegistrationScreen()),

    GetPage(name: '/drawerForUser', page: () =>  const DrawerForUser()),
    GetPage(name: '/notificationScreenUser', page: () =>  const NotificationScreenUser()),
    GetPage(name: '/customDrawer', page: () =>  const CustomDrawer()),
    GetPage(name: '/syllabusScreen', page: () =>  const SyllabusScreen()),
    GetPage(name: '/classTimeTableScreen', page: () =>  const ClassTimeTableScreen()),
    GetPage(name: '/examTimeTableScreen', page: () =>  const ExamTimeTableScreen()),
    GetPage(name: '/examResultScreen', page: () =>  const ExamResultScreen()),
    GetPage(name: '/celebrationScreenStu', page: () =>  const CelebrationScreenStu()),

    //teacher
    GetPage(name: '/drawerForTeacher', page: () =>  const DrawerForTeacher()),
    GetPage(name: '/myProfileTeacher', page: () =>  const MyProfileTeacher()),
    GetPage(name: '/sendNotificationScreen', page: () =>  const SendNotificationScreen()),
    GetPage(name: '/studentListScreen', page: () =>  const StudentListScreen()),
    GetPage(name: '/studentDetailsScreen', page: () =>  const StudentDetailsScreen()),
    GetPage(name: '/createEventScreen', page: () =>  const CreateEventScreen()),
    GetPage(name: '/teacherEventsScreen', page: () =>  const TeacherEventsScreen()),
    GetPage(name: '/teacherEventsScreen', page: () =>  const TeacherEventsScreen()),
    GetPage(name: '/examResultScreenTeacher', page: () =>  const ExamResultScreenTeacher()),
    GetPage(name: '/teacherExamTimeTableScreen', page: () =>  const TeacherExamTimeTableScreen()),
    GetPage(name: '/teacherClassTimeScreen', page: () =>  const TeacherClassTimeScreen()),
    GetPage(name: '/teacherAttendanceScreen', page: () =>  const TeacherAttendanceScreen()),
    GetPage(name: '/createTimeTableScreen', page: () =>  const CreateTimeTableScreen()),
    GetPage(name: '/createExamTimeTable', page: () =>  const CreateExamTimeTable()),
  ];
}