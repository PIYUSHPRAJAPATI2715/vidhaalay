import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/schools_details_Screen.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../controller/deshborad_controller.dart';
import '../../controller/get_profile_controller.dart';
import '../../models/login_model.dart';
import '../../models/update_location_model.dart';
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
  final getAddressCon  = Get.put(GetProfileController());

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      getAddressCon.getProfileData();
    });
    getSchoolListController.getSchoolListFunction();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

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
           Obx(() {
             return GestureDetector(
               onTap: (){
                 Get.to(() => const AddressScreen());
               },
               child: Text(
                 getAddressCon.isProfileLoading.value == true ?  getAddressCon.getProfileModel.value.data!.address.toString()
                 :  'Select Address',
                 style: const TextStyle(
                     color: AppThemes.black,
                     fontWeight: FontWeight.w600,
                     fontSize: 15),
               ),
             );
           })
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
                          const Text(
                            'View All',
                            style: TextStyle(
                                color: AppThemes.primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 18,
                      ),
                      SizedBox(
                        height: size.height * .25,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: 5,
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
                                        vertical: 13, horizontal: 5),
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
                                        Image.asset(
                                          AppAssets.lectureImg,
                                          width: size.width * .33,
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        Text(
                                          'Creative Art Design',
                                          style: GoogleFonts.poppins(
                                              color: AppThemes.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 3,
                                        ),
                                        const Text(
                                          'Creative Art Design here dummy data',
                                          style: TextStyle(
                                              color: AppThemes.white,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 10),
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
                    return GestureDetector(
                      onTap: () {
                        Get.to(() =>  const SchoolsDetailsScreen(),
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
                                              Get.toNamed(MyRouters
                                                  .favoritesScreen);
                                            },
                                            child: const Icon(
                                                Icons.favorite_border,
                                                size: 18,
                                                color: Colors.white))),
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

              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
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
                                    child: Image.asset(
                                      AppAssets.collageImg,
                                      fit: BoxFit.cover,
                                      width: size.width,
                                      height: size.height * .16,
                                    ),
                                  ),
                                  const Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Icon(Icons.favorite_border,
                                          size: 18, color: Colors.white)),
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
                                          'Washington University',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
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
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        Text(
                                          '4101,california',
                                          style: GoogleFonts.poppins(
                                              color: AppThemes.textGray,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
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
                    );
                  },
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                child: ListView.builder(
                  itemCount: 3,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Column(
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
                                    child: Image.asset(
                                      AppAssets.collageImg,
                                      fit: BoxFit.cover,
                                      width: size.width,
                                      height: size.height * .16,
                                    ),
                                  ),
                                  const Positioned(
                                      right: 10,
                                      top: 10,
                                      child: Icon(Icons.favorite_border,
                                          size: 18, color: Colors.white)),
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
                                          'Washington University',
                                          style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w600,
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
                                      children: [
                                        const Icon(
                                          Icons.location_pin,
                                          color: Colors.red,
                                          size: 18,
                                        ),
                                        Text(
                                          '4101,california',
                                          style: GoogleFonts.poppins(
                                              color: AppThemes.textGray,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 15),
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
                    );
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
