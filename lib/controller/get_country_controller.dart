import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/get_city_model.dart';
import '../models/get_countryList_model.dart';
import '../repositories/get_countryList_repo.dart';

class GetCountryListController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool isGetCityLoading = false.obs;

  String? selectedAllergensValue;
  String? selectCityValue;
  //RxString keyword = "".obs;
  Rx<getCountryListModel> getCountryModel = getCountryListModel().obs;
  Rx<GetCityModel> getCityListModel = GetCityModel().obs;


  Future getCountryListFunction() async {
    isDataLoading.value = false;
    await getCountryListRepo().then((value) {
      isDataLoading.value = true;
      getCountryModel.value = value;
    });
  }
  Future getCityListFunction() async {
    isGetCityLoading.value = false;
    await getCityListRepo().then((value) {
      isGetCityLoading.value = true;
      getCityListModel.value = value;
    });
  }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCountryListFunction();
    getCityListFunction();
  }
}
