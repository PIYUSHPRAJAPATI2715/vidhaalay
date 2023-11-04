// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:image_picker/image_picker.dart';
//
//
// class NewHelper {
//   Future<File?> addImagePicker({ImageSource imageSource = ImageSource.gallery,
//     int imageQuality = 50}) async {
//     try {
//       final item = await ImagePicker()
//           .pickImage(source: imageSource, imageQuality: imageQuality);
//       if (item == null) {
//         return null;
//       } else {
//         return File(item.path);
//       }
//     } on PlatformException catch (e) {
//       throw Exception(e);
//     }
//   }
//   static hideLoader(OverlayEntry loader) {
//     Timer(const Duration(milliseconds: 250), () {
//       try {
//         loader.remove();
//         // ignore: empty_catches
//       } catch (e) {}
//     });
//   }
//
// }
// extension DateComparision on DateTime{
//
//   bool get isCurrentData{
//     final DateTime currentTime = DateTime.now();
//     final DateTime todayDate = DateTime(currentTime.year,currentTime.month,currentTime.day);
//     return todayDate.isAtSameMomentAs(DateTime(year,month,day));
//   }
//
//   DateTime get toSimpleDate{
//     // final DateTime currentTime = DateTime.now();
//     // final DateTime todayDate = DateTime(currentTime.year,currentTime.month,currentTime.day);
//     return DateTime(year,month,day);
//   }
//
// }
