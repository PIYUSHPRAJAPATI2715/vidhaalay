import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import '../models/registor_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<RegisterModel> registerRepo({phone,required BuildContext context,name,email,password}) async {

  var map = <String, dynamic>{};

  map['phone'] = phone;
  map['name'] = name;
  map['email'] =  email;
  map['password'] = password;

  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };
  http.Response response = await http.post(Uri.parse(ApiUrls.register),
      body: jsonEncode(map), headers: headers);

  log(response.body);
  // try {
  // http.Response response = await http.post(Uri.parse(ApiUrls.loginUser),
  //     headers: await getAuthHeader(),body: jsonEncode(map) );
  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return RegisterModel.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    // NewHelper.createSnackBar(context, response.statusCode.toString());
    throw Exception(response.body);
  }
  // if (response.statusCode == 200) {
  //   Helpers.hideLoader(loader);
  //   print(jsonDecode(response.body));
  //   return RegisterModel.fromJson(jsonDecode(response.body));
  //
  // }
  // else {
  //   Helpers.hideLoader(loader);
  //   print(jsonDecode(response.body));
  //   return RegisterModel(msg: jsonDecode(response.body)["message"], );
  // }
  // // }  catch (e) {
  // //   Helpers.hideLoader(loader);
  // //   return ModelCommonResponse(message: e.toString(), success: false);
}