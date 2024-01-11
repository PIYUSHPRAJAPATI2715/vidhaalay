

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';

Future<List<MyClass>?> getMyClassListRepo() async {
  SharedPreferences pref = await SharedPreferences.getInstance();

  List<String>? classListJson = pref.getStringList('classArr');

  if(classListJson != null) {
    List<MyClass>? resultList =
    (classListJson ?? []).map<MyClass>((jsonString) {
      return MyClass.fromJson(json.decode(jsonString));
    }).toList();

    print('Retrieved List model from resultList: $resultList');

    return resultList;

  } else {
    return null;
  }
}