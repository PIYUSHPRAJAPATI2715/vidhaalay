import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/controller/bottom_controller.dart';
import 'package:vidhaalay_app/controller/user_Controller/favourite_controller.dart';
import 'package:vidhaalay_app/controller/user_Controller/lectures_controller.dart';
import 'package:vidhaalay_app/models/get_profile_model.dart';
import 'package:vidhaalay_app/repositories/get_profile_repo.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/lecture_list_screen.dart';
import 'package:vidhaalay_app/screen/User_Screens/schools_details_Screen.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controller/deshborad_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../../models/login_model.dart';
import '../../models/update_location_model.dart';
import '../../repositories/addTo_fav_repo.dart';
import '../../resourses/api_constant.dart';
import '../../widgets/circular_progressindicator.dart';
import 'address_screen.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;
  final TextEditingController searchController = TextEditingController();
  final getSchoolListController  = Get.put(GetSchoolListController());
  FavouriteController favouriteController  = Get.put(FavouriteController());
  LecturesController lecturesController  = Get.put(LecturesController());

  final getAddressCon  = Get.put(GetProfileController());
  final bottomController = Get.put(BottomController());

  String? location = null;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(_handleTabChange);
    lecturesController.getTopLectureListRepo();
    getLocation();
  }

  @override
  void dispose() {
    // tabController.removeListener(_handleTabChange);
    tabController.dispose();
    super.dispose();
  }

  Future<void> getLocation() async {
    GetProfileModel getProfileModel = GetProfileModel();

    await getProfileRepo().then((value) {
      getProfileModel = value;
      setState(() {
        location = getProfileModel.data?.address;
      });
      print("Location $location");
      if(location == null) {
        Get.to(() => AddressScreen(isAddressUpdateRequire: true,));
      }
    });
  }

  void _handleTabChange() {
    // Perform your function here based on the current tab index
    int currentIndex = tabController.index;
    print("Tab index changed to: $currentIndex");

    if(currentIndex == 0) {
      getSchoolListController.roleType.value = "S";
    } else if (currentIndex == 1) {
      getSchoolListController.roleType.value = "C";
    } else {
      getSchoolListController.roleType.value = "I";
    }
    getSchoolListController.getSchoolListFunction();
  }

  logOutUser() async {
    SharedPreferences sharedPreference = await SharedPreferences.getInstance();
    // LoginModel modelSiteSettings = LoginModel();
    // if (sharedPreference.getString("token") != null) {
    //   modelSiteSettings =
    //       LoginModel.fromJson(jsonDecode(sharedPreference.getString("token")!));
    // }
    await sharedPreference.clear();
    Get.offAllNamed(MyRouters.signInPage);
    showToast("Logged out");
    // if (modelSiteSettings.data != null) {
    //   sharedPreference.setString("token", jsonEncode(modelSiteSettings));
    // }
  }

  double value = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var theme = Theme.of(context);
    return Scaffold(
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:  Row(
          children: [
            const Icon(
              Icons.location_pin,
              color: AppThemes.primaryColor,
              size: 20,
            ),
            const SizedBox(
              width: 4,
            ),
            Expanded(
              child: GestureDetector(
                 onTap: (){
                   Get.to(() => AddressScreen(address: location!,));
                 },
                 child: Text(
                     location == null ? 'Select Address' : location!,
                   // getAddressCon.isProfileLoading.value == true ?  getAddressCon.getProfileModel.value.data!.address.toString()
                   // :  'Select Address',
                   maxLines: 1,
                   style: TextStyle(
                     overflow: TextOverflow.ellipsis,
                       color: AppThemes.black,
                       fontWeight: FontWeight.w600,
                       fontSize: 15),
                 ),
               ),
            )
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(MyRouters.myProfileScreen);
                  },
                  child: ClipOval(
                    child: Image.asset(
                      AppAssets.studentImg,
                      height: 35,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (_, __) {
            return [
              SliverToBoxAdapter(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        height: 37,
                        child: TextField(
                          maxLines: 1,
                          controller: searchController,
                          style: const TextStyle(fontSize: 17),
                          textAlignVertical: TextAlignVertical.center,
                          textInputAction: TextInputAction.search,
                          onSubmitted: (value) => {},
                          decoration: InputDecoration(
                              filled: true,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  // Get.to(const SearchScreenData());
                                  // FocusManager.instance.primaryFocus!
                                  //     .unfocus();
                                  // print(homeSearchController
                                  //     .searchController);
                                  // Get.toNamed(
                                  //     SearchScreenData.searchScreen);
                                },
                                icon: const Icon(
                                  Icons.search_rounded,
                                  color: AppThemes.black,
                                  size: 19,
                                ),
                              ),
                              border: const OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              hintText: 'Search',
                              hintStyle: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400)),
                        ),
                      ),
                      const SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Top Lectures',
                            style: GoogleFonts.poppins(
                                color: AppThemes.black,
                                fontSize: 17,
                                fontWeight: FontWeight.w600),
                          ),
                          InkWell(
                            onTap: () {
                              Get.to(() => LectureListScreen());
                            },
                            child: const Text(
                              'View All',
                              style: TextStyle(
                                  color: AppThemes.primaryColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),

                      lecturesController.isLectureListLoading.value ? CommonProgressIndicator() : SizedBox(
                        height: size.height * .22,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: lecturesController.lectureListModel.value.data!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12.0)
                                      .copyWith(left: 0),
                              child: Row(
                                children: [
                                  Container(
                                    width: size.width * .35,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 7),
                                    decoration: BoxDecoration(
                                      color: AppThemes.lightBlue,
                                      borderRadius: BorderRadius.circular(8),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: CachedNetworkImage(
                                            imageUrl: lecturesController.lectureListModel.value.data![index].image!,
                                            fit: BoxFit.cover,
                                            width: size.width * .33,
                                            height: size.height * .09,
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
                                        // Image.network(
                                        //   lecturesController.lectureListModel.value.data![index].image!,
                                        //   width: size.width * .33,
                                        // ),
                                        // Image.asset(
                                        //   AppAssets.lectureImg,
                                        //   width: size.width * .33,
                                        // ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        Text(
                                            lecturesController.lectureListModel.value.data![index].name!,
                                          // 'Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design',
                                          style: GoogleFonts.poppins(
                                              color: AppThemes.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                          maxLines: 3,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          lecturesController.lectureListModel.value.data![index].description!,
                                          // 'Creative Art Design here dummy data',
                                          // 'Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design Creative Art Design',
                                          style: TextStyle(
                                              color: AppThemes.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(
                        height: 34,
                      ),


                      Container(
                        height: 35,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppThemes.textGray, width: 0.5),
                            borderRadius: BorderRadius.circular(50)),
                        child: Theme(
                          data: theme.copyWith(
                            colorScheme: theme.colorScheme.copyWith(
                              surfaceVariant: Colors.transparent,
                            ),
                          ),
                          child: TabBar(
                            indicatorColor: Colors.transparent,
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
                            ],
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
                                color: AppThemes.primaryColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            controller: tabController,
            children: [
              Obx(() {
                return getSchoolListController.isSchoolListLoading.value == true ? ListView.builder(
                  itemCount: getSchoolListController
                      .getSchoolListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = getSchoolListController.getSchoolListModel.value.data![index];
                    String imageUrl = item.image.toString();
                    imageUrl = imageUrl.replaceAll('[', '').replaceAll(']', '');

                    bool isFavourite = item.favourite == null ? false : item.favourite!['favourite'];
                    print("favourtie : $isFavourite");

                    return GestureDetector(

                      onTap: () {
                        getSchoolListController.getSchoolDetailsFunction(item.id.toString());

                        Get.to(() =>  const SchoolsDetailsScreen(type: "Schools"),
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
                                              favouriteController.addFavouriteInListRepo(item.id!,"Schools", !isFavourite).then(
                                                      (value) {
                                                    _handleTabChange();
                                                  });

                                              // Get.toNamed(MyRouters
                                              //     .favoritesScreen);
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                                size: 18,
                                                color: isFavourite ? AppThemes.hightlightFavourite : AppThemes.black,
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
                    : const CommonProgressIndicator();
              }),

              Obx(() {
                return getSchoolListController.isSchoolListLoading.value == true ? ListView.builder(
                  itemCount: getSchoolListController
                      .getSchoolListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = getSchoolListController.getSchoolListModel.value.data![index];
                    String imageUrl = item.image.toString();
                    imageUrl = imageUrl.replaceAll('[', '').replaceAll(']', '');
                    bool isFavourite = item.favourite == null ? false : item.favourite!['favourite'];
                    print("favourtie : $isFavourite");

                    return GestureDetector(
                      onTap: () {
                        getSchoolListController.getSchoolDetailsFunction(item.id.toString());

                        Get.to(() =>  const SchoolsDetailsScreen(type: "Colleges"),
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
                                              print(item.id);
                                              favouriteController.addFavouriteInListRepo(item.id!,"Colleges", !isFavourite).then(
                                                      (value) {
                                                        _handleTabChange();
                                                      });
                                              // Get.toNamed(MyRouters
                                              //     .favoritesScreen);
                                            },
                                            child:  Icon(
                                              Icons.favorite,
                                              size: 18,
                                              color: isFavourite ? AppThemes.hightlightFavourite : AppThemes.black,
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
                    : const CommonProgressIndicator();
              }),
              Obx(() {
                return getSchoolListController.isSchoolListLoading.value == true ? ListView.builder(
                  itemCount: getSchoolListController
                      .getSchoolListModel.value.data!.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(16),
                  itemBuilder: (context, index) {
                    var item = getSchoolListController.getSchoolListModel.value.data![index];
                    String imageUrl = item.image.toString();
                    imageUrl = imageUrl.replaceAll('[', '').replaceAll(']', '');
                    bool isFavourite = item.favourite == null ? false : item.favourite!['favourite'];
                    print("favourtie : $isFavourite");

                    return GestureDetector(
                      onTap: () {
                        getSchoolListController.getSchoolDetailsFunction(item.id.toString());

                        Get.to(() =>  const SchoolsDetailsScreen(type: "Institute"),
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
                                              favouriteController.addFavouriteInListRepo(item.id!,"Institute", !isFavourite).then(
                                                      (value) {
                                                    _handleTabChange();
                                                  });
                                            },
                                            child: Icon(
                                              Icons.favorite,
                                              size: 18,
                                              color: isFavourite ? AppThemes.hightlightFavourite : AppThemes.black,
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
                    : const CommonProgressIndicator();
              }),

              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              //   child: ListView.builder(
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               color: AppThemes.white,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.2),
              //                   spreadRadius: 1,
              //                   blurRadius: 2,
              //                   offset: const Offset(0, 2),
              //                 ),
              //               ],
              //             ),
              //             child: Column(
              //               children: [
              //                 Stack(
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.asset(
              //                         AppAssets.collageImg,
              //                         fit: BoxFit.cover,
              //                         width: size.width,
              //                         height: size.height * .16,
              //                       ),
              //                     ),
              //                     const Positioned(
              //                         right: 10,
              //                         top: 10,
              //                         child: Icon(Icons.favorite_border,
              //                             size: 18, color: Colors.white)),
              //                   ],
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             'Washington University',
              //                             style: GoogleFonts.poppins(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize: 17),
              //                           ),
              //                         ],
              //                       ),
              //                       const SizedBox(
              //                         height: 2,
              //                       ),
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         children: [
              //                           const Icon(
              //                             Icons.location_pin,
              //                             color: Colors.red,
              //                             size: 18,
              //                           ),
              //                           Text(
              //                             '4101,california',
              //                             style: GoogleFonts.poppins(
              //                                 color: AppThemes.textGray,
              //                                 fontWeight: FontWeight.w500,
              //                                 fontSize: 15),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 15,
              //           )
              //         ],
              //       );
              //     },
              //   ),
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
              //   child: ListView.builder(
              //     itemCount: 3,
              //     shrinkWrap: true,
              //     itemBuilder: (context, index) {
              //       return Column(
              //         children: [
              //           Container(
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(12),
              //               color: AppThemes.white,
              //               boxShadow: [
              //                 BoxShadow(
              //                   color: Colors.black.withOpacity(0.2),
              //                   spreadRadius: 1,
              //                   blurRadius: 2,
              //                   offset: const Offset(0, 2),
              //                 ),
              //               ],
              //             ),
              //             child: Column(
              //               children: [
              //                 Stack(
              //                   children: [
              //                     ClipRRect(
              //                       borderRadius: BorderRadius.circular(12),
              //                       child: Image.asset(
              //                         AppAssets.collageImg,
              //                         fit: BoxFit.cover,
              //                         width: size.width,
              //                         height: size.height * .16,
              //                       ),
              //                     ),
              //                     const Positioned(
              //                         right: 10,
              //                         top: 10,
              //                         child: Icon(Icons.favorite_border,
              //                             size: 18, color: Colors.white)),
              //                   ],
              //                 ),
              //                 Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         children: [
              //                           Text(
              //                             'Washington University',
              //                             style: GoogleFonts.poppins(
              //                                 fontWeight: FontWeight.w600,
              //                                 fontSize: 17),
              //                           ),
              //                         ],
              //                       ),
              //                       const SizedBox(
              //                         height: 2,
              //                       ),
              //                       Row(
              //                         mainAxisAlignment:
              //                             MainAxisAlignment.start,
              //                         children: [
              //                           const Icon(
              //                             Icons.location_pin,
              //                             color: Colors.red,
              //                             size: 18,
              //                           ),
              //                           Text(
              //                             '4101,california',
              //                             style: GoogleFonts.poppins(
              //                                 color: AppThemes.textGray,
              //                                 fontWeight: FontWeight.w500,
              //                                 fontSize: 15),
              //                           ),
              //                         ],
              //                       ),
              //                     ],
              //                   ),
              //                 )
              //               ],
              //             ),
              //           ),
              //           const SizedBox(
              //             height: 15,
              //           )
              //         ],
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );

  }
  Column buildIconButton(int index, int index1, BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 31,
          height: 30,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: IconButton(
              onPressed: () {
                addToWishlistRepo(context: context,favFor: 'school',favourite: getSchoolListController.getSchoolListModel.value.data![index].favourite.toString(),
                    favId: getSchoolListController.getSchoolListModel.value.data![index].id.toString())
                    .then((value) {
                  showToast(value.msg.toString());
                  if (value.status == true) {
                    showToast(value.msg.toString());
                    setState(() {});
                  }
                  return null;
                });
              },
              icon: const Padding(
                padding: EdgeInsets.only(
                    right: 00.0, bottom: 0, top: 0, left: 0.0),
                child: Icon(
                  // _controller.model.value.data!.categoryProducts![index]
                  //     .products![index1].isInWishlist.value ==
                  //     true
                  //     ? Icons.favorite
                  //     :
                Icons.favorite_border,
                  // color: AppTheme.primaryColor,
                  color: Color(0xFF000000),
                  size: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


