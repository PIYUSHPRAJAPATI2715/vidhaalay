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


Future<CountryListModel> getCountryListRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  // try {
  http.Response response = await http.get(
    Uri.parse(ApiUrls.getCountryUrl),
    headers: await getAuthHeader(),
  );

  print("API Status");
  print(response.statusCode.toString());
  print(response.body.toString());

  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return CountryListModel.fromJson(jsonDecode(response.body));
  } else {
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    return CountryListModel(
      msg: jsonDecode(response.body)["message"],
    );
  }
}

Future<GetCityModel> getCityListRepo({id}) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));

  // print(object)

  var headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };

  // try {
  http.Response response =
      await http.get(Uri.parse(ApiUrls.getCityUrl + id), headers: headers);

  log(response.body.toString());
  if (response.statusCode == 200) {
    print(jsonDecode(response.body));
    return GetCityModel.fromJson(jsonDecode(response.body));
  } else {
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    return GetCityModel(
      msg: jsonDecode(response.body)["message"],
    );
  }
}
