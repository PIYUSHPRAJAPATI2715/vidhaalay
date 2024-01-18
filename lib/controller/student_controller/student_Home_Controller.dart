import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../models/TeacherModel/latest_event_model.dart';
import '../../resourses/api_constant.dart';


class StudentHomeController extends GetxController{
  RxBool isLoading = true.obs;
  Rx<LatestEventModel> getLatestEventModel = LatestEventModel().obs;

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
}