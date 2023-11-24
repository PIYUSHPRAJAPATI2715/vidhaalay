import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class CreateEventScreen extends StatefulWidget {
  const CreateEventScreen({Key? key}) : super(key: key);

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {

  TextEditingController dobController = TextEditingController();
  String selectClass = 'Select Class';
  var selectClassData = [
    'Select Class',
    '7th', '8th', '9th', '10th',
    '11th', '12th',
  ];
  String selectStudent = 'Select Student';
  var selectStudentData = [
    'Select Student',
    'ram',
    'ram',
    'ram',
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

          },
          icon: Image.asset(AppAssets.moreIcon,width: 25,height: 25,),
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
              height: 175,
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
                        child: Text('Create Event',
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
            top: size.height*.230,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 5).copyWith(bottom: 0,right: 3),
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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Class',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
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
                                height: 25,
                              ),
                              Text('Date',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
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
                                height: 25,
                              ),
                              Text('Message',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              TextFormField(
                                maxLines: 5,
                                textAlign: TextAlign.start,
                                decoration:  InputDecoration(
                                  hintText: 'Write message...',
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 0.5
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(color: Colors.grey, width: 0.5),
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              Container(
                                width: size.width,
                                decoration: const BoxDecoration(
                                    color: AppThemes.primaryColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(25),
                                    )),
                                child: const CustomOutlineButton(
                                  title: 'Send',
                                  backgroundColor: AppThemes.primaryColor,

                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}

