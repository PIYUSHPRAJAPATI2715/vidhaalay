import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/get_profile_model.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';


Future<GetProfileModel> getProfileRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  // };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.getProfileUrl),
        headers: await getAuthHeader());
    if (response.statusCode == 200) {
      log("getProfile Repository...${response.body}");
      return GetProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
