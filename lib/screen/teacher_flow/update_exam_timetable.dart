import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/update_exam_timetable_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class UpdateExamTimeTable extends StatefulWidget {
  final String id;

  const UpdateExamTimeTable({super.key, required this.id});

  // const UpdateExamTimeTable({Key? key}) : super(key: key);

  @override
  State<UpdateExamTimeTable> createState() => _UpdateExamTimeTableState();
}

class _UpdateExamTimeTableState extends State<UpdateExamTimeTable> {
  final updateExamTimeTableController = Get.put(UpdateExamTimeTableController());
  final formKey = GlobalKey<FormState>();

  // String selectClass = 'Select Subject';
  // var selectClassData = [
  //   'Select Subject',
  //   'Science', 'Sst', 'English', 'Hindi',
  //   'Math', 'Computer',
  // ];
  // String weekday = 'Select Class';
  // var weekdayData = [
  //   'Select Class',
  //   '8th', '9th', '10th',
  // ];
  // String teacher = 'Select teacher';
  // var teacherData = [
  //   'Select teacher',
  //   'Monika', 'Sumit', 'Ram',
  // ];
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
    updateExamTimeTableController.getTimeTableDetailsData(id: widget.id);

    updateExamTimeTableController.getMyClass();
    updateExamTimeTableController.getExamTypeData();
    updateExamTimeTableController.getTeacherListData();
    updateExamTimeTableController.getClassListData();
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
            () => updateExamTimeTableController.isDetailsLoading.value ?  Center(child: const CommonProgressIndicator()) :  Stack(
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
                          child: Text('Exam Timetable',
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

                    updateExamTimeTableController.classList.value.isEmpty ? SizedBox.shrink() :  Row(
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
                              value:  updateExamTimeTableController.selectedClassId?.value,
                              // style: TextStyle(
                              //     color: Colors.green,
                              //     fontSize: 12,
                              //     fontWeight: FontWeight.w300),
                              icon: Icon(Icons.keyboard_arrow_down,color: Colors.white),
                              dropdownColor: Colors.white70,
                              items: updateExamTimeTableController.classList.value.toList().map((items) {
                                return DropdownMenuItem(
                                  value: items.id,
                                  child: Text(items.name,style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 17,
                                    color: updateExamTimeTableController.selectedClassId?.value == items.id
                                        ? Colors.white
                                    // Colors.grey.shade900 // Change the color for selected item
                                        : Colors.black, // Default color for unselected items
                                  ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (newValue) {
                                updateExamTimeTableController.selectedClassId!.value = newValue!;
                                updateExamTimeTableController.getSubjectListData(classId: updateExamTimeTableController.selectedClassId.value.toString());

                                print(updateExamTimeTableController.selectedClassId?.value);
                                // updateExamTimeTableController.getTimeTableData(classId: updateExamTimeTableController.selectedClassId.value);
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
                          'Exam 1',
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
                                              'Type',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppThemes.blueColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            Obx(
                                                  () => updateExamTimeTableController.isExamTypeLoading.value ?
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
                                                    hintText: 'Select Type',
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
                                                  items: updateExamTimeTableController.getExamTypeModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateExamTimeTableController.selectedExamType,
                                                  validator: (value) {
                                                    print("validator :  $value");
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please select type';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    // setState(() {
                                                    updateExamTimeTableController.selectedExamType = value;
                                                    print(updateExamTimeTableController.selectedExamType);
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
                                            const SizedBox(
                                              height: 18,
                                            ),
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
                                            Obx(
                                                  () => updateExamTimeTableController.isSubjectLoading.value ?
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
                                                  items: updateExamTimeTableController.getSubjectListModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateExamTimeTableController.selectedSubject,
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
                                                    updateExamTimeTableController.selectedSubject = value;
                                                    print(updateExamTimeTableController.selectedSubject);
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
                                            const SizedBox(
                                              height: 18,
                                            ),
                                            const Text(
                                              'Date',
                                              style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 15,
                                                color: AppThemes.blueColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            CommonTextfield(
                                                hintText: 'Add Date',
                                                obSecure: false,
                                                readOnly: true,
                                                keyboardType: TextInputType.number,
                                                controller: updateExamTimeTableController.dobController,
                                                validator: (value){
                                                  if(value!.isEmpty){
                                                    return "please pick a date";
                                                  } else{
                                                    return null;
                                                  }
                                                },
                                                onTap: () {
                                                  selectDate();
                                                },
                                                suffixIcon: GestureDetector(
                                                  onTap: () {
                                                    selectDate();
                                                  },
                                                  child: Icon(
                                                      Icons.calendar_month,
                                                      size: 20,
                                                      color: Colors.grey),
                                                )
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
                                                    controller: updateExamTimeTableController.fromTime,
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
                                                    controller: updateExamTimeTableController.toTime,
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
                                            //         controller: updateExamTimeTableController.fromTime,
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
                                                  () => updateExamTimeTableController.isTeacherLoading.value ?
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
                                                  items: updateExamTimeTableController.getTeacherListModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateExamTimeTableController.selectedTeacher,
                                                  validator: (value) {
                                                    print("validator :  $value");
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please select teacher';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    updateExamTimeTableController.selectedTeacher = value;
                                                    print(updateExamTimeTableController.selectedTeacher);
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

                                            const Text(
                                              'Class',
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
                                                  () => updateExamTimeTableController.isClassLoading.value ?
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
                                                    hintText: 'Select Class',
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
                                                  items: updateExamTimeTableController.getClassListModel.value.data!.toList()
                                                      .map((item) => DropdownMenuItem(
                                                    value: item.id.toString(),
                                                    child: Text(item.name!),
                                                  )).toList(),
                                                  value: updateExamTimeTableController.selectedClassForSeating,
                                                  validator: (value) {
                                                    print("validator :  $value");
                                                    if (value == null || value.isEmpty) {
                                                      return 'Please select class';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    updateExamTimeTableController.selectedClassForSeating = value;
                                                    print(updateExamTimeTableController.selectedClassForSeating);
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
                    updateExamTimeTableController.updateExamTimeTableAPI(context: context,id: widget.id);
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
        updateExamTimeTableController.fromTime.text = selectedTime;
      } else {
        updateExamTimeTableController.toTime.text = selectedTime;
      }
    }
  }

  void selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: Color(0xFF7ED957),
                // header background color
                onPrimary: Colors.white,
                // header text color
                onSurface: Color(0xFF7ED957), // body text color
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFF7ED957), // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2025)
    );

    if (pickedDate != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      updateExamTimeTableController.dobController.text = dateFormat.format(pickedDate);
    }
  }

}
