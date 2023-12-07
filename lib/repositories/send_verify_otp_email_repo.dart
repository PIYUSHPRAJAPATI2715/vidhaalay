import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/model_common.dart';
import '../models/login_model.dart';
import '../models/model_email_verify.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelCommon> verifyEmailOtpSend({email,context,type}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};

  map['email'] = email;
  map['type'] =  type;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.verifyOtpEmailSend),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommon.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }}

Future<ModelEmailVerify> verifyEmailOtp({email,context,type,otp}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};

  map['email'] = email;
  map['type'] =  type;
  map['otp'] =  otp;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.verifyEmailOtp),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelEmailVerify.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelEmailVerify(msg: jsonDecode(response.body)["msg"], );
  }}


Future<ModelCommon> verifySmsOtpSendRepo({mobile,context,type}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};

  map['mobile'] = mobile;
  map['type'] =  type;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.resetViaSMS),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommon.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }}

Future<ModelEmailVerify> verifySmsOtp({mobile,context,type,otp}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};

  map['mobile'] = mobile;
  map['type'] =  type;
  map['otp'] =  otp;


  print(map);
  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  // try {
  http.Response response = await http.post(Uri.parse(ApiUrls.verifyMobileOtp),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelEmailVerify.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelEmailVerify(msg: jsonDecode(response.body)["msg"], );
  }}