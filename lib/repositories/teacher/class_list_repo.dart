import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidhaalay/models/TeacherModel/class_list_model.dart';
import 'package:vidhaalay/resourses/api_constant.dart';


Future<ClassList> getClassListRepo() async {

  // http.Response response = await http.get(Uri.parse(ApiUrls.studentList+"/4"), headers: await getAuthHeader());
  http.Response response = await http.get(Uri.parse(ApiUrls.classList), headers: await getAuthHeader());
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    return ClassList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}