import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/addmission_model_user.dart';
import '../models/login_model.dart';
import '../models/model_common.dart';
import '../models/update_profile_model.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<AddmissionModelUser> addMissionRepo({appliedFor,appliedForId,category,dob,motherTongue,name,fatherName,
  motherName,adharNo,bloodGroup,gender,religion,nationality,address,city,state,pincode,previous_school_name,
  location,classprev,yearOfStudy,percentage,
  father_name,occupation,organization,mobile_number,aadhar_number,email_father,annual_income_father,
  landline_number,mother_name,occupation_mother,organization_mother,mobile_mother,
  aadhar_mother,email_mother,annual_income_mother,landline_mother,class_sibling,name_sibling,
  class_school_sibling,
  context}) async {

  SharedPreferences pref = await SharedPreferences.getInstance();
  LoginModel model = LoginModel.fromJson(jsonDecode(pref.getString("cookie")!));
  var map = <String, dynamic>{};
  var map1 = <String, dynamic>{};
  var map2 = <String, dynamic>{};
  var map3 = <String, dynamic>{};
  var map4 = <String, dynamic>{};
  var map5 = <String, dynamic>{};
  var map6 = <String, dynamic>{};


  map['applied_for'] = appliedFor;
  map['applied_for_id'] = appliedForId;
  map['student_info'] =  map1;
  map1['dob'] =  dob;
  map1['category'] =  category;
  map1['mother_tongue'] =  motherTongue;
  map1['name'] =  name;
  map1['father_name'] =  fatherName;
  map1['mother_name'] =  motherName;
  map1['adhar_no'] =  adharNo;
  map1['blood_group'] =  bloodGroup;
  map1['gender'] =  gender;
  map['residential_info'] =  map2;
  map2['religion'] =  religion;
  map2['nationality'] =  nationality;
  map2['address'] =  address;
  map2['city'] =  city;
  map2['state'] =  state;
  map2['pincode'] =  pincode;
  map['prev_school_info'] =  map3;
  map3['previous_school_name'] =  previous_school_name;
  map3['location'] =  location;
  map3['class'] =  classprev;
  map3['year_of_study'] =  yearOfStudy;
  map3['percentage'] =  percentage;
  map['father_info'] =  map4;
  map4['father_name'] =  father_name;
  map4['occupation'] =  occupation;
  map4['organization'] =  organization;
  map4['mobile_number'] =  mobile_number;
  map4['aadhar_number'] =  aadhar_number;
  map4['email_father'] =  email_father;
  map4['annual_income_father'] =  annual_income_father;
  map4['landline_number'] =  landline_number;
  map['mother_info'] =  map5;
  map5['mother_name'] =  mother_name;
  map5['occupation_mother'] =  occupation_mother;
  map5['organization_mother'] =  organization_mother;
  map5['mobile_mother'] =  mobile_mother;
  map5['aadhar_mother'] =  aadhar_mother;
  map5['email_mother'] =  email_mother;
  map5['annual_income_mother'] =  annual_income_mother;
  map5['landline_mother'] =  landline_mother;
  map['sibling_info'] =  map6;
  map6['name_sibling'] =  name_sibling;
  map6['class_sibling'] =  class_sibling;
  map6['class_school_sibling'] =  class_school_sibling;


  log(map.toString());
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  final headers = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
    HttpHeaders.authorizationHeader: 'Bearer ${model.data!.token.toString()}',
  };
  http.Response response = await http.post(Uri.parse(ApiUrls.addMissionUrl),
      body: jsonEncode(map), headers: headers);

  log(response.body);

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    return AddmissionModelUser.fromJson(jsonDecode(response.body));
  } else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return AddmissionModelUser(msg: jsonDecode(response.body)["msg"], );
  }
}