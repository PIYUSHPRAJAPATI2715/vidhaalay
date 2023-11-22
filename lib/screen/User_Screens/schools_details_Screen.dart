// import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

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

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 6, vsync: this);
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
        title: const Text(
          'Washington University',
          style: TextStyle(
              color: AppThemes.black,
              fontWeight: FontWeight.w600,
              fontSize: 15),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            // CarouselSlider(
            //   options: CarouselOptions(
            //     height: 200, // Adjust the height as needed
            //     aspectRatio: 16/9, // Adjust the aspect ratio as needed
            //     viewportFraction: 0.8, // Adjust the visible item fraction
            //     initialPage: 0, // Set the initial page
            //     enableInfiniteScroll: true, // Enable infinite scrolling
            //     reverse: false, // Set to true for reverse sliding
            //     autoPlay: true, // Enable auto-play
            //     autoPlayInterval: Duration(seconds: 3), // Set auto-play interval
            //     autoPlayAnimationDuration: Duration(milliseconds: 800),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enlargeCenterPage: true, // Enlarge the center item
            //     scrollDirection: Axis.horizontal, // Set the scrolling direction
            //   ),
            //   items: [ ClipRRect(
            //     borderRadius: const BorderRadius.only(
            //         bottomLeft: Radius.elliptical(190, 85)),
            //     child: Image.asset(
            //       AppAssets.collageImg,
            //       fit: BoxFit.cover,
            //       width: double.maxFinite,
            //     ),
            //   ),],
            // ),

            ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.elliptical(190, 85)),
              child: Image.asset(
                AppAssets.collageImg,
                fit: BoxFit.cover,
                width: double.maxFinite,
              ),
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
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Washington University",
                        style: TextStyle(
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
                          const Text(
                            "8.00 am 3.00pm",
                            textAlign: TextAlign.center,
                            style: TextStyle(
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
                        children: const [
                          Icon(
                            Icons.location_pin,
                            color: Colors.red,
                            size: 12,
                          ),
                          SizedBox(
                            width: 6,
                          ),
                          Text(
                            "4010 Parkway street california",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w800,
                                color: AppThemes.textGray),
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
                                                "Elegiblity point",
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
                            physics: const BouncingScrollPhysics(),
                            controller: tabController,
                            children: [
                              SingleChildScrollView(
                                physics: const NeverScrollableScrollPhysics(),
                                child: Padding(
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
                                      const Text(
                                        "it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries",
                                        style: TextStyle(
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
                                              child: Image.asset(
                                            AppAssets.studentImg,
                                            width: 80,
                                          )),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          const Expanded(
                                            child: Text(
                                              "it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries",
                                              style: TextStyle(
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
                                        itemCount: 6,
                                        itemBuilder: (context, index) {
                                          return   Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Throw Ball",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppThemes
                                                                .textGray),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Horse Riding",
                                                        style: TextStyle(
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
                                        itemCount: 3,
                                        itemBuilder: (context, index) {
                                          return   Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Quizzes",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: AppThemes
                                                                .textGray),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: const [
                                                      Icon(
                                                        Icons.arrow_right_alt,
                                                        size: 23,
                                                        color: Colors.orange,
                                                      ),
                                                      SizedBox(
                                                        width: 10,
                                                      ),
                                                      Text(
                                                        "Debates",
                                                        style: TextStyle(
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 24.0),
                                child: GridView.builder(
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 160),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.asset(
                                                    AppAssets.studentImg)),
                                            const Text(
                                              'Rosie Martin',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Text(
                                              'Class Xll - 92%',
                                              style: TextStyle(
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
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 2,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 250),
                                  itemBuilder: (context, index) {
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
                                                child: Image.network(
                                                    "https://media.istockphoto.com/id/1034467592/vector/certificate-or-diploma-retro-vintage-design-template.jpg?s=612x612&w=0&k=20&c=SAwn84m93JtMDjASvulqHsh7zXu_95hJjgbADF7aJXY=")),
                                            const Text(
                                              'Achievement Certificate',
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.black),
                                            ),
                                            const Text(
                                              '2016',
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w600,
                                                  color: Color(0xFFfcd69f)),
                                            ),
                                            const Text(
                                              'Lorem Ipsum is simply dummy text of the printing and typesettingindustry.',
                                              style: TextStyle(
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
                                  itemCount: 6,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 3,
                                          mainAxisSpacing: 5,
                                          crossAxisSpacing: 10,
                                          mainAxisExtent: 110),
                                  itemBuilder: (context, index) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Column(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                child: Image.network(
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQnR6jp2hZLh1dvJDxqLgVeeu2UhpkRZ5hHAg&usqp=CAU")),
                                          ],
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Column(
                                children: [
                                  const SizedBox(height: 20,),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics: const NeverScrollableScrollPhysics(),
                                      itemCount: 3,
                                      itemBuilder: (context, index) {
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
                                                    "Class 1st",
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
                                                          Color(0xFF07B6CA),
                                                      isThreeLine: true,
                                                      subtitle: Column(
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: const [
                                                              Text(
                                                                'Admission Regestration',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.grey,
                                                                  fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$500',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.grey,
                                                                  fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: const [
                                                              Text(
                                                                '1st Quarter (Apr-Jul)',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.grey,
                                                                  fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$2500',
                                                                style: TextStyle(
                                                                  color:
                                                                      Colors.grey,
                                                                  fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: const [
                                                              Text(
                                                                '2nd Quarter (Aug-Nov)',
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$2500',
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: const [
                                                              Text(
                                                                '3rd Quarter (Dec-Mar)',
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                              Text(
                                                                '\$2500',
                                                                style: TextStyle(
                                                                    color:
                                                                    Colors.grey,
                                                                    fontSize: 12,fontWeight: FontWeight.w300
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 8,),
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
                              Column(
                                children: const [
                                  SizedBox(height: 20,),
                               Text("Fees structure")
                                ],
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
      ),
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
