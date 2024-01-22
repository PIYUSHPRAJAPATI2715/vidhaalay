import 'dart:io';
import 'dart:ui';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../widgets/appTheme.dart';


class ApiUrls {
  static const String apiBaseUrl = 'http://13.127.76.67:3000/api/';
  static const String register = "${apiBaseUrl}user/register";
  static const String socialUrl = "${apiBaseUrl}user/signInWithGoogle";
  static const String socialUrlFacebook = "${apiBaseUrl}user/signInWithFacebook";
  static const String login = "${apiBaseUrl}user/login";
  static const String resetViaEmail = "${apiBaseUrl}user/resetViaEmail";
  static const String resetViaSms = "${apiBaseUrl}user/resetViaSMS";
  static const String getCountryUrl = "${apiBaseUrl}common/countryStateList";
  static const String getStateUrl = "${apiBaseUrl}common/state";
  static const String getCityUrl = "${apiBaseUrl}common/city/";
  static const String notificationUrl = "${apiBaseUrl}notification";
  static const String getFaqUrl = "${apiBaseUrl}common/faqs";
  static const String getProfileUrl = "${apiBaseUrl}user/my-profile";
  static const String updateLocationUrl = "${apiBaseUrl}user/update-location";
  static const String updateProfileUrl = "${apiBaseUrl}user/update-profile";
  static const String uploadProfileImageUrl = "${apiBaseUrl}user/uploadProfile/user";
  static const String changePassUrl = "${apiBaseUrl}user/changePassword";
  static const String termsConditionUrl = "${apiBaseUrl}common/pages/term-conditions";
  static const String privacyPolicyUrl = "${apiBaseUrl}common/pages/privacy-policy";
  static const String contactUsUrl = "${apiBaseUrl}common/pages/contact-us";
  static const String verifyOtpEmailSend = "${apiBaseUrl}user/resetViaEmail";
  static const String verifyMobileOtp = "${apiBaseUrl}user/verifyOtp";
  static const String verifyEmailOtp = "${apiBaseUrl}user/verifyOtpEmail";
  static const String resetViaSMS = "${apiBaseUrl}user/resetViaSMS";
  static const String otpByMobile = "${apiBaseUrl}user/otpByMobile";
  static const String addMissionUrl = "${apiBaseUrl}addmissions";
  static const String addFavUrl = "${apiBaseUrl}favourite/addFav";
  static const String resetPassword = "${apiBaseUrl}user/reset-password";
  static const String resetByMobile = "${apiBaseUrl}user/resetByMobile";
  static const String forgotOtpVerSms = "${apiBaseUrl}user/verifyOtpForgot";
  static const String forgotOtpVerEmail = "${apiBaseUrl}user/verifyOtpEmailForgot";


  // User
  static const String schoolListUrl = "${apiBaseUrl}school/list";
  static const String topschoolListUrl = "${apiBaseUrl}school/top";
  static const String getSchoolDetails = "${apiBaseUrl}school";
  static const String getFavouriteListUrl = "${apiBaseUrl}favourite";
  static const String addFavourite = "${apiBaseUrl}favourite/addFav";
  static const String topLectures = "${apiBaseUrl}lectures/top-lectures";
  static const String allLectures = "${apiBaseUrl}lectures/all-lectures";
  static const String getLecturesDetails = "${apiBaseUrl}lectures/lecture-by-id";

  //Teacher
  static const String latestEvents = "${apiBaseUrl}events/latest-event";
  static const String eventsDetails = "${apiBaseUrl}events";
  static const String eventsListUrl = "${apiBaseUrl}events/getByDate";
  static const String createEvents = "${apiBaseUrl}events/create";
  static const String updateEvents = "${apiBaseUrl}events/update";
  static const String deleteEvents = "${apiBaseUrl}events/delete";

  static const String getTimetable = "${apiBaseUrl}timetable";
  static const String addTimetable = "${apiBaseUrl}timetable/create";

  static const String examType = "${apiBaseUrl}examType";
  static const String getExamTimetable = "${apiBaseUrl}exam";
  static const String addExamTimetable = "${apiBaseUrl}exam/create";

  static const String getExamResult = "${apiBaseUrl}result/findByExamType";
  static const String addExamResult = "${apiBaseUrl}result";

  static const String getAttendance = "${apiBaseUrl}attendance";
  static const String addAttendance = "${apiBaseUrl}attendance/add";

  static const String classList = "${apiBaseUrl}class";
  static const String studentList = "${apiBaseUrl}student";
  static const String studentDetails = "${apiBaseUrl}student/view";
  static const String teacherList = "${apiBaseUrl}teacher";
  static const String subjectList = "${apiBaseUrl}subject";
  static const String sendNotificationUrl = "${apiBaseUrl}notification/send-notification";

  static const String createAssignment = "${apiBaseUrl}assignment/create";
  static const String updateAssignment = "${apiBaseUrl}assignment/update";
  static const String deleteAssignment = "${apiBaseUrl}assignment";
  static const String latestAssignment = "${apiBaseUrl}assignment/home/findLatest";

  //Student
  static const String assignmentListUrl = "${apiBaseUrl}assignment";
  static const String getStudentAttendance = "${apiBaseUrl}attendance/student";

}


Future getAuthHeader() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // pref.getString("cookie")!.toString().replaceAll('\"', '');
  print("Enter");
  print(pref.getString("cookie"));

  var gg ={
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    // HttpHeaders.authorizationHeader:"FLWSECK_TEST-SANDBOXDEMOKEY-X"
    if(pref.getString("cookie") != null)
      HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',
  };
  print('token isss${gg}');
  return gg;
}
// HttpHeaders.contentTypeHeader: 'application/json',
// HttpHeaders.acceptHeader: 'application/json',
//     HttpHeaders.authorizationHeader: 'Bearer ${pref.getString("cookie")!.toString().replaceAll('\"', '')}',

showToast(String message) {
  Fluttertoast.cancel();
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: AppThemes.primaryColor,
      textColor: Color(0xffffffff),
      fontSize: 14);
}