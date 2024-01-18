import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_details_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/event_list_model.dart';
import 'package:vidhaalay_app/models/TeacherModel/my_class_model.dart';
import 'package:vidhaalay_app/repositories/get_notification_repo.dart';
import 'package:vidhaalay_app/repositories/my_class_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/resourses/helper.dart';

class EvenetDetailController extends GetxController {
  RxBool isDataLoading = true.obs;
  RxBool isDetailsLoading = true.obs;
  Rx<EventDetails> getEventDetailsModel = EventDetails().obs;
  Rx<GetEventModel> getEventModel = GetEventModel().obs;


  RxList<MyClass> classList = <MyClass>[].obs;
  RxInt selectedClassId = 0.obs;

  RxString selectedDate = "".obs;
  RxInt selectedIndex = 0.obs;
  RxInt selectedMonthIndex = 0.obs;

  void getMyClass() {
    getMyClassListRepo().then((values) async {
      if(values != null) {
        selectedClassId.value = values[0].id;
        classList.clear();
        classList.addAll(values);
        getEventData(classId: selectedClassId.value,dateFormat : selectedDate.value);
      }
    });
  }

  Future<void> getEventData({required String dateFormat,required int classId}) async {
    try {
      print("eNTER");

      isDataLoading.value = true;

      Map body = {
        "date": dateFormat,
        "class_id": classId
      };
      // Map body =  {
      //   "date": "2023-03-04"
      // };

    final response = await http.post(
        Uri.parse(ApiUrls.eventsListUrl),
        body: jsonEncode(body),
        headers: await getAuthHeader(),);
        print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        getEventModel.value = GetEventModel.fromJson(responseData);
        isDataLoading.value = false;

      } else {
        // isDataLoading.value = false;

        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> getEventDetailsData({required String id}) async {
    try {
      isDetailsLoading.value =  true;

      final response = await http.get(
        Uri.parse(ApiUrls.eventsDetails+"/$id"),
        headers: await getAuthHeader(),);

      print("Event Repository...${response.body}");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        getEventDetailsModel.value = EventDetails.fromJson(responseData);
        isDetailsLoading.value =  false;
      } else {
        isDetailsLoading.value =  false;
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deleteEventAPI(BuildContext context,int id) async {
    try {
      OverlayEntry loader = Helpers.overlayLoader(context);
      Overlay.of(context).insert(loader);

      final response = await http.delete(
        Uri.parse(ApiUrls.deleteEvents+"/${id.toString()}"),
        headers: await getAuthHeader(),);
      print("call back");

      if (response.statusCode == 200) {
        var responseData = jsonDecode(response.body);
        print("Event responseData  : ${responseData}");

        if(responseData['status']) {
          // Get.back();
          Helpers.hideLoader(loader);
          getEventData(classId: selectedClassId.value,dateFormat : selectedDate.value);
        } else {
          Helpers.hideLoader(loader);
        }
        showToast(responseData['msg'].toString());
      } else {
        throw Exception(response.body);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  // Future getNotificationDetailsData(String id) async {
  //   // print("Enter");
  //   isDetailsLoading.value = false;
  //   await notificationDetailsRepo(id: id).then((value) {
  //     isDetailsLoading.value = true;
  //     getNotificationDetailsModel.value = value;
  //   });
  // }


  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getNotificationData();
  }

}