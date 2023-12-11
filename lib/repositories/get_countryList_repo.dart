import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/get_city_model.dart';
import '../models/get_countryList_model.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';


Future<getCountryListModel> getCountryListRepo() async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };


  // try {
    http.Response response = await http.get(Uri.parse(ApiUrls.getCountryState),
        headers: headers);

    log(response.body.toString());
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return getCountryListModel.fromJson(jsonDecode(response.body));

  }
  else {
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    return getCountryListModel(msg: jsonDecode(response.body)["message"], );
  }
    }

Future<GetCityModel> getCityListRepo({id}) async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  // try {
    http.Response response = await http.get(Uri.parse(ApiUrls.getCityUrl+id),
        headers: headers);

    log(response.body.toString());
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return GetCityModel.fromJson(jsonDecode(response.body));

  }
  else {
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    return GetCityModel(msg: jsonDecode(response.body)["message"], );
  }
    }


