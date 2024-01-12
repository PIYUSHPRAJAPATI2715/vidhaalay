import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/get_notification_details_model.dart';
import 'dart:convert';

import '../models/get_notification_model.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';


Future<GetNotificationModel> notificationRepo(String dateFormat) async {
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //
  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  // };

  try {

    Map body = {
      "date": dateFormat
      // "date":"2023-08-26"
    };

    final response = await http.post(
        Uri.parse(ApiUrls.notificationUrl),
      body: jsonEncode(body),
      headers: await getAuthHeader(),);
    print("call back");
    if (response.statusCode == 200) {
      print("Notification Repository...${response.body}");
      log("Notification Repository...${response.body}");
      return GetNotificationModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<NotificationDetailsModel> notificationDetailsRepo({required String id}) async {
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //
  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  // };

  try {
    final response = await http.get(
      Uri.parse(ApiUrls.notificationUrl+"/$id"),
      headers: await getAuthHeader(),);

    if (response.statusCode == 200) {
      print("Notification Repository...${response.body}");
      return NotificationDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
