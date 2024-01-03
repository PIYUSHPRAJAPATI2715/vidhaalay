import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class CreateExamTimeTable extends StatefulWidget {
  const CreateExamTimeTable({Key? key}) : super(key: key);

  @override
  State<CreateExamTimeTable> createState() => _CreateExamTimeTableState();
}

class _CreateExamTimeTableState extends State<CreateExamTimeTable> {
  String selectClass = 'Select Subject';
  var selectClassData = [
    'Select Subject',
    'Science', 'Sst', 'English', 'Hindi',
    'Math', 'Computer',
  ];
  String weekday = 'Select Class';
  var weekdayData = [
    'Select Class',
    '8th', '9th', '10th',
  ];
  String teacher = 'Select teacher';
  var teacherData = [
    'Select teacher',
    'Monika', 'Sumit', 'Ram',
  ];
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
        firstDate: DateTime(1990),
        lastDate: DateTime(2025));

    if (pickedDate != null) {
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dobController.text = dateFormat.format(pickedDate);
    }
  }
  TextEditingController dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      body: Stack(
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
              height: 155,
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
                        child: Text('Timetable',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text('Class-8th',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.white,
                          ),
                        ),
                      ),
                    ],
                  ),


                ],
              )
          ),

          Positioned.fill(
            top: size.height*.204,
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
                                        Container(
                                          height: 50,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: DropdownButtonFormField(
                                            focusColor: Colors.grey.shade50,
                                            isExpanded: true,
                                            iconEnabledColor: const Color(0xff97949A),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            hint: Text(
                                              selectClass,
                                              style: const TextStyle(
                                                  color: Color(0xff463B57),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                              textAlign: TextAlign.justify,
                                            ),
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade50,
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(25.0),
                                                ),
                                                enabledBorder: const OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xffE3E3E3)),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(25.0)))),
                                            value: selectClass,
                                            items: selectClassData.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: const TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectClass = newValue!;
                                              });
                                            },
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
                                        Container(
                                          height: 50,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: CommonTextfield(
                                            hintText: 'Enter days here',
                                            obSecure: false,
                                            readOnly: true,
                                            keyboardType: TextInputType.number,
                                            controller: dobController,
                                            onTap: () {
                                              selectDate();
                                            },
                                            suffixIcon: IconButton(
                                                onPressed: () {
                                                  selectDate();
                                                },
                                                icon: const Icon(Icons.calendar_month,size: 20,color: Colors.grey,)),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 18,
                                        ),
                                        Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: const[
                                            Expanded(
                                              child: Text(
                                                'From',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 15,
                                                  color: AppThemes.blueColor,
                                                ),
                                              ),
                                            ),

                                            Expanded(
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
                                          children: <Widget>[
                                            Expanded(
                                              child: CommonTextfield(
                                                obSecure: false,
                                                hintText: '0:0',
                                                suffixIcon: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 90,
                                                      child: DropdownButtonFormField(
                                                        focusColor: Colors.grey.shade50,
                                                        isExpanded: true,
                                                        iconEnabledColor: const Color(0xff97949A),
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        hint: Text(
                                                          selectedPeriod,
                                                          style: const TextStyle(
                                                              color: Color(0xff463B57),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w300),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                        decoration: InputDecoration(
                                                            fillColor: Colors.grey.shade50,
                                                            contentPadding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 13),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide:
                                                              BorderSide(color: Colors.grey.shade300),
                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide:
                                                                BorderSide(color: Color(0xffE3E3E3)),
                                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)))),
                                                        value: selectedPeriod,
                                                        items: selectedPeriodData.map((String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(
                                                              items,
                                                              style: const TextStyle(
                                                                  color: Colors.grey, fontSize: 14),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            selectedPeriod = newValue!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Expanded(
                                              child: CommonTextfield(
                                                obSecure: false,
                                                hintText: '0:0',
                                                suffixIcon: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      width: 90,
                                                      child: DropdownButtonFormField(
                                                        focusColor: Colors.grey.shade50,
                                                        isExpanded: true,
                                                        iconEnabledColor: const Color(0xff97949A),
                                                        icon: const Icon(Icons.keyboard_arrow_down),
                                                        hint: Text(
                                                          selectedPeriod1,
                                                          style: const TextStyle(
                                                              color: Color(0xff463B57),
                                                              fontSize: 16,
                                                              fontWeight: FontWeight.w300),
                                                          textAlign: TextAlign.justify,
                                                        ),
                                                        decoration: InputDecoration(
                                                            fillColor: Colors.grey.shade50,
                                                            contentPadding: const EdgeInsets.symmetric(
                                                                horizontal: 20, vertical: 13),
                                                            focusedBorder: OutlineInputBorder(
                                                              borderSide:
                                                              BorderSide(color: Colors.grey.shade300),
                                                              borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)),
                                                            ),
                                                            enabledBorder: const OutlineInputBorder(
                                                                borderSide:
                                                                BorderSide(color: Color(0xffE3E3E3)),
                                                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(25),topRight: Radius.circular(25)))),
                                                        value: selectedPeriod1,
                                                        items: selectedPeriod1Data.map((String items) {
                                                          return DropdownMenuItem(
                                                            value: items,
                                                            child: Text(
                                                              items,
                                                              style: const TextStyle(
                                                                  color: Colors.grey, fontSize: 14),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged: (String? newValue) {
                                                          setState(() {
                                                            selectedPeriod1 = newValue!;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
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
                                        Container(
                                          height: 50,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: DropdownButtonFormField(
                                            focusColor: Colors.grey.shade50,
                                            isExpanded: true,
                                            iconEnabledColor: const Color(0xff97949A),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            hint: Text(
                                              teacher,
                                              style: const TextStyle(
                                                  color: Color(0xff463B57),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                              textAlign: TextAlign.justify,
                                            ),
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade50,
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(25.0),
                                                ),
                                                enabledBorder: const OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xffE3E3E3)),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(25.0)))),
                                            value: teacher,
                                            items: teacherData.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: const TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                teacher = newValue!;
                                              });
                                            },
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
                                        Container(
                                          height: 50,
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child: DropdownButtonFormField(
                                            focusColor: Colors.grey.shade50,
                                            isExpanded: true,
                                            iconEnabledColor: const Color(0xff97949A),
                                            icon: const Icon(Icons.keyboard_arrow_down),
                                            hint: Text(
                                              weekday,
                                              style: const TextStyle(
                                                  color: Color(0xff463B57),
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                              textAlign: TextAlign.justify,
                                            ),
                                            decoration: InputDecoration(
                                                fillColor: Colors.grey.shade50,
                                                contentPadding: const EdgeInsets.symmetric(
                                                    horizontal: 20, vertical: 10),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide:
                                                  BorderSide(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(25.0),
                                                ),
                                                enabledBorder: const OutlineInputBorder(
                                                    borderSide:
                                                    BorderSide(color: Color(0xffE3E3E3)),
                                                    borderRadius: BorderRadius.all(
                                                        Radius.circular(25.0)))),
                                            value: weekday,
                                            items: weekdayData.map((String items) {
                                              return DropdownMenuItem(
                                                value: items,
                                                child: Text(
                                                  items,
                                                  style: const TextStyle(
                                                      color: Colors.grey, fontSize: 14),
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                weekday = newValue!;
                                              });
                                            },
                                          ),
                                        ),
                                      ],
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
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(AppAssets.addMore,height: 24,),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'Add More',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                              color: AppThemes.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  )
              ),
            ),
          ),
        ],
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
                  Get.toNamed(MyRouters.teacherExamTimeTableScreen);
                },
                child:  const Center(
                  child:  Text(
                    'SUBMIT',
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
}
