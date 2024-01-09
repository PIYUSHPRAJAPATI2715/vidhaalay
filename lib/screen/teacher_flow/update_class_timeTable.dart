import 'dart:ffi';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/create_class_timetable_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/update_class_timetable_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';


class UpdateClassTimeTableScreen extends StatefulWidget {
  final String id;

  const UpdateClassTimeTableScreen({super.key, required this.id});

  // const UpdateClassTimeTableScreen({Key? key}) : super(key: key);

  @override
  State<UpdateClassTimeTableScreen> createState() => _UpdateClassTimeTableScreenState();
}

class _UpdateClassTimeTableScreenState extends State<UpdateClassTimeTableScreen> {

  final updateClassTimeTableController = Get.put(UpdateClassTimeTableController());
  final formKey = GlobalKey<FormState>();

  String selectedPeriod = 'AM';
  var selectedPeriodData = [
    'AM',
    'PM',
  ];

  String selectedPeriod1 = 'AM';
  var selectedPeriod1Data = [
    'AM',
    'PM',
  ];



  @override
  void initState() {
    updateClassTimeTableController.getTimeTableDetailsData(id: widget.id);

    updateClassTimeTableController.getMyClass();
    updateClassTimeTableController.getTeacherListData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('vidhaalay'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.primaryColor,
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(MyRouters.myProfileTeacher);
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      AppAssets.studentImg,
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      body: Obx(
            () =>  updateClassTimeTableController.isDetailsLoading.value ?  Center(child: const CommonProgressIndicator())
                : Stack(
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
              // height: 155,
                height: size.height*.230,

                decoration: const BoxDecoration(
                  color: AppThemes.primaryColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(70)),
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text('Update Timetable',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 7,
                    ),

                    updateClassTimeTableController.classList.value.isEmpty ? SizedBox.shrink() :  Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Class - ',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.poppins(
                              fontSize: 19,
                              fontWeight: FontWeight.w600,
                              color: AppThemes.white,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                              value:  updateClassTimeTableController.selectedClassId?.value,
                              // style: TextStyle(
                              //     color: Colors.green,
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w300),
                              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                              dropdownColor: Colors.white70,
                              items: updateClassTimeTableController.classList.value.toList().map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(items.name,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: updateClassTimeTableController.selectedClassId?.value == items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors.black, // Default color for unselected items
                                  ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                updateClassTimeTableController.selectedClassId!.value = newValue!;
                                print(updateClassTimeTableController.selectedClassId?.value);

                                // updateClassTimeTableController.getTimeTableData(classId: updateClassTimeTableController.selectedClassId.value);
                              },
                            ),
                          )
                        ]
                    )

                  ],
                )
            ),

            Positioned.fill(
              // top: size.height*.204,
              top: size.height*.230,

              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 15).copyWith(bottom: 0),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Period 1',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppThemes.blueColor,
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        SizedBox(
                          child: ListView.builder(
                            itemCount: 1,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 5 ),
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const[
                                            BoxShadow(
                                              color: Colors.grey,
                                              blurRadius: 1,
                                              spreadRadius: 0,
                                              offset: Offset(0, 1),
                                            ),
                                          ]
                                      ),
                                      child: Form(
                                        key: formKey,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Subject',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppThemes.blueColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),

                                            // DropdownButtonFormField<String>(
                                            //   value: selectSubject,
                                            //   items: selectSubjectData.toList()
                                            //       .map((item) => DropdownMenuItem(
                                            //     value: item,
                                            //     child: Text(item),
                                            //
                                            //   ))
                                            //       .toList(),
                                            //   onChanged: (value) {
                                            //     setState(() {
                                            //       selectSubject = value!;
                                            //     });
                                            //   },
                                            //   style: TextStyle(
                                            //     color: Colors.grey,
                                            //     fontSize: 15,
                                            //   ),
                                            //   menuMaxHeight: size.height * 0.25,
                                            //   borderRadius: BorderRadius.circular(10),
                                            //   decoration: InputDecoration(
                                            //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            //     hintText: 'Select Subject',
                                            //     hintStyle: const TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: 15,
                                            //     ),
                                            //     errorBorder: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.circular(50),
                                            //       borderSide: BorderSide(
                                            //           color: Colors.red,
                                            //           width: 1
                                            //       ),
                                            //     ),
                                            //     focusedErrorBorder: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.circular(50),
                                            //       borderSide: BorderSide(
                                            //           color: Colors.red,
                                            //           width: 1
                                            //       ),
                                            //     ),
                                            //     enabledBorder: OutlineInputBorder(
                                            //         borderRadius: BorderRadius.circular(50),
                                            //         borderSide: BorderSide(
                                            //             color: Colors.grey!.withOpacity(0.5),
                                            //             width: 1
                                            //         )
                                            //     ),
                                            //
                                            //     focusedBorder: OutlineInputBorder(
                                            //         borderRadius: BorderRadius.circular(50),
                                            //         borderSide: BorderSide(
                                            //             color: Colors.grey!.withOpacity(0.5),
                                            //             width: 1
                                            //         )
                                            //     ),
                                            //   ),
                                            //   validator: (value) {
                                            //     if (value == null || value.isEmpty) {
                                            //       return 'Please select Subject';
                                            //     }
                                            //     return null;
                                            //   },
                                            //   // validator: MultiValidator([
                                            //   //   RequiredValidator(errorText: 'Please select an item'),
                                            //   // ]),
                                            // ),
                                            Obx(
                                                  () => updateClassTimeTableController.isSubjectLoading.value ?
                                              SizedBox.shrink()
                                                  :
                                              DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField2<String>(
                                                  isExpanded: true,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                    hintText: 'Select Subject',
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1
                                                      ),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!.withOpacity(0.5),
                                                            width: 1
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!.withOpacity(0.5),
                                                            width: 1
                                                        )
                                                    ),
                                                  ),
                                                  items: updateClassTimeTableController.getSubjectListModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateClassTimeTableController.selectedSubject,
                                                  validator: (value) {
                                                    print("validator :  $value");
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please select subject';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    // setState(() {
                                                    updateClassTimeTableController.selectedSubject = value;
                                                    print(updateClassTimeTableController.selectedSubject);
                                                    // });
                                                  },
                                                  dropdownStyleData: DropdownStyleData(
                                                    maxHeight: size.height * 0.28,
                                                    width: size.width * 0.84,
                                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                                    isOverButton: false,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(14),
                                                      color: Colors.white,
                                                    ),
                                                    offset: const Offset(0, -10),
                                                    scrollbarTheme: ScrollbarThemeData(
                                                      radius: const Radius.circular(40),
                                                      thickness: MaterialStateProperty.all<double>(6),
                                                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData: const MenuItemStyleData(
                                                    height: 45,
                                                    padding: EdgeInsets.only(left: 10, right: 10),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            // Container(
                                            //   height: 50,
                                            //   width: Get.width,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(25),
                                            //   ),
                                            //   child: DropdownButtonFormField(
                                            //     focusColor: Colors.grey.shade50,
                                            //     isExpanded: true,
                                            //     iconEnabledColor: const Color(0xff97949A),
                                            //     icon: const Icon(Icons.keyboard_arrow_down),
                                            //     hint: Text(
                                            //       selectClass,
                                            //       style: const TextStyle(
                                            //           color: Color(0xff463B57),
                                            //           fontSize: 16,
                                            //           fontWeight: FontWeight.w300),
                                            //       textAlign: TextAlign.justify,
                                            //     ),
                                            //     decoration: InputDecoration(
                                            //         fillColor: Colors.grey.shade50,
                                            //         contentPadding: const EdgeInsets.symmetric(
                                            //             horizontal: 20, vertical: 10),
                                            //         focusedBorder: OutlineInputBorder(
                                            //           borderSide:
                                            //           BorderSide(color: Colors.grey.shade300),
                                            //           borderRadius: BorderRadius.circular(25.0),
                                            //         ),
                                            //         enabledBorder: const OutlineInputBorder(
                                            //             borderSide:
                                            //             BorderSide(color: Color(0xffE3E3E3)),
                                            //             borderRadius: BorderRadius.all(
                                            //                 Radius.circular(25.0)))),
                                            //     value: selectClass,
                                            //     items: selectSubjectData.map((String items) {
                                            //       return DropdownMenuItem(
                                            //         value: items,
                                            //         child: Text(
                                            //           items,
                                            //           style: const TextStyle(
                                            //               color: Colors.grey, fontSize: 14),
                                            //         ),
                                            //       );
                                            //     }).toList(),
                                            //     onChanged: (String? newValue) {
                                            //       setState(() {
                                            //         selectClass = newValue!;
                                            //       });
                                            //     },
                                            //   ),
                                            // ),
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            const Text(
                                              'Weekday',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppThemes.blueColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            // DropdownButtonFormField<String>(
                                            //   value: weekday,
                                            //   items: weekdayData.toList()
                                            //       .map((item) => DropdownMenuItem(
                                            //     value: item,
                                            //     child: Text(item),
                                            //   ))
                                            //       .toList(),
                                            //   onChanged: (value) {
                                            //     setState(() {
                                            //       weekday = value!;
                                            //     });
                                            //   },
                                            //   menuMaxHeight: size.height * 0.25,
                                            //   borderRadius: BorderRadius.circular(10),
                                            //   style: TextStyle(
                                            //     color: Colors.grey,
                                            //     fontSize: 15,
                                            //   ),
                                            //   decoration: InputDecoration(
                                            //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                            //     hintText: 'Select weekday',
                                            //     hintStyle: const TextStyle(
                                            //       color: Colors.grey,
                                            //       fontSize: 15,
                                            //     ),
                                            //     errorBorder: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.circular(50),
                                            //       borderSide: BorderSide(
                                            //           color: Colors.red,
                                            //           width: 1
                                            //       ),
                                            //     ),
                                            //     focusedErrorBorder: OutlineInputBorder(
                                            //       borderRadius: BorderRadius.circular(50),
                                            //       borderSide: BorderSide(
                                            //           color: Colors.red,
                                            //           width: 1
                                            //       ),
                                            //     ),
                                            //     enabledBorder: OutlineInputBorder(
                                            //         borderRadius: BorderRadius.circular(50),
                                            //         borderSide: BorderSide(
                                            //             color: Colors.grey!.withOpacity(0.5),
                                            //             width: 1
                                            //         )
                                            //     ),
                                            //
                                            //     focusedBorder: OutlineInputBorder(
                                            //         borderRadius: BorderRadius.circular(50),
                                            //         borderSide: BorderSide(
                                            //             color: Colors.grey!.withOpacity(0.5),
                                            //             width: 1
                                            //         )
                                            //     ),
                                            //   ),
                                            //   validator: (value) {
                                            //     if (value == null || value.isEmpty) {
                                            //       return 'Please select weekday';
                                            //     }
                                            //     return null;
                                            //   },
                                            //   // validator: MultiValidator([
                                            //   //   RequiredValidator(errorText: 'Please select an item'),
                                            //   // ]),
                                            // ),
                                            DropdownButtonHideUnderline(
                                              child: DropdownButtonFormField2<String>(
                                                isExpanded: true,
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 15,
                                                ),
                                                decoration: InputDecoration(
                                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                  hintText: 'Select Weekday',
                                                  hintStyle: const TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                  errorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(50),
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1
                                                    ),
                                                  ),
                                                  focusedErrorBorder: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(50),
                                                    borderSide: BorderSide(
                                                        color: Colors.red,
                                                        width: 1
                                                    ),
                                                  ),
                                                  enabledBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey!.withOpacity(0.5),
                                                          width: 1
                                                      )
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.grey!.withOpacity(0.5),
                                                          width: 1
                                                      )
                                                  ),
                                                ),
                                                value: updateClassTimeTableController.selectedWeekday,
                                                items: updateClassTimeTableController.weekdayData.value.toList()
                                                    .map((item) => DropdownMenuItem(
                                                  value: item,
                                                  child: Text(item),
                                                ))
                                                    .toList(),
                                                validator: (value) {
                                                  print("validator :  $value");
                                                  if (value == null || value.isEmpty) {
                                                    return 'Please select weekday';
                                                  } else {
                                                    return null;
                                                  }
                                                },
                                                onChanged: (value) {
                                                  setState(() {
                                                    print(value);
                                                    updateClassTimeTableController.selectedWeekday = value;
                                                  });
                                                },
                                                dropdownStyleData: DropdownStyleData(
                                                  maxHeight: size.height * 0.28,
                                                  width: size.width * 0.84,
                                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                                  isOverButton: false,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(14),
                                                    color: Colors.white,
                                                  ),
                                                  offset: const Offset(0, -10),
                                                  scrollbarTheme: ScrollbarThemeData(
                                                    radius: const Radius.circular(40),
                                                    thickness: MaterialStateProperty.all<double>(6),
                                                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                  ),
                                                ),
                                                menuItemStyleData: const MenuItemStyleData(
                                                  height: 45,
                                                  padding: EdgeInsets.only(left: 10, right: 10),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 18,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.39,
                                                  child: Text(
                                                    'From',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: AppThemes.blueColor,
                                                    ),
                                                  ),
                                                ),

                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  child: Text(
                                                    'To',
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 15,
                                                      color: AppThemes.blueColor,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  child: CommonTextfield(
                                                    hintText: '00:00:00',
                                                    obSecure: false,
                                                    readOnly: true,
                                                    keyboardType: TextInputType.number,
                                                    controller: updateClassTimeTableController.fromTime,
                                                    validator: (value){
                                                      if(value!.isEmpty) {
                                                        return "please pick a time";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
                                                    onTap: () {
                                                      selectTime(isFromTime: true);
                                                    },
                                                  ),
                                                ),
                                                // const SizedBox(
                                                //   width: 8,
                                                // ),
                                                SizedBox(
                                                  width: size.width * 0.4,
                                                  child: CommonTextfield(
                                                    hintText: '00:00:00',
                                                    obSecure: false,
                                                    readOnly: true,
                                                    keyboardType: TextInputType.number,
                                                    controller: updateClassTimeTableController.toTime,
                                                    validator: (value){
                                                      if(value!.isEmpty){
                                                        return "please pick a time";
                                                      } else{
                                                        return null;
                                                      }
                                                    },
                                                    onTap: () {
                                                      selectTime(isFromTime: false);
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ),
                                            /* Previous hours time desi*/
                                            // Row(
                                            //   children: <Widget>[
                                            //     Expanded(
                                            //       child: CommonTextfield(
                                            //         controller: updateClassTimeTableController.fromTime,
                                            //         obSecure: false,
                                            //         readOnly: true,
                                            //         hintText: '0:0',
                                            //         keyboardType: TextInputType.number,
                                            //         onTap: () {
                                            //           selectTime();
                                            //         },
                                            //         suffixIcon: Column(
                                            //           children: [
                                            //             SizedBox(
                                            //               height: 50,
                                            //               width: 90,
                                            //               child: DropdownButtonFormField(
                                            //                 focusColor: Colors.grey.shade50,
                                            //                 isExpanded: true,
                                            //                 iconEnabledColor: const Color(0xff97949A),
                                            //                 icon: const Icon(Icons.keyboard_arrow_down),
                                            //                 hint: Text(
                                            //                   selectedPeriod,
                                            //                   style: const TextStyle(
                                            //                       color: Color(0xff463B57),
                                            //                       fontSize: 16,
                                            //                       fontWeight: FontWeight.w300),
                                            //                   textAlign: TextAlign.justify,
                                            //                 ),
                                            //                 decoration: InputDecoration(
                                            //                     fillColor: Colors.grey.shade50,
                                            //                     contentPadding: const EdgeInsets.symmetric(
                                            //                         horizontal: 20, vertical: 13),
                                            //                     focusedBorder: OutlineInputBorder(
                                            //                       borderSide:
                                            //                       BorderSide(color: Colors.grey.shade300),
                                            //                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                            //                     ),
                                            //                     enabledBorder: const OutlineInputBorder(
                                            //                         borderSide:
                                            //                         BorderSide(color: Color(0xffE3E3E3)),
                                            //                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)))),
                                            //                 value: selectedPeriod,
                                            //                 items: selectedPeriodData.map((String items) {
                                            //                   return DropdownMenuItem(
                                            //                     value: items,
                                            //                     child: Text(
                                            //                       items,
                                            //                       style: const TextStyle(
                                            //                           color: Colors.grey, fontSize: 14),
                                            //                     ),
                                            //                   );
                                            //                 }).toList(),
                                            //                 onChanged: (String? newValue) {
                                            //                   setState(() {
                                            //                     selectedPeriod = newValue!;
                                            //                   });
                                            //                 },
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //     const SizedBox(
                                            //       width: 8,
                                            //     ),
                                            //     Expanded(
                                            //       child: CommonTextfield(
                                            //         obSecure: false,
                                            //         hintText: '0:0',
                                            //         keyboardType: TextInputType.number,
                                            //         suffixIcon: Column(
                                            //           children: [
                                            //             SizedBox(
                                            //               height: 50,
                                            //               width: 90,
                                            //               child: DropdownButtonFormField(
                                            //                 focusColor: Colors.grey.shade50,
                                            //                 isExpanded: true,
                                            //                 iconEnabledColor: const Color(0xff97949A),
                                            //                 icon: const Icon(Icons.keyboard_arrow_down),
                                            //                 hint: Text(
                                            //                   selectedPeriod1,
                                            //                   style: const TextStyle(
                                            //                       color: Color(0xff463B57),
                                            //                       fontSize: 16,
                                            //                       fontWeight: FontWeight.w300),
                                            //                   textAlign: TextAlign.justify,
                                            //                 ),
                                            //                 decoration: InputDecoration(
                                            //                     fillColor: Colors.grey.shade50,
                                            //                     contentPadding: const EdgeInsets.symmetric(
                                            //                         horizontal: 20, vertical: 13),
                                            //                     focusedBorder: OutlineInputBorder(
                                            //                       borderSide:
                                            //                       BorderSide(color: Colors.grey.shade300),
                                            //                       borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                            //                     ),
                                            //                     enabledBorder: const OutlineInputBorder(
                                            //                         borderSide:
                                            //                         BorderSide(color: Color(0xffE3E3E3)),
                                            //                         borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)))),
                                            //                 value: selectedPeriod1,
                                            //                 items: selectedPeriod1Data.map((String items) {
                                            //                   return DropdownMenuItem(
                                            //                     value: items,
                                            //                     child: Text(
                                            //                       items,
                                            //                       style: const TextStyle(
                                            //                           color: Colors.grey, fontSize: 14),
                                            //                     ),
                                            //                   );
                                            //                 }).toList(),
                                            //                 onChanged: (String? newValue) {
                                            //                   setState(() {
                                            //                     selectedPeriod1 = newValue!;
                                            //                   });
                                            //                 },
                                            //               ),
                                            //             ),
                                            //           ],
                                            //         ),
                                            //       ),
                                            //     ),
                                            //
                                            //   ],
                                            // ),
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            const Text(
                                              'Teacher',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppThemes.blueColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            // Container(
                                            //   height: 50,
                                            //   width: Get.width,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(25),
                                            //   ),
                                            //   child: DropdownButtonFormField(
                                            //     focusColor: Colors.grey.shade50,
                                            //     isExpanded: true,
                                            //     iconEnabledColor: const Color(0xff97949A),
                                            //     icon: const Icon(Icons.keyboard_arrow_down),
                                            //     hint: Text(
                                            //       teacher,
                                            //       style: const TextStyle(
                                            //           color: Color(0xff463B57),
                                            //           fontSize: 16,
                                            //           fontWeight: FontWeight.w300),
                                            //       textAlign: TextAlign.justify,
                                            //     ),
                                            //     decoration: InputDecoration(
                                            //         fillColor: Colors.grey.shade50,
                                            //         contentPadding: const EdgeInsets.symmetric(
                                            //             horizontal: 20, vertical: 10),
                                            //         focusedBorder: OutlineInputBorder(
                                            //           borderSide:
                                            //           BorderSide(color: Colors.grey.shade300),
                                            //           borderRadius: BorderRadius.circular(25.0),
                                            //         ),
                                            //         enabledBorder: const OutlineInputBorder(
                                            //             borderSide:
                                            //             BorderSide(color: Color(0xffE3E3E3)),
                                            //             borderRadius: BorderRadius.all(
                                            //                 Radius.circular(25.0)))),
                                            //     value: teacher,
                                            //     items: teacherData.map((String items) {
                                            //       return DropdownMenuItem(
                                            //         value: items,
                                            //         child: Text(
                                            //           items,
                                            //           style: const TextStyle(
                                            //               color: Colors.grey, fontSize: 14),
                                            //         ),
                                            //       );
                                            //     }).toList(),
                                            //     onChanged: (String? newValue) {
                                            //       setState(() {
                                            //         teacher = newValue!;
                                            //       });
                                            //     },
                                            //   ),
                                            // ),
                                            Obx(
                                                  () => updateClassTimeTableController.isTeacherLoading.value ?
                                              SizedBox.shrink()
                                                  : DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField2<String>(
                                                  isExpanded: true,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                  decoration: InputDecoration(
                                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                                    hintText: 'Select Teacher',
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                    ),
                                                    errorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1
                                                      ),
                                                    ),
                                                    focusedErrorBorder: OutlineInputBorder(
                                                      borderRadius: BorderRadius.circular(50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1
                                                      ),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!.withOpacity(0.5),
                                                            width: 1
                                                        )
                                                    ),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!.withOpacity(0.5),
                                                            width: 1
                                                        )
                                                    ),
                                                  ),
                                                  items: updateClassTimeTableController.getTeacherListModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateClassTimeTableController.selectedTeacher,
                                                  validator: (value) {
                                                    print("validator :  $value");
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please select teacher';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    updateClassTimeTableController.selectedTeacher = value;
                                                    print(updateClassTimeTableController.selectedTeacher);
                                                  },
                                                  dropdownStyleData: DropdownStyleData(
                                                    maxHeight: size.height * 0.28,
                                                    width: size.width * 0.84,
                                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                                    isOverButton: false,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(14),
                                                      color: Colors.white,
                                                    ),
                                                    offset: const Offset(0, -10),
                                                    scrollbarTheme: ScrollbarThemeData(
                                                      radius: const Radius.circular(40),
                                                      thickness: MaterialStateProperty.all<double>(6),
                                                      thumbVisibility: MaterialStateProperty.all<bool>(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData: const MenuItemStyleData(
                                                    height: 45,
                                                    padding: EdgeInsets.only(left: 10, right: 10),
                                                  ),
                                                ),
                                              ),
                                            ),

                                            const SizedBox(
                                              height: 18,
                                            ),
                                          ],
                                        ),
                                      )
                                  ),
                                  const SizedBox(
                                    height: 30,
                                  )
                                ],
                              );
                            },
                          ),
                        ),
                        // const SizedBox(
                        //   height: 15,
                        // ),
                        // Row(
                        //   crossAxisAlignment: CrossAxisAlignment.center,
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Image.asset(AppAssets.addMore,height: 24,),
                        //     const SizedBox(
                        //       width: 8,
                        //     ),
                        //     const Text(
                        //       'Add More',
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.w500,
                        //         fontSize: 15,
                        //         color: AppThemes.primaryColor,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        // const SizedBox(
                        //   height: 25,
                        // ),
                      ],
                    )
                ),
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar:  SizedBox(
        width: size.width,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: size.width,
              height: 40,
              color: AppThemes.primaryColor,
              child: InkWell(
                onTap: (){
                  if(formKey.currentState!.validate()) {
                    updateClassTimeTableController.updateClassTimetableAPI(context: context,id: widget.id);
                    // Get.toNamed(MyRouters.teacherClassTimeScreen);
                  }
                },
                child:  const Center(
                  child:  Text(
                    'UPDATE',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void selectTime({required bool isFromTime}) async {

    var timee = TimeOfDay.now();
    // final timee = DateTime.now();

    final TimeOfDay? newTime = await showTimePicker(
      context: context,
      initialTime: timee,
      // builder: (BuildContext context, Widget? child) {
      //   return Theme(
      //     data: ThemeData.light().copyWith(
      //       backgroundColor: Colors.pink, // Set the background color
      //       cardColor: Colors.white,
      //       // colorScheme: Colors.white,
      //       canvasColor: Colors.white,
      //       highlightColor: Colors.blue
      //     ),
      //     child: child!,
      //   );
      // },
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            alwaysUse24HourFormat: false, // This will hide AM/PM
          ),
          child: child!,
        );
      },
    );
    if (newTime != null) {
      int selectedHour = newTime.hour; // Selected hour (0-23)
      int selectedMinute = newTime.minute;
      String formattedHour = selectedHour.toString().padLeft(2, '0');
      String formattedMinute = selectedMinute.toString().padLeft(2, '0');
      String selectedTime = '$formattedHour:$formattedMinute:00';

      String period = newTime.period == DayPeriod.am ? 'AM' : 'PM';
      print('Selected time: $selectedTime');

      if(isFromTime) {
        updateClassTimeTableController.fromTime.text = selectedTime;
      } else {
        updateClassTimeTableController.toTime.text = selectedTime;
      }
    }
  }

}
