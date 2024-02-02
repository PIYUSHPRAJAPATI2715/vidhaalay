import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';

bool validateImgeSize(File imageFile) {
  if (isImageSizeValid(imageFile, maxSizeInBytes: 2 * 1024 * 1024)) {
    // showToast(message: "Image size is valid");
    // UpdateUserProfileApiCall(imageFile);
    return true;
  } else {
    showToast(message: "The selected image size exceeds the maximum allowed size of 2 MB.",isError: true);
    return false;
  }
}

bool isImageSizeValid(File imageFile, {required int maxSizeInBytes}) {
  // Check if the file exists
  if (imageFile.existsSync()) {
    // Obtain the file size in bytes
    int fileSizeInBytes = imageFile.lengthSync();

    // Compare the file size with the specified maximum size
    if (fileSizeInBytes <= maxSizeInBytes) {
      return true; // Image size is valid
    }
  }

  return false; // Image size exceeds the limit
}

Future<bool> UpdateUserProfileApiCall(File imageFile,BuildContext context) async {

  bool isValidImageSize = validateImgeSize(imageFile);

  if(isValidImageSize) {
    OverlayEntry loader = Helpers.overlayLoader(context);
    Overlay.of(context)!.insert(loader);

    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = pref.getString("cookie")!.toString().replaceAll('\"', '').toString();

    Map<String, String> headers = {
      "Authorization": 'Bearer $token',
      "Content-type": "multipart/form-data"
    };

    String? userId = await pref.getString('id');
    String? userType = pref.getString("type");

    var request = http.MultipartRequest(
      'POST',
      Uri.parse(ApiUrls.uploadProfileImageUrl+ "/${userId}/$userType"),
    );
    request.headers.addAll(headers);

    var contentType = MediaType.parse(
        lookupMimeType(imageFile.path) ?? 'image/jpeg');

    var part = await http.MultipartFile.fromPath(
        'image', imageFile.path, contentType: contentType);
    request.files.add(part);

    print("request: " + request.toString());

    var res = await request.send();
    var responseBody = await res.stream.bytesToString();

    print("This is response:" + res.toString());

    if (res.statusCode == 200) {
      print('Response: $responseBody');
      showToast(message:"Profile image updated successfully.");
      Helpers.hideLoader(loader);
      return true;
    } else {
      if (res.statusCode == 500) {
        showToast(message:"Internal Server Error");
      } else {
        showToast(message:'Please Update Your Profile Picture!!!');
      }
      Helpers.hideLoader(loader);
      return false;
    }
  } else {
    return false;
  }

}
