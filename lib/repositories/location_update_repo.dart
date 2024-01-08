import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/update_location_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<UpdateLocationModel> updateLocationRepo({lat,context,long,address}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  var map = <String, dynamic>{};

  map['latitude'] = lat;
  map['longitude'] =  long;
  map['address'] = address;

  //
  // SharedPreferences pref = await SharedPreferences.getInstance();
  // LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  //
  // final headers = {
  //   HttpHeaders.contentTypeHeader: 'application/json',
  //   HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  // };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.updateLocationUrl),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("Update Location${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return UpdateLocationModel.fromJson(jsonDecode(response.body));

  }
  else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return UpdateLocationModel(msg: jsonDecode(response.body)["msg"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}