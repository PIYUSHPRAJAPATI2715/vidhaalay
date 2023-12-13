import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/school_list_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<SchoolListModel> schoolListRepo() async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.acceptHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  // };
  http.Response response = await http.post(Uri.parse(ApiUrls.schoolListUrl), headers:   await getAuthHeader(),);

  log(response.body);
  if (response.statusCode == 200) {
    // Helpers.hideLoader(loader);
    return SchoolListModel.fromJson(jsonDecode(response.body));
  } else {
    // Helpers.hideLoader(loader);
    // Helpers.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
}