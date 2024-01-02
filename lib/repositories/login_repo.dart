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



Future<LoginModel> loginRepo({email,context,type,password,deviceType,deviceToken}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};

  map['email'] = email;
  map['type'] =  type;
  map['password'] = password;
  map['device_type'] = deviceType;
  map['device_token'] = deviceToken;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.login),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  // try {
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return LoginModel.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return LoginModel(msg: jsonDecode(response.body)["msg"], );
}}