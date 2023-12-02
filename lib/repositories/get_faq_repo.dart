import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/get_faq_model.dart';
import '../models/get_notification_model.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';


Future<GetFaqModel> getFaqRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.getFaqUrl),
        headers: headers);
    if (response.statusCode == 200) {
      log("Faq Repository...${response.body}");
      return GetFaqModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
