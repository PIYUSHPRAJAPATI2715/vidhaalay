import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/forgot_sms_otp_model.dart';
import '../models/model_common.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';


Future<ModelCommon> forgotPassOtpEmail({email, context}) async {
  var map = <String, dynamic>{};
  map['email'] = email;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.resetViaEmail),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    log("::::::::::Resend Otp:::::::::::${response.body}");
    return ModelCommon.fromJson(json.decode(response.body));
  }
  else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }
}

Future<ModelCommon> forgotPassOtpSms({mobile, context}) async {
  var map = <String, dynamic>{};
  map['mobile'] = mobile;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.resetByMobile),
      body: jsonEncode(map), headers: headers);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    log("::::::::::Resend Otp:::::::::::${response.body}");
    return ModelCommon.fromJson(json.decode(response.body));
  }
  else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }
}


Future<ModelCommon> changePassword({password, confirmPassword, context}) async {
  var map = <String, dynamic>{};
  map['password'] = password;
  map['confirm_password'] = confirmPassword;

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.resetPassword),
      body: jsonEncode(map), headers: await getAuthHeader());

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    log("::::::::::Resend Otp:::::::::::${response.body}");
    return ModelCommon.fromJson(json.decode(response.body));
  }
  else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }
}

Future<VerifyOtpSmsForgotModel> forgotSmsOtpRepo({mobile,context,type,otp}) async {
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
  http.Response response = await http.post(Uri.parse(ApiUrls.forgotOtpVerSms),
      headers: headers,
      body: jsonEncode(map));
  log(response.body);
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return VerifyOtpSmsForgotModel.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return VerifyOtpSmsForgotModel(msg: jsonDecode(response.body)["msg"], );
  }}