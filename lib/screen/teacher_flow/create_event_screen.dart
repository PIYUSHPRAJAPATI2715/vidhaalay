import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/create_event_controller.dart';
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
  final createEventController = Get.put(CreateEventController());
  final formKey = GlobalKey<FormState>();



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

          Obx(() => Positioned.fill(
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
                    child: Form(
                      key: formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Name',
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
                                  CommonTextfield(
                                    hintText: 'Enter event name',
                                    obSecure: false,
                                    controller: createEventController.eventName,
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Please enter event name')
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
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
                                  DropdownButtonFormField<String>(
                                    value: createEventController.selectClass?.value,
                                    items: createEventController.selectClassData.toList()
                                        .map((item) => DropdownMenuItem(
                                      value: item.toString(),
                                      child: Text(item),
                                    )).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        createEventController.selectClass!.value = value!;
                                      });
                                    },
                                    menuMaxHeight: size.height * 0.25,
                                    borderRadius: BorderRadius.circular(10),
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
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please select class';
                                      }
                                      return null;
                                    },
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
                                  //     items: selectClassData.map((String items) {
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
                                  CommonTextfield(
                                    hintText: 'Enter days here',
                                    obSecure: false,
                                    readOnly: true,
                                    keyboardType: TextInputType.number,
                                    controller: createEventController.dobController,
                                    onTap: () {
                                      createEventController.selectDate(context);
                                    },
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          createEventController.selectDate(context);
                                        },
                                        icon: Icon(Icons.calendar_month,color: Colors.grey)
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Please select date of birth'),
                                    ]),
                                  ),
                                  // Container(
                                  //   height: 50,
                                  //   width: Get.width,
                                  //   decoration: BoxDecoration(
                                  //     borderRadius: BorderRadius.circular(25),
                                  //   ),
                                  //   child: CommonTextfield(
                                  //     hintText: 'Enter days here',
                                  //     obSecure: false,
                                  //     readOnly: true,
                                  //     keyboardType: TextInputType.number,
                                  //     controller: dobController,
                                  //     onTap: () {
                                  //       selectDate();
                                  //     },
                                  //     suffixIcon: IconButton(
                                  //         onPressed: () {
                                  //           selectDate();
                                  //         },
                                  //         icon: const Icon(Icons.calendar_month,size: 20,color: Colors.grey,)),
                                  //     validator: MultiValidator([
                                  //       RequiredValidator(errorText: 'Please select date'),
                                  //     ]),
                                  //   ),
                                  // ),
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
                                    maxLines: 3,
                                    controller: createEventController.message,
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                    decoration:  InputDecoration(
                                      hintText: 'Write message...',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
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
                                    validator: MultiValidator([
                                      RequiredValidator(errorText: 'Message is required'),
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 35,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      if(formKey.currentState!.validate()) {
                                        createEventController.createEventAPI(context,);
                                      }
                                    },
                                    child: Container(
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
                                  ),
                                ],
                              ),
                            ),
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

