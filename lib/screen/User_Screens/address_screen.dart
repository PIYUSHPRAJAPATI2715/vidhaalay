import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../controller/location_controller.dart';



class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  late final Set<Factory<OneSequenceGestureRecognizer>> gestureRecognizers;
  final formKey = GlobalKey<FormState>();
  final locationController = Get.put(LocationController());

  bool showValidation = false;
  bool? _isValue1 = false;
  @override
  void initState() {
    super.initState();
    locationController.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Address',style: TextStyle(
          color: Colors.black
        ),),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                // Get.to(()=> ChooseAddress(addressDataList: [],));
                // Get.toNamed(ChooseAddress.chooseAddressScreen);
              },
              child: Obx(() {
                bool showMap = locationController.lat.value != '';
                return showMap
                    ? Container(
                  height: 450,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        double.parse(locationController.lat.value == ''
                            ? "0"
                            : locationController.lat.value),
                        double.parse(locationController.long.value == ''
                            ? "0"
                            : locationController.long.value),
                      ),
                      zoom: 15,
                    ),
                    gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                      Factory<OneSequenceGestureRecognizer>(
                            () => EagerGestureRecognizer(),
                      ),
                    },
                  ),
                )
                    : SizedBox();
              }),
            ),
          ],
        ),
      ),
    );
  }
}




