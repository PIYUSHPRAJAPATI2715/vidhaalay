import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/lecture_model_user.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

class LecturesController extends GetxController {
  RxBool isLectureListLoading = true.obs;
  Rx<LectureListModel> lectureListModel = LectureListModel().obs;

  Future getTopLectureListRepo() async {
    isLectureListLoading.value = true;
    print("api Call");

    http.Response response = await http.get(Uri.parse(ApiUrls.topLectures), headers: await getAuthHeader());

    print(response.statusCode);

    if (response.statusCode == 200) {
      print("lecture list : ${response.body}");

      lectureListModel.value = LectureListModel.fromJson(jsonDecode(response.body));
      print(lectureListModel);

      isLectureListLoading.value = false;
    } else {
      isLectureListLoading.value = false;

      throw Exception(response.body);
    }
  }

}