import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/get_notification_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/event_detail_controller.dart';
import 'package:vidhaalay_app/repositories/calendar_repo.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/teacher_flow/update_event_screen.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_dropdown.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class TeacherEventsScreen extends StatefulWidget {
  const TeacherEventsScreen({Key? key}) : super(key: key);

  @override
  State<TeacherEventsScreen> createState() => _TeacherEventsScreenState();
}

class _TeacherEventsScreenState extends State<TeacherEventsScreen> {

  final evenetDetailController = Get.put(EvenetDetailController());
  final ScrollController _dateController = ScrollController();
  final ScrollController _monthController = ScrollController();
  List currentSessionYear = CommonCalendar.currentSessionYear;
  List<String> months =  CommonCalendar.monthsList;
  List daysInMonth = [];

  RxString month = "".obs;
  RxString monthName = "".obs;
  RxString day = "".obs;


  @override
  void initState() {
    super.initState();
    evenetDetailController.getMyClass();

    evenetDetailController.selectedYear.value = int.parse(DateFormat('yyyy').format(DateTime.now()));
    month.value = DateFormat('MM').format(DateTime.now());
    monthName.value = DateFormat('MMMM').format(DateTime.now());
    day.value = DateFormat('dd').format(DateTime.now());
    selecedDate();


    evenetDetailController.selectedMonthIndex.value = selectCorrectMonthIndex(10);
    // evenetDetailController.selectedMonthIndex.value = selectCorrectMonthIndex(int.parse(month.value));
    print("selectedMonthIndex : ${evenetDetailController.selectedMonthIndex.value}");

    evenetDetailController.selectedYear.value = selectYearByMonth(month: month.value,);
    print("selectedYear : ${evenetDetailController.selectedYear.value}");

    daysInMonth =  getMonthDays(year: evenetDetailController.selectedYear.value,month: month.value);
    evenetDetailController.selectedIndex.value = int.parse(day.value) - 1;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (!mounted) return;
      setState(() {});
      _dateController.animateTo(
        evenetDetailController.selectedIndex.value * 45.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
      _monthController.animateTo(
        evenetDetailController.selectedMonthIndex.value * 65.0, // Adjust 110 according to your item size and spacing
        duration: Duration(milliseconds: 1800),
        curve: Curves.easeInOut,
      );
    });
  }
  
  selecedDate() {
    evenetDetailController.selectedDate.value = evenetDetailController.selectedYear.value.toString()+"-"+ month.value +"-"+ day.value;
    print("selecedDate : $evenetDetailController.selectedDate.value");
    evenetDetailController.getEventData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Calender',
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(
        () =>  Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    Colors.white,
                    AppThemes.primaryColor,
                    AppThemes.primaryColor,
                  ],
                  end: Alignment.centerRight,
                  begin: Alignment.centerLeft,
                  stops: [0, .5, .501, 1],
                ),
              ),
            ),
            Container(
                height: size.height*.280,
                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50)),
                ),
                child:  Padding(
                  padding: EdgeInsets.all(size.width * .010),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      evenetDetailController.classList.value.isEmpty
                          ? SizedBox.shrink()
                          : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Class -',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w500,
                                fontSize: 17,
                                color: Colors.white,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            CommonDropDownButton(
                              value: evenetDetailController
                                  .selectedClassId?.value,
                              items: evenetDetailController.classList.value
                                  .toList()
                                  .map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(
                                    items.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: evenetDetailController
                                          .selectedClassId?.value ==
                                          items.id
                                          ? Colors.white
                                          : Colors.black,
                                      // color: evenetDetailController.selectedClassId?.value == items.id
                                      //     ? Colors.black
                                      //     : Colors.black, // Default color for unselected items
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                // print(newValue);
                                evenetDetailController
                                    .selectedClassId!.value = newValue!;
                                print(evenetDetailController
                                    .selectedClassId?.value);
                                evenetDetailController.getEventData();
                               },
                              width: size.width * 0.3,
                              backgroundColor: AppThemes.themeBackgroundColor,
                            ),
                          ]),

                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          transformAlignment: Alignment.center,
                          // width: size.width * .45,
                          padding: EdgeInsets.symmetric(horizontal: 15,vertical: 5),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(currentSessionYear[0].toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: evenetDetailController.selectedYear.value == currentSessionYear[0] ? Colors.white : Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(' - ',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: Colors.white),
                                  textAlign: TextAlign.center,
                                ),
                                Text(currentSessionYear[1].toString(),
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 17,
                                      color: evenetDetailController.selectedYear.value == currentSessionYear[1] ? Colors.white : Colors.black
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      Container(
                        height: size.height*.050,
                        decoration: BoxDecoration(
                          // color: Colors.amber,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: ListView.builder(
                                controller: _monthController,
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: months.length,
                                itemBuilder:
                                    (BuildContext context, int index) {
                                  return InkWell(
                                    onTap: () {
                                      evenetDetailController.selectedMonthIndex.value = index;
                                      print(index);

                                      month.value = selectMonthByIndex(index).toString().padLeft(2, '0');
                                      print("Month");
                                      print(month.value);

                                      evenetDetailController.selectedYear.value = selectYearByMonth(month: month.value);
                                      print(evenetDetailController.selectedYear.value);

                                      daysInMonth = getMonthDays(year: evenetDetailController.selectedYear.value,month: month.value);
                                      if(daysInMonth.length <= int.parse(day.value) ) {
                                        day.value = 1.toString().padLeft(2, '0');
                                        evenetDetailController.selectedIndex.value = 0;
                                        _dateController.animateTo(
                                          evenetDetailController.selectedIndex.value * 1.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      } else {
                                        _dateController.animateTo(
                                          evenetDetailController.selectedIndex.value * 45.0,
                                          duration: Duration(milliseconds: 1800),
                                          curve: Curves.easeInOut,
                                        );
                                      }
                                      selecedDate();

                                      setState(() {
                                      });
                                      // evenetDetailController.selectedMonthIndex.value =
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Center(
                                        child: Text(months[index].toString(),
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17,
                                                color: index == evenetDetailController.selectedMonthIndex.value
                                                    ? Colors.white
                                                    : Colors.black
                                            )
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: size.height*.110,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: BouncingScrollPhysics(),
                          controller: _dateController,
                          child: Row(
                            children: List.generate(daysInMonth.length, (index) {

                              DateTime specifiedDate = DateTime(2024, int.parse(month.value), daysInMonth[index]);
                              String dayName = DateFormat('EEEE').format(specifiedDate).substring(0, 1);

                              return Padding(
                                padding: EdgeInsets.only(right: 0, left: 0),
                                child: GestureDetector(
                                  onTap: () {
                                    evenetDetailController.selectedIndex.value = index;
                                    day.value = (index + 1).toString().padLeft(2, '0');
                                    // print(evenetDetailController.selectedIndex.value);
                                    print(day.value);
                                    selecedDate();
                                    setState(() {

                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: index == evenetDetailController.selectedIndex.value
                                              ? Colors.white
                                              : Colors.transparent,
                                          borderRadius:
                                          BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Column(
                                          children: [
                                            Text(
                                              dayName.toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == evenetDetailController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                            Text(
                                              daysInMonth[index].toString(),
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color:
                                                  index == evenetDetailController.selectedIndex.value
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            Positioned.fill(
              top: size.height*.280,
              child: Container(
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                  ),
                  child: !evenetDetailController.isDataLoading.value ?
                    SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 18.0,vertical: 10),
                            child:Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('today'.toUpperCase(),
                                  style: GoogleFonts.poppins(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600
                                  ),),
                                GestureDetector(
                                  onTap: () {
                                    Get.toNamed(MyRouters.createEventScreen);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                    decoration: BoxDecoration(
                                        color:                   AppThemes.primaryColor,
                                        borderRadius: BorderRadius.circular(10)
                                    ),
                                    child: Row(
                                      children: [
                                        Text('add'.toUpperCase(),
                                          style: GoogleFonts.poppins(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600
                                          ),),
                                        Icon(
                                          Icons.add,
                                          size: 22,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          evenetDetailController.getEventModel.value.data!.isEmpty ?
                          Container(
                            height: size.height * .4,
                            // color: Colors.red,
                            child: Center(
                              child: Text("No event available"),
                            ),
                          )
                              : ListView.builder(
                            itemCount: evenetDetailController.getEventModel.value.data!.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              var items = evenetDetailController.getEventModel.value.data![index];
                              // DateTime dateTime = DateTime.parse(items.createdAt.toString());
                              // String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                              return Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                          Get.toNamed(MyRouters.celebrationScreenStu, arguments: items.id.toString());
                                      },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 18).copyWith(top: 10),
                                      color: const Color(0xffecffd2),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [

                                                Padding(
                                                  padding: const EdgeInsets.only(top: 2.0),
                                                  child: Image.asset(
                                                    AppAssets.greenInfo,
                                                    height: 14,
                                                    width: 14,
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  width: size.width * 0.68,
                                                  // color: Colors.amber,
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: size.width * 0.45,
                                                            // color: Colors.grey,
                                                            child: Text(
                                                              items.eventName.toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color:
                                                                  AppThemes.primaryColor,
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                  FontWeight.w500),
                                                              maxLines: 1,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ),
                                                          Container(
                                                            // color: Colors.green,
                                                            child: Text(
                                                              items.date.toString(),
                                                              // formattedDate.toString(),
                                                              style: GoogleFonts.poppins(
                                                                  color: Colors.grey,
                                                                  fontSize: 13,
                                                                  fontWeight: FontWeight.w400),
                                                            ),
                                                          ),
                                                        ],
                                                      ),

                                                      Text(
                                                        items.message.toString(),
                                                        style: GoogleFonts.poppins(
                                                            color: Colors.grey,
                                                            fontSize: 10,
                                                            fontWeight:
                                                            FontWeight.w500),
                                                        maxLines: 3,
                                                        overflow: TextOverflow.ellipsis,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  child: IconButton(
                                                      onPressed: (){
                                                        // Get.to(() => UpdateEventScreen(eventDetails: items.id.toString()));
                                                        Get.to(() => UpdateEventScreen(eventId: items.id.toString()));
                                                        // Get.toNamed(MyRouters.celebrationScreenStu, arguments: items.id.toString());
                                                      },
                                                      icon: const Icon(Icons.edit,size: 19,)),
                                                ),
                                                Expanded(
                                                  child: IconButton(onPressed: (){
                                                      evenetDetailController.deleteEventAPI(context, items.id!);
                                                  },
                                                      icon: const Icon(Icons.delete,color: Colors.red,size: 19,)),
                                                )
                                              ],
                                            ),
                                          ),


                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            },
                          )
                        ],
                      ),
                    ): const CommonProgressIndicator()
              ),
            ),

            /* */
            // Positioned.fill(
            //   top: size.height*.250,
            //   child: Container(
            //     padding: const EdgeInsets.symmetric(vertical: 25,horizontal: 12).copyWith(bottom: 0),
            //     height: size.height,
            //     width: size.width,
            //     decoration: const BoxDecoration(
            //       color: AppThemes.white,
            //       borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
            //     ),
            //     child: SingleChildScrollView(
            //       physics: NeverScrollableScrollPhysics(),
            //       child: Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text('today'.toUpperCase(),
            //             style: GoogleFonts.poppins(
            //                 color: Colors.black,
            //                 fontSize: 19,
            //                 fontWeight: FontWeight.w600
            //             ),),
            //           SizedBox(
            //             height: size.height,
            //             child: ListView.builder(
            //               shrinkWrap: true,
            //               itemCount: 5,
            //               physics: const BouncingScrollPhysics(),
            //               itemBuilder: (context, index) {
            //                 return InkWell(
            //                   onTap: (){
            //                     Get.toNamed(MyRouters.celebrationScreenStu);
            //                   },
            //                   child: Column(
            //                     crossAxisAlignment: CrossAxisAlignment.start,
            //                     mainAxisAlignment: MainAxisAlignment.start,
            //                     children: [
            //                       const SizedBox(
            //                         height: 22,
            //                       ),
            //                       Row(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                         children: [
            //
            //                           Expanded(
            //                             child: Row(
            //                               crossAxisAlignment: CrossAxisAlignment.start,
            //                               mainAxisAlignment: MainAxisAlignment.start,
            //                               children: [
            //                                 Image.asset(AppAssets.greenInfo,height: 15,),
            //                                 const SizedBox(
            //                                   width: 8,
            //                                 ),
            //                                 Expanded(
            //                                   child: Column(
            //                                     crossAxisAlignment: CrossAxisAlignment.start,
            //                                     children: [
            //                                       Text('Holi Celebration',
            //                                         style: GoogleFonts.poppins(
            //                                             color: AppThemes.blueColor,
            //                                             fontSize: 14,
            //                                             fontWeight: FontWeight.w600
            //                                         ),),
            //                                       const SizedBox(
            //                                         height: 5,
            //                                       ),
            //                                       const Text('It has survived not only five centuries, but alse the leep into electronic typesetting remaining essentially unchanged. It was popularised in the',
            //                                         style: TextStyle(
            //                                           color: AppThemes.blueColor,
            //                                           fontSize: 9,
            //                                           fontWeight: FontWeight.w300,
            //                                         ),
            //                                         overflow: TextOverflow.ellipsis,
            //                                         maxLines: 4,
            //                                       ),
            //                                     ],
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                           Text(
            //                             '12:00',
            //                             style: GoogleFonts.poppins(
            //                                 color: Colors.grey,
            //                                 fontSize: 12.0,
            //                                 fontWeight: FontWeight.w500
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
