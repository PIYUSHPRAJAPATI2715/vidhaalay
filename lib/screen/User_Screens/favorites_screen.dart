import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:vidhaalay_app/controller/deshborad_controller.dart';
import 'package:vidhaalay_app/controller/user_Controller/favourite_controller.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/schools_details_Screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen>
    with TickerProviderStateMixin {
  FavouriteController favouriteController = Get.put(FavouriteController());
  final getSchoolListController = Get.put(GetSchoolListController());

  late TabController tabController;
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    favouriteController.getFavouriteListRepo();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  void _handleTabChange() {
    // Perform your function here based on the current tab index
    int currentIndex = tabController.index;
    print("Tab index changed to: $currentIndex");

    if (currentIndex == 0) {
      favouriteController.favForType.value = "Schools";
    } else if (currentIndex == 1) {
      favouriteController.favForType.value = "Colleges";
    } else {
      favouriteController.favForType.value = "Institute";
    }
    favouriteController.getFavouriteListRepo();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        backgroundColor: AppThemes.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Image.asset(
            AppAssets.arrowBack,
            width: 19,
            color: AppThemes.textBrown,
          ),
          onPressed: () {
            // Get.toNamed(MyRouters.bottomNavigationUserScreen);
            Get.back();
          },
        ),
        title: Text(
          "Favorites",
          style: GoogleFonts.poppins(
              color: AppThemes.textBrown,
              fontSize: 17,
              fontWeight: FontWeight.w600),
        ),
      ),
      body: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: Column(
                      children: [
                        Container(
                          height: 36,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppThemes.textGray, width: 0.5),
                              borderRadius: BorderRadius.circular(50)),
                          child: TabBar(
                            physics: const NeverScrollableScrollPhysics(),
                            tabs: const [
                              Tab(
                                child: Text(
                                  "Schools",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Colleges",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              Tab(
                                child: Text(
                                  "Institutes",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              // Tab(
                              //   child: Text(
                              //     "Videos",
                              //     textAlign: TextAlign.center,
                              //     style: TextStyle(
                              //         fontSize: 14,
                              //         fontWeight: FontWeight.w500),
                              //   ),
                              // ),
                            ],
                            dividerColor: Colors.transparent,
                            padding: EdgeInsets.zero,
                            unselectedLabelColor: const Color(0xFF909090),
                            labelColor: AppThemes.white,
                            labelStyle: const TextStyle(
                                color: Color(0xFF1A2E33),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            unselectedLabelStyle: const TextStyle(
                                color: Color(0xFF909090),
                                fontSize: 14,
                                fontWeight: FontWeight.w500),
                            controller: tabController,
                            indicatorSize: TabBarIndicatorSize.tab,
                            indicator: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                color: AppThemes.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                  titlePadding: EdgeInsets.zero,
                ),
              )
            ];
          },
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            children: [
              Obx(() {
                return favouriteController.isFavouriteListLoading.value
                    ? const CommonProgressIndicator()
                    : favouriteController
                    .favourateListModel.value.data!.length ==
                    0
                    ? Center(child: Text('No Item in Favourite'))
                    : ListView.builder(
                  itemCount: favouriteController
                      .favourateListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = favouriteController
                        .favourateListModel.value.data![index].school;
                    String imageUrl = item!.image![0].toString();
                    imageUrl = imageUrl
                        .replaceAll('[', '')
                        .replaceAll(']', '');

                    int favId = favouriteController.favourateListModel
                        .value.data![index].favForId!;
                    String favFor = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favFor!;

                    bool isFavourite = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favourite!;

                    // if() {
                    //
                    // } else {
                    //
                    // }
                    // favouriteController.isFavouriteBoolList.add(isFavourite);

                    return GestureDetector(
                      onTap: () {
                        getSchoolListController
                            .getSchoolDetailsFunction(
                            item.id.toString());
                        Get.to(
                                () => const SchoolsDetailsScreen(
                                type: 'Schools'),
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
                                  color:
                                  Colors.black.withOpacity(0.2),
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
                                      borderRadius:
                                      BorderRadius.circular(12),
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
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              // ignore: sort_child_properties_last
                                              child: Container(
                                                  height: 130,
                                                  width: 200,
                                                  color: Colors.grey),
                                              baseColor:
                                              Colors.grey[300]!,
                                              highlightColor:
                                              Colors.grey[400]!,
                                            ),
                                        // placeholder: (__, _) =>
                                        // const Center(
                                        //     child:
                                        //     CircularProgressIndicator()),
                                      ),
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        child: GestureDetector(
                                            onTap: () {
                                              // print(favId);
                                              // print(favFor);
                                              // print(item.id);

                                              favouriteController
                                                  .addFavouriteInListRepo(
                                                  favId,
                                                  favFor,
                                                  !isFavourite)
                                                  .then((value) {
                                                favouriteController.getFavouriteListRepo(showloader: false);

                                                // _handleTabChange();
                                              });

                                            },
                                            child: isFavourite
                                                ? const Icon(
                                              Icons.favorite,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            )
                                                : const Icon(
                                              Icons
                                                  .favorite_border,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            ))),
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
                                            style:
                                            GoogleFonts.poppins(
                                                fontWeight:
                                                FontWeight
                                                    .w600,
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.address.toString(),
                                              style:
                                              GoogleFonts.poppins(
                                                  color: AppThemes
                                                      .textGray,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
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
                );
              }),

              Obx(() {
                return favouriteController.isFavouriteListLoading.value
                    ? const CommonProgressIndicator()
                    : favouriteController
                    .favourateListModel.value.data!.length ==
                    0
                    ? Center(child: Text('No Item in Favourite'))
                    : ListView.builder(
                  itemCount: favouriteController
                      .favourateListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = favouriteController
                        .favourateListModel.value.data![index].school;
                    String imageUrl = item!.image![0].toString();
                    imageUrl = imageUrl
                        .replaceAll('[', '')
                        .replaceAll(']', '');

                    int favId = favouriteController.favourateListModel
                        .value.data![index].favForId!;
                    String favFor = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favFor!;

                    bool isFavourite = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favourite!;

                    return GestureDetector(
                      onTap: () {
                        getSchoolListController
                            .getSchoolDetailsFunction(
                            item.id.toString());
                        Get.to(
                                () => const SchoolsDetailsScreen(
                                type: 'Colleges'),
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
                                  color:
                                  Colors.black.withOpacity(0.2),
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
                                      borderRadius:
                                      BorderRadius.circular(12),
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
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              // ignore: sort_child_properties_last
                                              child: Container(
                                                  height: 130,
                                                  width: 200,
                                                  color: Colors.grey),
                                              baseColor:
                                              Colors.grey[300]!,
                                              highlightColor:
                                              Colors.grey[400]!,
                                            ),
                                        // placeholder: (__, _) =>
                                        // const Center(
                                        //     child:
                                        //     CircularProgressIndicator()),
                                      ),
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        child: GestureDetector(
                                            onTap: () {
                                              // print(favId);
                                              // print(favFor);
                                              // print(item.id);

                                              favouriteController
                                                  .addFavouriteInListRepo(
                                                  favId,
                                                  favFor,
                                                  !isFavourite)
                                                  .then((value) {
                                                // _handleTabChange();
                                                favouriteController.getFavouriteListRepo(showloader: false);
                                              });
                                            },
                                            child: isFavourite
                                                ? const Icon(
                                              Icons.favorite,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            )
                                                : const Icon(
                                              Icons
                                                  .favorite_border,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            ))),
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
                                            style:
                                            GoogleFonts.poppins(
                                                fontWeight:
                                                FontWeight
                                                    .w600,
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.address.toString(),
                                              style:
                                              GoogleFonts.poppins(
                                                  color: AppThemes
                                                      .textGray,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
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
                );
              }),

              Obx(() {
                return favouriteController.isFavouriteListLoading.value
                    ? const CommonProgressIndicator()
                    : favouriteController
                    .favourateListModel.value.data!.length ==
                    0
                    ? Center(child: Text('No Item in Favourite'))
                    : ListView.builder(
                  itemCount: favouriteController
                      .favourateListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = favouriteController
                        .favourateListModel.value.data![index].school;
                    String imageUrl = item!.image![0].toString();
                    imageUrl = imageUrl
                        .replaceAll('[', '')
                        .replaceAll(']', '');

                    int favId = favouriteController.favourateListModel
                        .value.data![index].favForId!;
                    String favFor = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favFor!;

                    bool isFavourite = favouriteController
                        .favourateListModel
                        .value
                        .data![index]
                        .favourite!;

                    return GestureDetector(
                      onTap: () {
                        getSchoolListController
                            .getSchoolDetailsFunction(
                            item.id.toString());
                        Get.to(
                                () => const SchoolsDetailsScreen(
                                type: 'Institute'),
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
                                  color:
                                  Colors.black.withOpacity(0.2),
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
                                      borderRadius:
                                      BorderRadius.circular(12),
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
                                        placeholder: (context, url) =>
                                            Shimmer.fromColors(
                                              // ignore: sort_child_properties_last
                                              child: Container(
                                                  height: 130,
                                                  width: 200,
                                                  color: Colors.grey),
                                              baseColor:
                                              Colors.grey[300]!,
                                              highlightColor:
                                              Colors.grey[400]!,
                                            ),
                                        // placeholder: (__, _) =>
                                        // const Center(
                                        //     child:
                                        //     CircularProgressIndicator()),
                                      ),
                                    ),
                                    Positioned(
                                        right: 10,
                                        top: 10,
                                        child: GestureDetector(
                                            onTap: () {
                                              // print(favId);
                                              // print(favFor);
                                              // print(item.id);

                                              favouriteController
                                                  .addFavouriteInListRepo(
                                                  favId,
                                                  favFor,
                                                  !isFavourite)
                                                  .then((value) {
                                                // _handleTabChange();
                                                favouriteController.getFavouriteListRepo(showloader: false);
                                              });
                                            },
                                            child: isFavourite
                                                ? const Icon(
                                              Icons.favorite,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            )
                                                : const Icon(
                                              Icons
                                                  .favorite_border,
                                              size: 21,
                                              color: AppThemes
                                                  .primaryColor,
                                            ))),
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
                                            style:
                                            GoogleFonts.poppins(
                                                fontWeight:
                                                FontWeight
                                                    .w600,
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
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            Icons.location_pin,
                                            color: Colors.red,
                                            size: 18,
                                          ),
                                          Expanded(
                                            child: Text(
                                              item.address.toString(),
                                              style:
                                              GoogleFonts.poppins(
                                                  color: AppThemes
                                                      .textGray,
                                                  fontWeight:
                                                  FontWeight
                                                      .w500,
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
                );
              }),
              // Padding(
              //   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
              //   child:  ListView.builder(
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return GestureDetector(
              //         onTap: (){
              //           // Get.to(() => const SchoolsDetailsScreen(), transition: Transition.fadeIn,duration: const Duration(
              //           //     milliseconds: 250
              //           // ));
              //         },
              //         child: Column(
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                 borderRadius: BorderRadius.circular(12),
              //                 color: AppThemes.white,
              //                 boxShadow: [
              //                   BoxShadow(
              //                     color: Colors.black.withOpacity(0.2),
              //                     spreadRadius: 1,
              //                     blurRadius: 2,
              //                     offset: const Offset(0, 2),
              //                   ),
              //                 ],
              //               ),
              //               child: Column(
              //                 children: [
              //                   Stack(
              //                     children: [
              //                       ClipRRect(
              //                         borderRadius: BorderRadius.circular(12) ,
              //                         child: Image.asset(
              //                           AppAssets.collageImg,
              //                           fit: BoxFit.cover,
              //                           width: size.width,
              //                           height: size.height*.16,
              //                         ),
              //                       ),
              //                       Positioned(
              //                           right: 10, top: 10,
              //                           child: GestureDetector(
              //                               onTap: (){
              //                                 // Get.toNamed(MyRouters.favoritesScreen);
              //                               },
              //                               child: const Icon(Icons.favorite,size: 18,color: Colors.white))
              //                       ),
              //                     ],
              //                   ),
              //                   Padding(
              //                     padding: const EdgeInsets.all(8.0),
              //                     child: Column(
              //                       children: [
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           children: [
              //                             Text('Washington University',
              //                               style: GoogleFonts.poppins(
              //                                   fontWeight: FontWeight.w600,
              //                                   fontSize: 17
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         const SizedBox(
              //                           height: 2,
              //                         ),
              //                         Row(
              //                           mainAxisAlignment: MainAxisAlignment.start,
              //                           children: [
              //                             const Icon(Icons.location_pin,
              //                               color: Colors.red,size: 18,),
              //                             Text('4101,california',
              //                               style: GoogleFonts.poppins(
              //                                   color: AppThemes.textGray,
              //                                   fontWeight: FontWeight.w500,
              //                                   fontSize: 15
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                       ],
              //                     ),
              //                   )
              //                 ],
              //               ),
              //             ),
              //             const SizedBox(
              //               height: 15,
              //             )
              //           ],
              //         ),
              //       );
              //     },
              //   ),
              // ),
            ],
          )),
    );
  }
}
