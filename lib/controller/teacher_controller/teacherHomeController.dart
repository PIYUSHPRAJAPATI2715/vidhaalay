
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/studentModel/assignment_detail_model.dart';
import '../../models/TeacherModel/latest_event_model.dart';
import '../../resourses/api_constant.dart';

class TeacherHomeController extends GetxController{
  RxBool isLoading = true.obs;
  Rx<LatestEventModel> getLatestEventModel = LatestEventModel().obs;
  RxBool isAssignmentLoading = true.obs;
  Rx<AssignmentDetails> getLatestAssignmentModel = AssignmentDetails().obs;

  Future<LatestEventModel> getLatestEventRepo() async {
    // try{
    http.Response response = await http.get(Uri.parse(ApiUrls.latestEvents), headers: await getAuthHeader());
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);

      return LatestEventModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(response.body);
    }
    // }catch(e){
    //   print(e.toString());
    // }
  }

  Future getLatestEventData() async {
    isLoading.value = true;
    await getLatestEventRepo().then((value) {
      getLatestEventModel.value = value;
      isLoading.value = false;
    });
  }

  getLatestAssignmentRepo() async {
    try{
      isAssignmentLoading.value = true;

      http.Response response = await http.get(Uri.parse(ApiUrls.latestAssignment), headers: await getAuthHeader());
      // final response = await http.get(
      //   Uri.parse(ApiUrls.assignmentListUrl+"/29"),
      //   headers: await getAuthHeader(),);
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        getLatestAssignmentModel.value = AssignmentDetails.fromJson(jsonDecode(response.body));
        isAssignmentLoading.value = false;
      } else {
        throw Exception(response.body);
      }
    }catch(e){
      print(e.toString());
    }
  }
}