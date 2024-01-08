import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/TeacherModel/teacher_list_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';


Future<TeacherList> getTeacherListRepo() async {
  http.Response response = await http.get(Uri.parse(ApiUrls.teacherList), headers: await getAuthHeader());
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    return TeacherList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}