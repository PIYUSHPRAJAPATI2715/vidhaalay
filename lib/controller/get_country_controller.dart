import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:vidhaalay_app/models/get_state_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

import '../models/get_city_model.dart';
import '../models/get_countryList_model.dart';
import '../repositories/get_countryList_repo.dart';
import 'package:http/http.dart' as http;

class GetCountryListController extends GetxController {
  RxBool isDataLoading = false.obs;
  RxBool isGetStateLoading = false.obs;
  RxBool isGetCityLoading = false.obs;

  String? selectCountyValue;
  String? selectStateValue;
  String? selectCityValue;
  //RxString keyword = "".obs;
  Rx<CountryListModel> getCountryModel = CountryListModel().obs;
  Rx<StateListModel> getStateListModel = StateListModel().obs;
  Rx<GetCityModel> getCityListModel = GetCityModel().obs;


  getCountryListFunction() async {
    isDataLoading.value = false;
    // try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.getCountryUrl),
      headers: await getAuthHeader(),
    );

    print("API Status");
    print(response.statusCode.toString());
    print(response.body.toString());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      isDataLoading.value = true;
      getCountryModel.value = CountryListModel.fromJson(jsonDecode(response.body));
    } else {
      isDataLoading.value = true;
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      CountryListModel(
        msg: jsonDecode(response.body)["message"],
      );
    }
  }

  getStateListFunction() async {
    isGetStateLoading.value = false;
    // try {
    http.Response response = await http.get(
      Uri.parse(ApiUrls.getStateUrl+"/105"),
      headers: await getAuthHeader(),
    );

    print("API Status");
    print(response.statusCode.toString());
    print(response.body.toString());

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      isGetStateLoading.value = true;
      getStateListModel.value = StateListModel.fromJson(jsonDecode(response.body));
    } else {
      isGetStateLoading.value = true;
      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      StateListModel(
        msg: jsonDecode(response.body)["message"],
      );
    }
  }

  getCityListFunction(String id) async {
    isGetCityLoading.value = false;
    print("API Status");

    // try {
    http.Response response =
    // await http.get(Uri.parse(ApiUrls.getCityUrl + id), headers: headers);
    await http.get(Uri.parse(ApiUrls.getCityUrl + id), headers: await getAuthHeader());

    print("API Status");
    print(response.statusCode.toString());
    print(response.body.toString());

    if (response.statusCode == 200) {
      // print(jsonDecode(response.body));
      isGetCityLoading.value = true;
      getCityListModel.value =  GetCityModel.fromJson(jsonDecode(response.body));
    } else {
      isGetCityLoading.value = true;

      if (kDebugMode) {
        print(jsonDecode(response.body));
      }
      GetCityModel(
        msg: jsonDecode(response.body)["message"],
      );
    }
  }

  // Future getCountryListFunction() async {
  //   isDataLoading.value = false;
  //   print("Enter");
  //   await getCountryListRepo().then((value) {
  //     isDataLoading.value = true;
  //     getCountryModel.value = value;
  //     print("getCountryModel : ${getCountryModel.value}");
  //   });
  // }

  // Future getCityListFunction() async {
  //   isGetCityLoading.value = false;
  //   await getCityListRepo().then((value) {
  //     isGetCityLoading.value = true;
  //     getCityListModel.value = value;
  //     print("getCityListModel : ${getCityListModel.value}");
  //   });
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // getCountryListFunction();
    // getStateListFunction();
    // getCityListFunction();
  }
}
