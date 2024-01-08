import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/get_notification_model.dart';
import '../models/get_school_details_model.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';


Future<SchoolDetailsModel> getSchoolDetailsRepo(String id) async {
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //
  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOjE2MiwidHlwZSI6InVzZXIiLCJpYXQiOjE3MDI0NDUxOTksImV4cCI6MTcwMzA0OTk5OX0.LHyu_OPQMsmo65ATzmR3R02MLwsMYlpYXtY0gZUMWQk'}',
  // };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.getSchoolDetails + "/$id"),
      headers:await  getAuthHeader());
    if (response.statusCode == 200) {
      log("school details Repository...${response.body}");
      // log("school details Repository...${model}");
      return SchoolDetailsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
