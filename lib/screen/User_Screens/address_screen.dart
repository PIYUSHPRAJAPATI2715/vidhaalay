import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:flutter_google_places_hoc081098/google_maps_webservice_places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';

import '../../controller/get_profile_controller.dart';
import '../../repositories/location_update_repo.dart';



class AddressScreen extends StatefulWidget {

  final bool isAddressUpdateRequire;
  final String address;

  const AddressScreen({super.key,this.isAddressUpdateRequire = false, this.address = ''});

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

  final getAddressCon  = Get.put(GetProfileController());

  bool isAddressUpdateRequire = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressCon.getProfileData();
    });
    isAddressUpdateRequire = widget.isAddressUpdateRequire;
    _address = widget.address;
    print("isAddressUpdateRequire : $isAddressUpdateRequire");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if(isAddressUpdateRequire) {
          showToast("Please update location");
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
                  if(isAddressUpdateRequire) {
                    showToast("Please update location");
                  } else {
                    Get.back();
                  }
            },
                icon: const Icon(Icons.arrow_back_outlined,color: Colors.black,)
            ),
          title:  Text(isAddressUpdateRequire ? 'Add Address' : 'Update Address',style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontSize: 18
          ),),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 18),
          child: Column(
            children: [
            InkWell(
                  onTap: () async {
                    var place = await PlacesAutocomplete.show(
                        hint: "Location",
                        context: context,
                        apiKey: googleApikey,
                        mode: Mode.overlay,
                        types: [],
                        strictbounds: false,
                        onError: (err) {
                          log("error.....   ${err.errorMessage}");
                        });
                    if (place != null) {
                      setState(() {
                        _address = (place.description ?? "Location")
                            .toString();
                      });
                      final plist = GoogleMapsPlaces(
                        apiKey: googleApikey,
                        apiHeaders: await const GoogleApiHeaders()
                            .getHeaders(),
                      );
                      print(plist);
                      String placeid = place.placeId ?? "0";
                      final detail =
                      await plist.getDetailsByPlaceId(placeid);
                      final geometry = detail.result.geometry!;
                       lat = geometry.location.lat;
                      lang = geometry.location.lng;
                      setState(() {
                        _address = (place.description ?? "Location")
                            .toString();
                        print("Address iss...$_address");
                        print("Address iss...$lat");
                      });
                    }
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius:
                              BorderRadius.circular(10.0),
                              color: Colors.grey.shade50),
                          // width: MediaQuery.of(context).size.width - 40,
                          child: ListTile(
                            leading: const Icon(Icons.location_on),
                            title: Text(
                              _address ?? "Location".toString(),
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                            trailing: const Icon(Icons.search),
                            dense: true,
                          )
                      ),

const SizedBox(
  height: 60,
),
                       SizedBox(
                         width: double.maxFinite,
                         child: CommonButton(
                             title: isAddressUpdateRequire ? 'Add Location' :  'Update Location',
                           onPressed: (){
                                if(_address!.isNotEmpty){
                                  updateLocationRepo(
                                    context: context,
                                    address: _address,
                                    lat: lat,
                                    long: lang
                                  ).then((value) {
                                    if(value.status == true){
                                      log(value.status.toString());
                                      getAddressCon.getProfileData();
                                      // Get.back();
                                      Get.offAllNamed(MyRouters.drawerForUser);

                                      showToast(value.msg.toString().toString());
                                    }else{
                                      showToast(value.msg.toString().toString());
                                    }
                                  });
                                }
                                else{
                                  showToast('Select Address');
                                }
                           },
                         ),
                       ),

                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

