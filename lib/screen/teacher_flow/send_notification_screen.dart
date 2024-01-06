import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vidhaalay_app/controller/teacher_controller/send_notification_controller.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class SendNotificationScreen extends StatefulWidget {
  const SendNotificationScreen({Key? key}) : super(key: key);

  @override
  State<SendNotificationScreen> createState() => _SendNotificationScreenState();
}

class _SendNotificationScreenState extends State<SendNotificationScreen> {
  final sendNotificationController = Get.put(SendNotificationController());
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();

  @override
  void initState() {
    sendNotificationController.getMyClass();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'vidhaalay'.toUpperCase(),
          style: GoogleFonts.poppins(
            fontSize: 19,
            fontWeight: FontWeight.w600,
            color: AppThemes.primaryColor,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Image.asset(
            AppAssets.arrowBack,
            width: 25,
            height: 25,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
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
              height: size.height * .230,
              decoration: const BoxDecoration(
                color: AppThemes.primaryColor,
                borderRadius:
                    BorderRadius.only(bottomLeft: Radius.circular(70)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Send Notification',
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
              )),
          Obx(
            () => Positioned.fill(
              top: size.height * .230,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 5)
                    .copyWith(bottom: 0, right: 3),
                height: size.height,
                width: size.width,
                decoration: const BoxDecoration(
                  color: AppThemes.white,
                  borderRadius:
                      BorderRadius.only(topRight: Radius.circular(60)),
                ),
                child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: false,
                                visualDensity: VisualDensity.comfortable,
                                toggleable: false,
                                title: Text('To All Students'),
                                value: 0,
                                groupValue: sendNotificationController
                                    .selectedValue.value,
                                onChanged: (values) {
                                  sendNotificationController
                                      .selectedValue.value = values!;
                                },
                              ),
                            ),
                            Expanded(
                              child: RadioListTile(
                                contentPadding: EdgeInsets.zero,
                                dense: false,
                                visualDensity: VisualDensity.comfortable,
                                title: Text('To Single Student'),
                                value: 1,
                                groupValue: sendNotificationController
                                    .selectedValue.value,
                                onChanged: (values) {
                                  sendNotificationController
                                      .selectedValue.value = values!;
                                },
                              ),
                            ),
                          ],
                        ),
                        if (sendNotificationController.selectedValue.value == 0)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
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
                                    hintText: 'Enter Title',
                                    obSecure: false,
                                    controller: sendNotificationController
                                        .titleController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Please enter title')
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Class',
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
                                  DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isExpanded: true,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        hintText: 'Select Class',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Colors.grey!
                                                    .withOpacity(0.5),
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Colors.grey!
                                                    .withOpacity(0.5),
                                                width: 1)),
                                      ),
                                      items: sendNotificationController
                                          .selectClassData
                                          .toList()
                                          .map((item) => DropdownMenuItem(
                                                value: item.id.toString(),
                                                child: Text(item.name),
                                              ))
                                          .toList(),
                                      value: sendNotificationController
                                          .selectClass,
                                      validator: (value) {
                                        print("validator :  $value");
                                        if (value == null || value.isEmpty) {
                                          return 'Please select class';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        setState(() {
                                          // print(value);
                                          sendNotificationController
                                              .selectClass = value;
                                          sendNotificationController.getStudentListData(classId: sendNotificationController.selectClass!);
                                          print("value0 : ${sendNotificationController.selectClass}");
                                        });
                                      },
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: size.height * 0.28,
                                        width: size.width * 0.92,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        isOverButton: false,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        offset: const Offset(0, -10),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 45,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
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
                                  Text(
                                    'Message',
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
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Write message...',
                                      hintStyle:  TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Please enter message')
                                    ]),
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
                                    child: CustomOutlineButton(
                                      title: 'Send',
                                      backgroundColor: AppThemes.primaryColor,
                                      onPressed: () {
                                        if (formKey.currentState!.validate()) {
                                          sendNotificationController.sendNotificationAPI(context: context,isSingleUser: false);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        if (sendNotificationController.selectedValue.value == 1)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
                            child: Form(
                              key: formKey1,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
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
                                    hintText: 'Enter Title',
                                    obSecure: false,
                                    controller: sendNotificationController
                                        .titleController,
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Please enter title')
                                    ]),
                                  ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Class',
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
                                  DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      isExpanded: true,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 15),
                                        hintText: 'Select Class',
                                        hintStyle: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                        ),
                                        errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                        ),
                                        focusedErrorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          borderSide: BorderSide(
                                              color: Colors.red, width: 1),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Colors.grey!
                                                    .withOpacity(0.5),
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            borderSide: BorderSide(
                                                color: Colors.grey!
                                                    .withOpacity(0.5),
                                                width: 1)),
                                      ),
                                      items: sendNotificationController
                                          .selectClassData
                                          .toList()
                                          .map((item) => DropdownMenuItem(
                                                value: item.id.toString(),
                                                child: Text(item.name),
                                              ))
                                          .toList(),
                                      value: sendNotificationController
                                          .selectClass,
                                      validator: (value) {
                                        print("validator :  $value");
                                        if (value == null || value.isEmpty) {
                                          return 'Please select class';
                                        } else {
                                          return null;
                                        }
                                      },
                                      onChanged: (value) {
                                        sendNotificationController.selectClass =
                                            value;
                                        sendNotificationController.getStudentListData(classId: sendNotificationController.selectClass!);
                                        print("value0 : ${sendNotificationController.selectClass}");
                                      },
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: size.height * 0.28,
                                        width: size.width * 0.92,
                                        padding:
                                            EdgeInsets.symmetric(horizontal: 5),
                                        isOverButton: false,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),
                                        offset: const Offset(0, -10),
                                        scrollbarTheme: ScrollbarThemeData(
                                          radius: const Radius.circular(40),
                                          thickness:
                                              MaterialStateProperty.all<double>(
                                                  6),
                                          thumbVisibility:
                                              MaterialStateProperty.all<bool>(
                                                  true),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        height: 45,
                                        padding: EdgeInsets.only(
                                            left: 10, right: 10),
                                      ),
                                    ),
                                  ),

                                  Obx(
                                    () => sendNotificationController
                                            .isStudentLoading.value
                                        ? SizedBox.shrink()
                                        : Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Text(
                                                'Student',
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
                                              DropdownButtonHideUnderline(
                                                child: DropdownButtonFormField2<
                                                    String>(
                                                  isExpanded: true,
                                                  style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15,
                                                  ),
                                                  decoration: InputDecoration(
                                                    alignLabelWithHint: true,
                                                    contentPadding: const
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 15),
                                                    hintText: 'Select Student',
                                                    hintStyle: const TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 15,
                                                    ),
                                                    errorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1),
                                                    ),
                                                    focusedErrorBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      borderSide: BorderSide(
                                                          color: Colors.red,
                                                          width: 1),
                                                    ),
                                                    enabledBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!
                                                                .withOpacity(
                                                                    0.5),
                                                            width: 1)),
                                                    focusedBorder: OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        borderSide: BorderSide(
                                                            color: Colors.grey!
                                                                .withOpacity(
                                                                    0.5),
                                                            width: 1)),
                                                  ),
                                                  items:
                                                      sendNotificationController
                                                          .getStudentListModel
                                                          .value
                                                          .data!
                                                          .toList()
                                                          .map((item) =>
                                                              DropdownMenuItem(
                                                                value: item.id
                                                                    .toString(),
                                                                child: Text(
                                                                    item.name!),
                                                              ))
                                                          .toList(),
                                                  value:
                                                      sendNotificationController
                                                          .selectStudent,

                                                  validator: (value) {
                                                   if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Please select student';
                                                    } else {
                                                      return null;
                                                    }
                                                  },
                                                  onChanged: (value) {
                                                    sendNotificationController
                                                            .selectStudent =
                                                        value;
                                                    print(sendNotificationController
                                                            .selectStudent);
                                                  },
                                                  dropdownStyleData: DropdownStyleData(
                                                    maxHeight: size.height * 0.28,
                                                    width: size.width * 0.92,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 5),
                                                    isOverButton: false,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              14),
                                                      color: Colors.white,
                                                    ),
                                                    offset:
                                                        const Offset(0, -10),
                                                    scrollbarTheme:
                                                        ScrollbarThemeData(
                                                      radius:
                                                          const Radius.circular(
                                                              40),
                                                      thickness:
                                                          MaterialStateProperty
                                                              .all<double>(6),
                                                      thumbVisibility:
                                                          MaterialStateProperty
                                                              .all<bool>(true),
                                                    ),
                                                  ),
                                                  menuItemStyleData:
                                                      const MenuItemStyleData(
                                                    height: 45,
                                                    padding: EdgeInsets.only(
                                                        left: 10, right: 10),
                                                  ),
                                                ),
                                              ),
                                            ],
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
                                  //       selectStudent,
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
                                  //     value: selectStudent,
                                  //     items: selectStudentData.map((String items) {
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
                                  //         selectStudent = newValue!;
                                  //       });
                                  //     },
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    'Message',
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
                                    style: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                    ),
                                    decoration: InputDecoration(
                                      hintText: 'Write message...',
                                      hintStyle: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      // border: OutlineInputBorder(
                                      //   borderRadius: BorderRadius.circular(8),
                                      //   borderSide: const BorderSide(
                                      //       color: Colors.grey,
                                      //       width: 0.5
                                      //   ),
                                      // ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey, width: 0.5),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      errorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                      focusedErrorBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.red, width: 1),
                                        borderRadius: BorderRadius.circular(25),
                                      ),
                                    ),
                                    validator: MultiValidator([
                                      RequiredValidator(
                                          errorText: 'Please enter message')
                                    ]),
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
                                    child: CustomOutlineButton(
                                      title: 'Send',
                                      backgroundColor: AppThemes.primaryColor,
                                      onPressed: () {
                                        if (formKey1.currentState!.validate()) {
                                          sendNotificationController.sendNotificationAPI(context: context,isSingleUser: true);
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                      ],
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
