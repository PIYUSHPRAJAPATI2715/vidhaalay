import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
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

  http.Response response = await http.post(Uri.parse(ApiUrls.resetViaSms),
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