import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/controller/deshborad_controller.dart';
import 'package:vidhaalay_app/controller/user_Controller/favourite_controller.dart';
import 'package:vidhaalay_app/controller/user_Controller/see_all_controller.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/screen/User_Screens/schools_details_Screen.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

class SeeAllScreen extends StatefulWidget{

  final String type;
  final String appBarTitle;

  const SeeAllScreen({super.key, required this.type, required this.appBarTitle});

  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {

  final seeAllController  = Get.put(SeeAllController());
  final getSchoolDetailsController = Get.put(GetSchoolListController());
  final favouriteController  = Get.put(FavouriteController());

  @override
  void initState() {
    super.initState();
    seeAllController.roleType.value = widget.type;
    seeAllController.getSchoolListFunction();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Obx(
      () => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: true,
          backgroundColor: AppThemes.white,
          leading: IconButton(
            icon: Image.asset(
              AppAssets.arrowBack,
              width: 19,
              color: AppThemes.textBrown,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          title: Text(widget.appBarTitle,
            style: GoogleFonts.poppins(
              fontSize: 19,
              fontWeight: FontWeight.w600,
              color: AppThemes.black,
            ),
          ),
        ),
        body: seeAllController.isSchoolListLoading.value == false ?
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics:
                  BouncingScrollPhysics(),
                  // physics: const AlwaysScrollableScrollPhysics(),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 5),
                      child: Shimmer.fromColors(
                        baseColor:
                        Colors.grey.shade500,
                        highlightColor:
                        Colors.grey.shade100,
                        child: Container(
                          height: size.height * .22,
                          width: size.width * .35,
                          decoration:
                          BoxDecoration(
                            color: Colors
                                .white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    );
                  },
              ) :
              seeAllController.getSchoolListModel.value.data!.isEmpty ?
              Center(child: Text("No Data Found",style: TextStyle(
                  color: Colors.black
              ),),)
                  :  ListView.builder(
                itemCount: seeAllController
                    .getSchoolListModel.value.data!.length,
                shrinkWrap: true,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  var item = seeAllController.getSchoolListModel.value.data![index];
                  String imageUrl = item.image.toString();
                  imageUrl = imageUrl.replaceAll('[', '').replaceAll(']', '');

                  bool isFavourite = item.favourite == null ? false : item.favourite!['favourite'];
                  print("favourtie : $isFavourite");

                  return GestureDetector(
                    onTap: () {
                      getSchoolDetailsController.getSchoolDetailsFunction(item.id.toString());

                      Get.to(() =>  SchoolsDetailsScreen(type: widget.appBarTitle),
                          transition: Transition.fadeIn,
                          duration:
                          const Duration(milliseconds: 250));
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppThemes.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: CachedNetworkImage(
                                      imageUrl: imageUrl.toString(),
                                      fit: BoxFit.cover,
                                      width: size.width,
                                      height: size.height * .16,
                                      errorWidget: (__, _, ___) =>
                                          Image.asset(
                                            AppAssets.collageImg,
                                            fit: BoxFit.cover,
                                            width: size.width,
                                            height: size.height * .16,
                                          ),
                                      placeholder: (__, _) =>
                                      const Center(
                                          child: CircularProgressIndicator()),
                                    ),
                                  ),
                                  Positioned(
                                      right: 10,
                                      top: 10,
                                      child: GestureDetector(
                                          onTap: () {
                                            favouriteController.addFavouriteInListRepo(item.id!, widget.appBarTitle, !isFavourite).then(
                                                    (value) {
                                                  // _handleTabChange();
                                                });
                                            // Get.toNamed(MyRouters
                                            //     .favoritesScreen);
                                          },
                                          child:   isFavourite ? const Icon(
                                            Icons.favorite,
                                            size: 21,
                                            color:AppThemes.primaryColor,
                                          ) :
                                          const Icon(
                                              Icons.favorite_border,
                                              size: 21,
                                              color: AppThemes.hightlightFavourite
                                          )
                                      )
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          item.name.toString(),
                                          style: GoogleFonts.poppins(
                                              fontWeight:
                                              FontWeight.w600,
                                              fontSize: 17),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 2,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        Expanded(
                                          child: Text(
                                            item.address.toString(),
                                            style: GoogleFonts.poppins(
                                                color:
                                                AppThemes.textGray,
                                                fontWeight:
                                                FontWeight.w500,
                                                fontSize: 15),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        )
                      ],
                    ),
                  );
                },
              )
      ),
    );
  }
}