import 'dart:convert';

import 'package:vidhaalay_app/models/TeacherModel/studentList_model.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/resourses/api_constant.dart';


Future<StudentList> getStudetnListRepo({required String classId}) async {

  // http.Response response = await http.get(Uri.parse(ApiUrls.studentList+"/4"), headers: await getAuthHeader());
  http.Response response = await http.get(Uri.parse(ApiUrls.studentList+"/$classId"), headers: await getAuthHeader());
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    return StudentList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}