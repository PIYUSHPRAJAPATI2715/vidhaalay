import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vidhaalay_app/controller/deshborad_controller.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/helper.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/bottom_navbar_screen.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';

import '../../controller/user_Controller/get_profile_controller.dart';
import '../../repositories/location_update_repo.dart';
// import 'package:location/location.dart';

class AddressScreen extends StatefulWidget {
  final bool isAddressUpdateRequire;
  final String address;

  const AddressScreen(
      {super.key, this.isAddressUpdateRequire = false, this.address = ''});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final formKey = GlobalKey<FormState>();
  String googleApikey = "AIzaSyDDl-_JOy_bj4MyQhYbKbGkZ0sfpbTZDNU";

  String? _address = "";
  dynamic lat;
  dynamic lang;

  final getAddressCon = Get.put(GetProfileController());
  final getSchoolListController = Get.put(GetSchoolListController());

  final address = TextEditingController();
  bool isAddressUpdateRequire = false;
  final _focusNode = FocusScopeNode();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressCon.getProfileData();
    });
    isAddressUpdateRequire = widget.isAddressUpdateRequire;
    _address = widget.address;
    address.text = widget.address;
    print("isAddressUpdateRequire : $isAddressUpdateRequire");
  }

  // Future<void> _getLocation() async {
  //   Location location = Location();
  //   bool _serviceEnabled;
  //   PermissionStatus _permissionGranted;
  //   LocationData _locationData;
  //
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }
  //
  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //
  //   _locationData = await location.getLocation();
  //   print('Latitude: ${_locationData.latitude}');
  //   print('Longitude: ${_locationData.longitude}');
  // }

  getCurrentLocation() async {
    try {
      // bool _serviceEnabled = await Geolocator.serviceEnabled();

      LocationPermission permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        print("LiveLocation Addd");
        return null;
      } else {
        bool isLocationServiceEnabled =
        await Geolocator.isLocationServiceEnabled();

        if (isLocationServiceEnabled) {
          OverlayEntry loader = Helpers.overlayLoader(context);
          Overlay.of(context)!.insert(loader);

          await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high,
              forceAndroidLocationManager: true)
              .then((Position position) {
            Helpers.hideLoader(loader);

            getAddressFromLatLng(position.latitude, position.longitude);
            print(position);
          });
        } else {
          showToast(message:
              "Please on your device location and retry for update your location");
        }
      }
      // return position;
    } catch (e) {
      print('Error getting location: $e');
      // return null;
    }
  }

  Future<String?> getAddressFromLatLng(
      double latitude, double longitude) async {
    print("Enter 2");
    try {
      List<Placemark> placemarks =
      await placemarkFromCoordinates(latitude, longitude);
      // Placemark place = placemarks[0];
      // String address =  "${placemarks.first.street}, ${placemarks.first.name}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}";
      String address =
          "${placemarks.first.name}, ${placemarks.first.subLocality}, ${placemarks.first.locality}, ${placemarks.first.administrativeArea}";

      print("LiveLocation Adddress : ${address}");

      updateLocationRepo(
          context: context,
          address: address,
          lat: latitude,
          long: longitude)
          .then((value) {
        if (value.status == true) {
          log(value.status.toString());
          getAddressCon.getProfileData();
          getSchoolListController.getSchoolListFunction();
          // getSchoolListController.getTopLectureListRepo();

          getSchoolListController.getTopLectureListRepo('S');
          getSchoolListController.getTopLectureListRepo('C');
          getSchoolListController.getTopLectureListRepo('I');

          // Get.back();
          // Get.offAllNamed(MyRouters.drawerForUser);
          Get.offAll(() => BottomBarScreen(
            userType: 0,
          ));
          showToast(message:value.msg.toString().toString());
        } else {
          showToast(message:value.msg.toString().toString());
        }
      });

      int pincode = int.parse(placemarks.first.postalCode.toString());
      return address;
    } catch (e) {
      debugPrint("Error: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return WillPopScope(
      onWillPop: () async {
        if (isAddressUpdateRequire) {
          showToast(message:"Please update location");
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: true,
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                if (isAddressUpdateRequire) {
                  showToast(message:"Please update location",isError: true);
                } else {
                  Get.back();
                }
              },
              icon: const Icon(
                Icons.arrow_back_outlined,
                color: Colors.black,
              )),
          title: Text(
            isAddressUpdateRequire ? 'Add Address' : 'Update Address',
            style: GoogleFonts.poppins(
                color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 13),
                child: CommonTextfield(
                  // controller: passwordController,
                  hintText: "Pick your current location",
                  prefix: Icon(Icons.my_location, size: 23, color: Colors.grey),
                  obSecure: false,
                  readOnly: true,
                  onTap: () {
                    getCurrentLocation();
                  },
                ),
              ),

              // Container(
              //   width: size.width,
              //   height: size.height * 0.055,
              //   margin: EdgeInsets.symmetric(horizontal: 15),
              //   padding: EdgeInsets.symmetric(horizontal: 15),
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(50),
              //     border: Border.all(
              //       color: Colors.grey
              //     )
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.start,
              //     children: [
              //       Icon(Icons.my_location,size: 25,),
              //       Text('Pick your current location'),
              //     ],
              //   ),
              // ),

              // ListTile(
              //
              //   title: Text('Pick your current location'),
              // ),
              SizedBox(
                height: 15,
              ),

              // Padding(
              //
              //   padding: const EdgeInsets.only(bottom: 10),
              //  child: FocusScope(
              //    node: _focusNode,
              //    child: GooglePlaceAutoCompleteTextField(
              //        textEditingController: address,
              //        googleAPIKey: googleApikey,
              //        inputDecoration: InputDecoration(
              //          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
              //          labelText: 'Location',
              //          labelStyle: TextStyle(
              //              color: AppThemes.textGray,
              //              fontSize: 14
              //          ),
              //          suffixIcon: Icon(
              //            Icons.location_on,
              //            color: AppThemes.primaryColor,
              //            size: 22,
              //          ),
              //          enabledBorder: OutlineInputBorder(
              //              borderRadius: BorderRadius.circular(50),
              //              borderSide: BorderSide(
              //                  color: Colors.grey!.withOpacity(0.5),
              //                  width: 1
              //              )
              //          ),
              //
              //          focusedBorder: OutlineInputBorder(
              //              borderRadius: BorderRadius.circular(50),
              //              borderSide: BorderSide(
              //                  color: Colors.grey!.withOpacity(0.5),
              //                  width: 1
              //              )
              //          ),
              //        ),
              //        seperatedBuilder: Divider(
              //          color: Colors.grey,
              //          height: 1,
              //        ),
              //        // Container(),
              //        boxDecoration: BoxDecoration(
              //          border: Border.all(
              //              color: Colors.transparent
              //          ),
              //        ),
              //
              //        itemBuilder: (context, index, prediction) => Container(
              //          // height: 50,
              //          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              //          decoration: BoxDecoration(
              //            color: Colors.white,
              //          ),
              //          child: Text(
              //            prediction.description.toString(),
              //            style: TextStyle(
              //                color: AppThemes.textGray,
              //                fontSize: 14
              //            ),
              //          ),
              //        ),
              //        isCrossBtnShown: true,
              //        textStyle: TextStyle(
              //            color: AppThemes.textGray,
              //            fontSize: 14
              //        ),
              //        debounceTime: 600,
              //        isLatLngRequired: true,
              //        itemClick: (prediction) {
              //          _focusNode.unfocus();
              //          address.text = prediction.description!;
              //          lat = prediction.lat!;
              //          lang = prediction.lng!;
              //        }
              //    ),
              //  ),
              // ),

              GooglePlaceAutoCompleteTextField(
                  textEditingController: address,
                  googleAPIKey: googleApikey,
                  boxDecoration: BoxDecoration(
                      border: Border.all(color: Colors.transparent)),
                  textStyle: TextStyle(color: AppThemes.textGray, fontSize: 14),
                  inputDecoration: InputDecoration(
                    contentPadding:
                    EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    labelText: 'Location',
                    labelStyle:
                    TextStyle(color: AppThemes.textGray, fontSize: 14),
                    suffixIcon: Icon(
                      Icons.location_on,
                      color: AppThemes.primaryColor,
                      size: 22,
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Colors.grey!.withOpacity(0.5), width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide(
                            color: Colors.grey!.withOpacity(0.5), width: 1)),
                  ),
                  // debounceTime: 600,
                  isLatLngRequired: true,
                  itemClick: (prediction) {
                    address.text = prediction.description!;
                    _address = prediction.description!;
                    if(prediction.lat != null && prediction.lng != null) {
                      lat =  prediction.lat!;
                      lang = prediction.lng!;
                    }

                    // Get.back();
                    updateLocationRepo(
                        context: context,
                        address: address.text,
                        lat: lat,
                        long: lang)
                        .then((value) {
                      if (value.status == true) {
                        log(value.status.toString());
                        getAddressCon.getProfileData();
                        getSchoolListController.getSchoolListFunction();
                        // getSchoolListController.getTopLectureListRepo();
                        getSchoolListController.getTopLectureListRepo('S');
                        getSchoolListController.getTopLectureListRepo('C');
                        getSchoolListController.getTopLectureListRepo('I');

                        // Get.back();
                        // Get.offAllNamed(MyRouters.drawerForUser);
                        Get.offAll(() => BottomBarScreen(
                          userType: 0,
                        ));

                        showToast(message:value.msg.toString().toString());
                      } else {
                        showToast(message:value.msg.toString().toString());
                      }
                    });
                  }),

              // Container(
              //     decoration: BoxDecoration(
              //         border: Border.all(),
              //         borderRadius: BorderRadius.circular(10.0),
              //         color: Colors.grey.shade50),
              //     // width: MediaQuery.of(context).size.width - 40,
              //     child: ListTile(
              //       leading: const Icon(Icons.location_on),
              //       title: Text(
              //         _address ?? "Location".toString(),
              //         style: const TextStyle(fontSize: 14),
              //       ),
              //       trailing: const Icon(Icons.search),
              //       dense: true,
              //     )),

              SizedBox(
                height: 30,
              ),

              Container(
                width: size.width,
                padding: EdgeInsets.symmetric(horizontal: 10),
                // width: double.maxFinite,
                child: CommonButton(
                  title: isAddressUpdateRequire
                      ? 'Add Location'
                      : 'Update Location',
                  onPressed: () {
                    /* Get.offAllNamed(MyRouters.drawerForTeacher);*/
                    // _focusNode.unfocus();

                    if (address.text!.isNotEmpty) {
                      updateLocationRepo(
                          context: context,
                          address: _address,
                          lat: lat,
                          long: lang)
                          .then((value) {
                        if (value.status == true) {
                          log(value.status.toString());
                          getAddressCon.getProfileData();
                          getSchoolListController.getSchoolListFunction();
                          // getSchoolListController.getTopLectureListRepo();
                          getSchoolListController.getTopLectureListRepo('S');
                          getSchoolListController.getTopLectureListRepo('C');
                          getSchoolListController.getTopLectureListRepo('I');

                          // Get.back();
                          // Get.offAllNamed(MyRouters.drawerForUser);
                          Get.offAll(() => BottomBarScreen(
                            userType: 0,
                          ));

                          showToast(message:value.msg.toString().toString());
                        } else {
                          showToast(message:value.msg.toString().toString());
                        }
                      });
                    } else {
                      showToast(message:'Select Address');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// body: SingleChildScrollView(
// padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 18),
// child: Column(
// children: [
// InkWell(
// onTap: () async {
// var place = await PlacesAutocomplete.show(
// hint: "Location",
// context: context,
// apiKey: googleApikey,
// mode: Mode.overlay,
// types: [],
// strictbounds: false,
// onError: (err) {
// log("error.....   ${err.errorMessage}");
// });
// if (place != null) {
// setState(() {
// _address = (place.description ?? "Location").toString();
// });
// final plist = GoogleMapsPlaces(
// apiKey: googleApikey,
// apiHeaders: await const GoogleApiHeaders().getHeaders(),
// );
// print(plist);
// String placeid = place.placeId ?? "0";
// final detail = await plist.getDetailsByPlaceId(placeid);
// final geometry = detail.result.geometry!;
// lat = geometry.location.lat;
// lang = geometry.location.lng;
// setState(() {
// _address = (place.description ?? "Location").toString();
// print("Address iss...$_address");
// print("Address iss...$lat");
// });
// }
// },
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Container(
// decoration: BoxDecoration(
// border: Border.all(),
// borderRadius: BorderRadius.circular(10.0),
// color: Colors.grey.shade50),
// // width: MediaQuery.of(context).size.width - 40,
// child: ListTile(
// leading: const Icon(Icons.location_on),
// title: Text(
// _address ?? "Location".toString(),
// style: const TextStyle(fontSize: 14),
// ),
// trailing: const Icon(Icons.search),
// dense: true,
// )),
// SizedBox(
// height: 60,
// ),
// SizedBox(
// width: double.maxFinite,
// child: CommonButton(
// title: isAddressUpdateRequire
// ? 'Add Location'
//     : 'Update Location',
// onPressed: () {
// if (_address!.isNotEmpty) {
// updateLocationRepo(
// context: context,
// address: _address,
// lat: lat,
// long: lang)
//     .then((value) {
// if (value.status == true) {
// log(value.status.toString());
// getAddressCon.getProfileData();
// getSchoolListController.getSchoolListFunction();
// getSchoolListController.getTopLectureListRepo();
// // Get.back();
//
// Get.offAllNamed(MyRouters.drawerForUser);
//
// showToast(message:value.msg.toString().toString());
// } else {
// showToast(message:value.msg.toString().toString());
// }
// });
// } else {
// showToast(message:'Select Address');
// }
// },
// ),
// ),
// ],
// )),
// ],
// ),
// ),
