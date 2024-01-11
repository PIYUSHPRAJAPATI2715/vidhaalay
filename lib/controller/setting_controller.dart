
import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/contactus_model.dart';
import '../models/privacy_policy_model.dart';
import '../models/terms_model.dart';
import '../resourses/api_constant.dart';

class SettingController extends GetxController{

  RxString termsContent = ''.obs;
  RxString privacypolicyContent = ''.obs;
  RxString contactUsContent = ''.obs;



  Future termAndConditionAPICall() async {
    http.Response response = await http.get(Uri.parse(ApiUrls.termsConditionUrl), headers: await getAuthHeader(),);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = termsModelFromJson(response.body);
      termsContent.value = responseData.data.content.toString();
      print(termsContent.value.toString());
      print(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future privacypolicyAPICall() async {
    http.Response response = await http.get(Uri.parse(ApiUrls.privacyPolicyUrl), headers: await getAuthHeader(),);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = privacyPolicyModelFromJson(response.body);
      privacypolicyContent.value = responseData.data.content.toString();
      print(privacypolicyContent.value.toString());
      print(response.body);
    } else {
      throw Exception(response.body);
    }
  }

  Future contactUsAPICall() async {
    http.Response response = await http.get(Uri.parse(ApiUrls.contactUsUrl), headers: await getAuthHeader(),);
    print(response.statusCode);

    if (response.statusCode == 200) {
      final responseData = contactUsModelFromJson(response.body);
      contactUsContent.value = responseData.data.content.toString();
      print(privacypolicyContent.value.toString());
      print(response.body);
    } else {
      throw Exception(response.body);
    }
  }
}