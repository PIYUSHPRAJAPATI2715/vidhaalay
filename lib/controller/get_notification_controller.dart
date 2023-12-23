import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vidhaalay_app/models/get_notification_details_model.dart';
import '../models/get_city_model.dart';
import '../models/get_countryList_model.dart';
import '../models/get_faq_model.dart';
import '../models/get_notification_model.dart';
import '../repositories/get_countryList_repo.dart';
import '../repositories/get_faq_repo.dart';
import '../repositories/get_notification_repo.dart';

class GetNotificationController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool isDetailsLoading = false.obs;
  // RxBool isDataLoadingFaq = false.obs;
  Rx<GetNotificationModel> getNotificationModel = GetNotificationModel().obs;
  Rx<NotificationDetailsModel> getNotificationDetailsModel = NotificationDetailsModel().obs;
  // Rx<GetFaqModel> getFaqModel = GetFaqModel().obs;


  Future getNotificationData() async {
    isDataLoading.value = false;
    await notificationRepo().then((value) {
      isDataLoading.value = true;
      getNotificationModel.value = value;
    });
  }

  Future getNotificationDetailsData(String id) async {
    // print("Enter");
    isDetailsLoading.value = false;
    await notificationDetailsRepo(id: id).then((value) {
      isDetailsLoading.value = true;
      getNotificationDetailsModel.value = value;
    });
  }

  // Future getFaqData() async {
  //   isDataLoadingFaq.value = false;
  //   await getFaqRepo().then((value) {
  //     isDataLoadingFaq.value = true;
  //     getFaqModel.value = value;
  //   });
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getNotificationData();
  }
}
