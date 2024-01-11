import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';

import '../../resourses/app_assets.dart';
import '../../widgets/appTheme.dart';



class CelebrationScreenStu extends StatefulWidget {
  // final String id;
  // const CelebrationScreenStu({super.key, required this.id});

  const CelebrationScreenStu({Key? key}) : super(key: key);

  @override
  State<CelebrationScreenStu> createState() => _CelebrationScreenStuState();
}

class _CelebrationScreenStuState extends State<CelebrationScreenStu> {

  final evenetDetailController = Get.put(EvenetDetailController());
  String id = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = Get.arguments;
    print(id);
    evenetDetailController.getEventDetailsData(id: id);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Holi Celebration',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){
            Get.back();
          },
          icon: Image.asset(AppAssets.arrowBack,width: 25,height: 25,),
        ),
        actions: [
          IconButton(
              onPressed: () async{
                 await Share.share('Holi Celebration');
              },
              icon: const Icon( Icons.share,color: Colors.black,)
          )
        ],
      ),

      body: Obx(
        () => evenetDetailController.isDetailsLoading.value ?  SizedBox(
            height: size.height,
            width: size.width,
            child: Center(child: const CommonProgressIndicator())
        ) : SafeArea(
          child: Stack(
            children: [
              Container(
                  height: size.height,
                  color: Colors.white,
              ),
              ClipRRect(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(0)),
                  child: Image.asset(AppAssets.holiImg,)
              ),

              Positioned.fill(
                top: size.height*.260,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppThemes.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(40),topLeft: Radius.circular(0)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child:  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        Text(
                          evenetDetailController.getEventDetailsModel.value.data!.eventName!.toString(),
                          // "Holi Celebration",
                          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
          
                            ClipOval(
                              child: Image.asset(
                                AppAssets.studentImg,
                                width: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'By :',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              'Rosie David',
                              style:  GoogleFonts.poppins(
                                  color: Colors.orange,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
          
                            ClipOval(
                              child: Image.asset(
                                AppAssets.watchIcon,
                                width: 13,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '8.00 AM ',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                            Text(
                              '3.00 PM',
                              style:  GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
          
                            ClipOval(
                              child: Image.asset(
                                AppAssets.location,
                                width: 13,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              '4101 Parkway Street, St. Louis., California',
                              style: GoogleFonts.poppins(
                                  color: Colors.grey,
                                  fontSize: 13.0,
                                  fontWeight: FontWeight.w500
                              ),
                            ),
          
                          ],
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Text(
                          evenetDetailController.getEventDetailsModel.value.data!.message!.toString(),
                          // 'It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          height: 19,
                        ),
                        const Text(
                          "Activities",
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          '* It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '* It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          '* It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.',
                          style: GoogleFonts.poppins(
                              color: Colors.grey,
                              fontSize: 13.0,
                              fontWeight: FontWeight.w500
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
      ),
    );
  }
}
