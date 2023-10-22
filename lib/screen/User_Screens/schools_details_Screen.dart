import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';

class SchoolsDetailsScreen extends StatefulWidget {
  const SchoolsDetailsScreen({Key? key}) : super(key: key);

  @override
  State<SchoolsDetailsScreen> createState() => _SchoolsDetailsScreenState();
}

class _SchoolsDetailsScreenState extends State<SchoolsDetailsScreen> with TickerProviderStateMixin{
  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);

  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading:  IconButton(
      icon: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.textBrown,),
      onPressed: (){
        Get.back();
      },
    ),
        title: const Text('Washington University',
          style: TextStyle(
              color: AppThemes.black,
              fontWeight: FontWeight.w600,
              fontSize: 15
          ),),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(bottomLeft:  Radius.elliptical(190, 85)),
              child: Image.asset(AppAssets.collageImg,fit: BoxFit.cover,width: double.maxFinite,),
            ),
             Positioned(
              top: 10,
              right: 15,
              child: GestureDetector(
                onTap: (){
                  Get.toNamed(MyRouters.favoritesScreen);
                },
                  child: const Icon(Icons.favorite,color: AppThemes.white,))
            ),

            Positioned.fill(
              top: size.height*.268,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 30,
                      ),
                      const Text(
                        "Washington University",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                      ),
                     const SizedBox(
                        height: 4,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.watchIcon,width: 12,),
                         const SizedBox(width: 6,),
                          const Text(
                            "8.00 am 3.00pm",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,color: AppThemes.textGray),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                       Icon(Icons.location_pin,color: Colors.red,size: 12,),
                         SizedBox(width: 6,),
                          Text(
                            "4010 Parkway street california",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800,color: AppThemes.textGray),
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
                                              width: 0.5
                                          ),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: TabBar(
                                        physics: const AlwaysScrollableScrollPhysics(),
                                        tabs: const[
                                          Tab(
                                            child: Text(
                                              "Info",
                                              textAlign: TextAlign.center,
                                              style:TextStyle(
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
                                            color: AppThemes.black
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
                                  physics: BouncingScrollPhysics(),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 13.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                         Text(
                                          "About US".toUpperCase(),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800
                                          ,color: AppThemes.blueColor
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        const Text(
                                          "it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries",
                                          style:  TextStyle(fontSize: 11, fontWeight: FontWeight.w500
                                          ,color: AppThemes.textGray
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          "from principal".toUpperCase(),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800
                                              ,color: AppThemes.blueColor
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          children: [
                                            ClipOval(child: Image.asset(AppAssets.studentImg,width: 80,)),
                                            const SizedBox(
                                              width: 12,
                                            ),
                                            const Expanded(
                                              child:  Text(
                                                "it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries it has survived only five countries",
                                                style:  TextStyle(fontSize: 11, fontWeight: FontWeight.w500
                                                    ,color: AppThemes.textGray
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          "facilities".toUpperCase(),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800
                                              ,color: AppThemes.blueColor
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        ListView.builder(
                                           shrinkWrap: true,
                                            itemCount: 6,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: const[
                                                          Icon(Icons.arrow_right_alt,size: 23,color: Colors.orange,),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Throw Ball",
                                                            style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w500
                                                                ,color: AppThemes.textGray
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: const[
                                                          Icon(Icons.arrow_right_alt,size: 23,color: Colors.orange,),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Horse Riding",
                                                            style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w500
                                                                ,color: AppThemes.textGray
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  )
                                                ],
                                              );
                                            },),
                                        const SizedBox(
                                          height: 35,
                                        ),
                                        Text(
                                          "features".toUpperCase(),
                                          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w800
                                              ,color: AppThemes.blueColor
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 11,
                                        ),
                                        ListView.builder(
                                           shrinkWrap: true,
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              return Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: const[
                                                          Icon(Icons.arrow_right_alt,size: 23,color: Colors.orange,),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Quizzes",
                                                            style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w500
                                                                ,color: AppThemes.textGray
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: const[
                                                          Icon(Icons.arrow_right_alt,size: 23,color: Colors.orange,),
                                                          SizedBox(
                                                            width: 10,
                                                          ),
                                                          Text(
                                                            "Debates",
                                                            style:  TextStyle(fontSize: 13, fontWeight: FontWeight.w500
                                                                ,color: AppThemes.textGray
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                    ],
                                                  )
                                                ],
                                              );
                                            },),

                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                                  child: GridView.builder(
                                    itemCount: 6,
                                      shrinkWrap: true,
                                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        mainAxisSpacing: 2,
                                        crossAxisSpacing: 10,
                                        mainAxisExtent: 160
                                      ),
                                      itemBuilder: (context, index) {
                                        return Column(
                                          mainAxisSize: MainAxisSize.max,
                                           children: [
                                             Column(
                                               children: [
                                                 ClipRRect(
                                                     borderRadius: BorderRadius.circular(10),
                                                     child: Image.asset(AppAssets.studentImg)),
                                                const Text('Rosie Martin',
                                                   style: TextStyle(
                                                       fontSize: 15,
                                                       fontWeight: FontWeight.w500
                                                   ),
                                                 ),
                                                 const Text('Class Xll - 92%',
                                                   style: TextStyle(
                                                       fontSize: 12,
                                                       fontWeight: FontWeight.w500,
                                                     color: Colors.grey
                                                   ),
                                                 ),
                                               ],
                                             )
                                           ],
                                        );
                                      },
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                                  child:  GridView.builder(
                                    itemCount: 5,
                                    shrinkWrap: true,
                                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 10,

                                    ),
                                    itemBuilder: (context, index) {
                                      return Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          ClipRRect(
                                              borderRadius: BorderRadius.circular(0),
                                              child: Image.asset(AppAssets.collageImg)),

                                        ],
                                      );
                                    },
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
      ),
      bottomNavigationBar: GestureDetector(
        onTap: (){
          Get.toNamed(MyRouters.registrationScreen);
        },
        child: Container(
          height: 44,
          color: AppThemes.primaryColor,
          child:  Center(
            child:  Text(
              "apply for admission".toUpperCase(),
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800,color: AppThemes.white),
            ),
          ),
        ),
      ),
    );
  }
}
