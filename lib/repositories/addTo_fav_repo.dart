import 'dart:convert';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vidhaalay_app/models/model_common.dart';
import '../resourses/api_constant.dart';
import '../resourses/helper.dart';



Future<ModelCommon> addToWishlistRepo({favFor,context,favId,favourite}) async {
  OverlayEntry loader = Helpers.overlayLoader(context);
  Overlay.of(context)!.insert(loader);

  var map = <String, dynamic>{};

  map['fav_for'] = favFor;
  map['fav_for_id'] =  favId;
  map['favourite'] = favourite;

  http.Response response = await http.post(Uri.parse(ApiUrls.addFavUrl),
      headers: await getAuthHeader(),
      body: jsonEncode(map));
  log("add fav repo${response.body}");

  if (response.statusCode == 200) {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon.fromJson(jsonDecode(response.body));

  }
  else {
    Helpers.hideLoader(loader);
    print(jsonDecode(response.body));
    return ModelCommon(msg: jsonDecode(response.body)["msg"], );
  }
}