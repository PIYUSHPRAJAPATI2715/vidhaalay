import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<LoginModel> loginRepo({email,context,type,password}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  var map = <String, dynamic>{};

  map['email'] = email;
  map['type'] =  type;
  map['password'] = password;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.login),
      headers: headers,
      body: jsonEncode(map));
  log("Sign IN DATA${response.body}");
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return LoginModel.fromJson(jsonDecode(response.body));

  }
  else {
    Helpers.hideLoader(loader);
    if (kDebugMode) {
      print(jsonDecode(response.body));
    }
    return LoginModel(msg: jsonDecode(response.body)["message"], );
  }
  // }  catch (e) {
  //   Helpers.hideLoader(loader);
  //   return ModelCommonResponse(message: e.toString(), success: false);
}