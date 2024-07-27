import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidhaalay/models/TeacherModel/subject_list_model.dart';
import 'package:vidhaalay/resourses/api_constant.dart';


Future<SubjectList> getSubjectListRepo({required String classId}) async {

  http.Response response = await http.get(Uri.parse(ApiUrls.subjectList+"/$classId"), headers: await getAuthHeader());
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    return SubjectList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}