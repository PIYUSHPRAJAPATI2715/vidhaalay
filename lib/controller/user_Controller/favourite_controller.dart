import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/favourite_model_user.dart';
import 'package:vidhaalay_app/models/school_list_model.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';

class FavouriteController extends GetxController {
  RxBool isFavouriteListLoading = false.obs;
  Rx<FavourateListModel> favourateListModel = FavourateListModel().obs;
  RxString favForType = "Schools".obs;

  // Rx<SchoolListModel> getSchoolListModel = SchoolListModel().obs;
  Future getFavouriteListRepo() async {
    isFavouriteListLoading.value = false;
    print("api Call");

    final Map<String, dynamic> MapData = {
      "fav_for": favForType.value,
    };

    final String jsonBody = json.encode(MapData);

    http.Response response = await http.post(Uri.parse(ApiUrls.getFavouriteListUrl), headers: await getAuthHeader(),body: jsonBody);

    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);

      // Helpers.hideLoader(loader);
      favourateListModel.value = FavourateListModel.fromJson(jsonDecode(response.body));
      print(favourateListModel);
      isFavouriteListLoading.value = true;
    } else {
      isFavouriteListLoading.value = true;
      // Helpers.hideLoader(loader);
      // Helpers.createSnackBar(context, response.statusCode.toString());
      throw Exception(response.body);
    }
  }

  Future addFavouriteInListRepo(int favId, String favFor, bool isFavourite) async {
    print("api Call");
    // isFavouriteListLoading.value = false;

    final Map<String, dynamic> MapData = {
      "fav_for_id": favId,
      "fav_for": favFor,
      "favourite": isFavourite
    };

    final String jsonBody = json.encode(MapData);

    http.Response response = await http.post(Uri.parse(ApiUrls.addFavourite), headers: await getAuthHeader(),body: jsonBody);
    print(response.statusCode);

    if (response.statusCode == 200) {
      print(response.body);

      Map<String, dynamic> responseData = json.decode(response.body);

      showToast(responseData['msg'].toString());
      // isFavouriteListLoading.value = true;
    } else {

      // isFavouriteListLoading.value = true;
      throw Exception(response.body);
    }
  }


}