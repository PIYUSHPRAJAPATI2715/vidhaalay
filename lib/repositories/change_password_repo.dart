import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/login_model.dart';
import '../models/model_common.dart';
import '../models/update_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelCommon> changePassRepo({oldPassword,context,password,type}) async {


  var map = <String, dynamic>{};

  map['old_password'] = oldPassword;
  map['password'] = password;
  map['type'] =  type;

  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);


  http.Response response = await http.post(Uri.parse(ApiUrls.changePassUrl),
      body: jsonEncode(map),    headers: await getAuthHeader(),);

  log(response.body);
  Map<String, dynamic> responseData = json.decode(response.body);
  showToast(message:responseData['msg'].toString());

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return ModelCommon.fromJson(jsonDecode(response.body));
    // return ModelCommon.fromJson(jsonDecode(" "));
  } else {
    Helpers.hideLoader(loader);

    // Helpers.createSnackBar(context, response.body['msg']);
    throw Exception(response.body);
  }
}