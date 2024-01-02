import 'dart:developer';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/contact_us_model.dart';
import '../models/get_profile_model.dart';
import '../models/login_model.dart';
import '../models/privacy_policy_model.dart';
import '../models/terms_condition_model.dart';
import '../resourses/api_constant.dart';


Future<TermsConditionModel> termsConditionRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.termsConditionUrl),
      headers: await getAuthHeader(),);
    if (response.statusCode == 200) {
      log("terms Repository...${response.body}");
      return TermsConditionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<PrivacyPolicyModel> privacyPolicyRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.privacyPolicyUrl),
        headers: headers);
    if (response.statusCode == 200) {
      log("terms Repository...${response.body}");
      return PrivacyPolicyModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}

Future<ContactUsModel> contactUsRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  try {
    final response = await http.get(
        Uri.parse(ApiUrls.contactUsUrl),
        headers: headers);
    if (response.statusCode == 200) {
      log("terms Repository...${response.body}");
      return ContactUsModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
  } catch (e) {
    throw Exception(e.toString());
  }
}
