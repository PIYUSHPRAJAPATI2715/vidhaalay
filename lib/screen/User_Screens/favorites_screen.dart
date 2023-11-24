import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/User_Screens/schools_details_Screen.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> with TickerProviderStateMixin{

  late TabController tabController;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 4, vsync: this);

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
      backgroundColor: AppThemes.white,
      appBar: AppBar(
        backgroundColor: AppThemes.white,
        elevation: 0,
        centerTitle: true,
        leading:  IconButton(
          icon: Image.asset(AppAssets.arrowBack,width: 19,color: AppThemes.textBrown,),
          onPressed: (){
            Get.toNamed(MyRouters.bottomNavigationUserScreen);
            // Get.back();
          },
        ),
        title:  Text("Favorites",
          style: GoogleFonts.poppins(
              color: AppThemes.textBrown,
              fontSize: 17,
              fontWeight: FontWeight.w600
          ),),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (_, __) {
          return [
            SliverAppBar(
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                background:  Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        height: 36,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: AppThemes.textGray,
                                width: 0.5
                            ),
                            borderRadius: BorderRadius.circular(50)
                        ),
                        child: TabBar(
                          physics: const NeverScrollableScrollPhysics(),
                          tabs: const[
                            Tab(
                              child: Text(
                                "Schools",
                                textAlign: TextAlign.center,
                                style:TextStyle(
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
                            Tab(
                              child: Text(
                                "Videos",
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
                titlePadding: EdgeInsets.zero,
              ),
            )
          ];
        },
        body: TabBarView(
      physics: const BouncingScrollPhysics(),
      controller: tabController,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          child:  ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.to(() => const SchoolsDetailsScreen(), transition: Transition.fadeIn,duration: const Duration(
                      milliseconds: 250
                  ));
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
                                borderRadius: BorderRadius.circular(12) ,
                                child: Image.asset(
                                  AppAssets.collageImg,
                                  fit: BoxFit.cover,
                                  width: size.width,
                                  height: size.height*.16,
                                ),
                              ),
                              Positioned(
                                  right: 10, top: 10,
                                  child: GestureDetector(
                                      onTap: (){
                                        // Get.toNamed(MyRouters.favoritesScreen);
                                      },
                                      child: const Icon(Icons.favorite,size: 18,color: Colors.white))
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Washington University',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_pin,
                                      color: Colors.red,size: 18,),
                                    Text('4101,california',
                                      style: GoogleFonts.poppins(
                                          color: AppThemes.textGray,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          child:  ListView.builder(
            itemCount: 3,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: (){
                  Get.to(() => const SchoolsDetailsScreen(), transition: Transition.fadeIn,duration: const Duration(
                      milliseconds: 250
                  ));
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
                                borderRadius: BorderRadius.circular(12) ,
                                child: Image.asset(
                                  AppAssets.collageImg,
                                  fit: BoxFit.cover,
                                  width: size.width,
                                  height: size.height*.16,
                                ),
                              ),
                              Positioned(
                                  right: 10, top: 10,
                                  child: GestureDetector(
                                      onTap: (){
                                        // Get.toNamed(MyRouters.favoritesScreen);
                                      },
                                      child: const Icon(Icons.favorite,size: 18,color: Colors.white))
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Washington University',
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 17
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 2,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(Icons.location_pin,
                                      color: Colors.red,size: 18,),
                                    Text('4101,california',
                                      style: GoogleFonts.poppins(
                                          color: AppThemes.textGray,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          child:  ListView.builder(
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
                              borderRadius: BorderRadius.circular(12) ,
                              child: Image.asset(
                                AppAssets.collageImg,
                                fit: BoxFit.cover,
                                width: size.width,
                                height: size.height*.16,
                              ),
                            ),
                            const Positioned(
                                right: 10, top: 10,
                                child: Icon(Icons.favorite,size: 18,color: Colors.white)
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Washington University',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_pin,
                                    color: Colors.red,size: 18,),
                                  Text('4101,california',
                                    style: GoogleFonts.poppins(
                                        color: AppThemes.textGray,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
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
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 18),
          child:  ListView.builder(
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
                              borderRadius: BorderRadius.circular(12) ,
                              child: Image.asset(
                                AppAssets.collageImg,
                                fit: BoxFit.cover,
                                width: size.width,
                                height: size.height*.16,
                              ),
                            ),
                            const Positioned(
                                right: 10, top: 10,
                                child: Icon(Icons.favorite,size: 18,color: Colors.white)
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text('Washington University',
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 17
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(Icons.location_pin,
                                    color: Colors.red,size: 18,),
                                  Text('4101,california',
                                    style: GoogleFonts.poppins(
                                        color: AppThemes.textGray,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15
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
              );
            },
          ),
        ),
      ],
        )
      ),
    );
  }
}
