import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/TeacherModel/exam_type_list_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';


Future<ExamTypeList> getExamTypeListRepo() async {

  http.Response response = await http.get(Uri.parse(ApiUrls.examType), headers: await getAuthHeader());
  print(response.statusCode);

  if (response.statusCode == 200) {
    print(response.body);

    return ExamTypeList.fromJson(jsonDecode(response.body));
  } else {
    throw Exception(response.body);
  }
}