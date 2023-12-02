// import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

import '../../controller/deshborad_controller.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';

class SchoolsDetailsScreen extends StatefulWidget {
  const SchoolsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SchoolsDetailsScreen> createState() => _SchoolsDetailsScreenState();
}

class _SchoolsDetailsScreenState extends State<SchoolsDetailsScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  final getSchoolDetailsController = Get.put(GetSchoolListController());

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    getSchoolDetailsController.getSchoolDetailsFunction();
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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
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
        title:  Text(
            getSchoolDetailsController.schoolDetailsModel.value.data!.name.toString(),
          style: const  TextStyle(
              color: AppThemes.black,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: Obx((){
        return getSchoolDetailsController.isSchoolDetailsLoading.value == true ?
        SafeArea(
          child: Stack(
            children: [
              Container(
                color: Colors.white,
              ),

              ClipRRect(
                borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.elliptical(190, 85)),
                child:  CachedNetworkImage(
                  imageUrl:  getSchoolDetailsController.schoolDetailsModel.value.data!.image.toString(),
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  errorWidget: (__, _, ___) =>
                      Image.asset(
                        AppAssets.collageImg,
                        fit: BoxFit.cover,
                        width: double.maxFinite,
                      ),
                  placeholder: (__, _) =>
                  const Center(
                      child: CircularProgressIndicator()),
                )
              ),
              Positioned(
                  top: 10,
                  right: 15,
                  child: GestureDetector(
                      onTap: () {
                        Get.toNamed(MyRouters.favoritesScreen);
                      },
                      child: const Icon(
                        Icons.favorite,
                        color: AppThemes.white,
                      ))),
              Positioned.fill(
                top: size.height * .268,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                  ),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                         Text(
                           getSchoolDetailsController.schoolDetailsModel.value.data!.name.toString(),
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              AppAssets.watchIcon,
                              width: 12,
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                             Text(
                               '${getSchoolDetailsController.schoolDetailsModel.value.data!.openTime.toString()}  ${getSchoolDetailsController.schoolDetailsModel.value.data!.closeTime.toString()}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800,
                                  color: AppThemes.textGray),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children:  [
                            const Icon(
                              Icons.location_pin,
                              color: Colors.red,
                              size: 12,
                            ),
                            const SizedBox(
                              width: 6,
                            ),

                            FittedBox(
                              child: Text(
                                getSchoolDetailsController.schoolDetailsModel.value.data!.address.toString(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w800,
                                    color: AppThemes.textGray),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 23,
                        ),
                        SizedBox(
                          height: double.maxFinite,
                          child: NestedScrollView(
                            headerSliverBuilder: (_, __) {
                              return [
                                SliverToBoxAdapter(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 35,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppThemes.textGray,
                                                width: 0.5),
                                            borderRadius:
                                            BorderRadius.circular(50)),
                                        child: Theme(
                                          data: theme.copyWith(
                                            colorScheme: theme.colorScheme.copyWith(
                                              surfaceVariant: Colors.transparent,
                                            ),
                                          ),
                                          child: TabBar(
                                            physics:
                                            const AlwaysScrollableScrollPhysics(),
                                            isScrollable: true,
                                            tabs: const [
                                              Tab(
                                                child: Text(
                                                  "Info",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  "Top Student",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  "Achievements",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  "Gallery",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),

                                              Tab(
                                                child: Text(
                                                  "Fee Structure",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w500),
                                                ),
                                              ),
                                            ],
                                            padding: EdgeInsets.zero,
                                            unselectedLabelColor:
                                            const Color(0xFF909090),
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
                                                borderRadius:
                                                BorderRadius.circular(50),
                                                color: AppThemes.black),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ];
                            },
                            body: TabBarView(
                              physics: const AlwaysScrollableScrollPhysics(),
                              controller: tabController,
                              children: [

                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 13.0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "About US".toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppThemes.blueColor),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                       Text(
                                         getSchoolDetailsController.schoolDetailsModel.value.data!.info!.aboutUs.toString(),
                                        style: const TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w500,
                                            color: AppThemes.textGray),
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "from principal".toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppThemes.blueColor),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: [
                                          ClipOval(
                                              child: CachedNetworkImage(
                                                imageUrl:  getSchoolDetailsController.schoolDetailsModel.value.data!.info!.principalImage.toString(),
                                                fit: BoxFit.cover,
                                                width: 80,
                                                height: 80,
                                                errorWidget: (__, _, ___) =>
                                                    Image.asset(
                                                      AppAssets.studentImg,
                                                      width: 80,
                                                    ),
                                                placeholder: (__, _) =>
                                                const Center(
                                                    child: CircularProgressIndicator()),
                                              ),
                                             ),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                           Expanded(
                                            child: Text(
                                              getSchoolDetailsController.schoolDetailsModel.value.data!.info!.principalDetail.toString(),
                                              style: const TextStyle(
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.w500,
                                                  color: AppThemes.textGray),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "facilities".toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppThemes.blueColor),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.info!.facilities!.length,
                                        itemBuilder: (context, index) {
                                          var item = getSchoolDetailsController.schoolDetailsModel.value.data!.info!.facilities![index];
                                          return   Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children:  [
                                                      const Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        item.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: AppThemes
                                                                .textGray),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        height: 35,
                                      ),
                                      Text(
                                        "features".toUpperCase(),
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800,
                                            color: AppThemes.blueColor),
                                      ),
                                      const SizedBox(
                                        height: 11,
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.info!.features!.length,
                                        itemBuilder: (context, index) {
                                          var items = getSchoolDetailsController.schoolDetailsModel.value.data!.info!.features![index];
                                          return   Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                                children: [
                                                  Row(
                                                    children:  [
                                                      const Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        items.toString(),
                                                        style: const TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            color: AppThemes
                                                                .textGray),
                                                      ),
                                                    ],
                                                  ),

                                                ],
                                              )
                                            ],
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                                  child: GridView.builder(
                                    itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.topStudents!.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 160),
                                    itemBuilder: (context, index) {
                                      var item = getSchoolDetailsController.schoolDetailsModel.value.data!.topStudents![index];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                  borderRadius: BorderRadius.circular(10),
                                                  child: CachedNetworkImage(
                                                    imageUrl: item.image.toString(),
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
                                                  )),
                                               Text(
                                                 item.name.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                               Text(
                                                'class ${item.classNo.toString()}  ${item.percentage.toString()}',
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                                  child: GridView.builder(
                                    itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.achievements!.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 250),
                                    itemBuilder: (context, index) {
                                      var item = getSchoolDetailsController.schoolDetailsModel.value.data!.achievements![index];
                                      return Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.start,
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child:  CachedNetworkImage(
                                                    imageUrl: item.image.toString(),
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
                                                  )),
                                               Text(
                                                 item.name.toString(),
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.black),
                                              ),
                                               Text(
                                                item.year.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w600,
                                                    color: Color(0xFFfcd69f)),
                                              ),
                                               Text(
                                              item.description.toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 24.0),
                                  child: GridView.builder(
                                    itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.gallery!.length,
                                    shrinkWrap: true,
                                    gridDelegate:
                                     SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: size.height*.18),
                                    itemBuilder: (context, index) {
                                      var item = getSchoolDetailsController.schoolDetailsModel.value.data!.gallery![index];
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Column(
                                            children: [
                                              ClipRRect(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  child:  CachedNetworkImage(
                                                    imageUrl: item.url.toString(),
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
                                                  ))
                                            ],
                                          )
                                        ],
                                      );
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 20,),
                                      ListView.builder(
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemCount: getSchoolDetailsController.schoolDetailsModel.value.data!.feeStructure!.length,
                                          itemBuilder: (context, index) {
                                            var item = getSchoolDetailsController.schoolDetailsModel.value.data!.feeStructure![index];
                                            return Column(
                                              children: <Widget>[

                                                Container(
                                                  padding: const EdgeInsets.all(1),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,

                                                      borderRadius:
                                                      BorderRadius.circular(12),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                            color: Colors.black26,
                                                            blurRadius: 1,
                                                            offset: Offset(1, 1))
                                                      ]),
                                                  child: Theme(
                                                    data: Theme.of(context).copyWith(
                                                        dividerColor:
                                                        Colors.transparent),
                                                    child: ExpansionTile(

                                                      backgroundColor:
                                                      const Color(0xFFFCFBFA),
                                                      iconColor:
                                                      Colors.black,
                                                      collapsedIconColor:
                                                      Colors.black,
                                                      childrenPadding:
                                                      const EdgeInsets.all(1),
                                                      title: Text(
                                                        item.title.toString(),
                                                        style: GoogleFonts.poppins(
                                                          color:
                                                          const Color(0xFF1D1D1D),
                                                          fontWeight: FontWeight.w500,
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      children:  <Widget>[
                                                        ListTile(
                                                          iconColor:
                                                          const Color(0xFF07B6CA),
                                                          isThreeLine: true,
                                                          subtitle: Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children:  [
                                                                  const Text(
                                                                    'Admission Regestration',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.registration.toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children:  [
                                                                  const Text(
                                                                    '1st Quarter (Apr-Jul)',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.quarter1.toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children:  [
                                                                  const Text(
                                                                    '2nd Quarter (Aug-Nov)',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.quarter2.toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 8,),
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children:  [
                                                                  const Text(
                                                                    '3rd Quarter (Dec-Mar)',
                                                                    style: TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    item.quarter3.toString(),
                                                                    style: const TextStyle(
                                                                        color:
                                                                        Colors.grey,
                                                                        fontSize: 12,fontWeight: FontWeight.w300
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 8,),
                                                            ],
                                                          ),
                                                          dense: true,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 20,
                                                ),
                                              ],
                                            );
                                          }),
                                    ],
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ) : const CommonProgressIndicator();
      } ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Get.toNamed(MyRouters.registrationScreen);
        },
        child: Container(
          height: 44,
          color: AppThemes.primaryColor,
          child: Center(
            child: Text(
              "apply for admission".toUpperCase(),
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  color: AppThemes.white),
            ),
          ),
        ),
      ),
    );
  }
}
