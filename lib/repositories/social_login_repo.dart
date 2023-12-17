import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

import '../models/social_login_model.dart';

import '../resourses/helper.dart';

Future<SocialLoginModel> socialLogin(
    {required String provider,required String token,
      required BuildContext context}) async {

  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context).insert(loader);

  var map = <String, dynamic>{};
  map['provider'] = provider;
  map['token'] = token;
  var fcmToken = await FirebaseMessaging.instance.getToken();
  map['device_token'] = fcmToken;

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  http.Response response = await http.post(Uri.parse(ApiUrls.socialUrl),
      body: jsonEncode(map), headers: headers);
  log(map.toString());
  log(response.statusCode.toString());
  log(response.body);
  if (response.statusCode == 200 || response.statusCode == 400) {
    Helpers.hideLoader(loader);
    return SocialLoginModel.fromJson(json.decode(response.body));
  } else {
    Helpers.createSnackBar(context, response.body.toString());
    Helpers.hideLoader(loader);
    throw Exception(response.body);
  }
}

