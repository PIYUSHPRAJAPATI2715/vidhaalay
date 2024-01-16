import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:vidhaalay_app/controller/teacher_controller/create_assignment_controller.dart';
import 'package:vidhaalay_app/controller/teacher_controller/update_assignment_controller.dart';
import 'package:vidhaalay_app/widgets/circular_progressindicator.dart';
import 'package:vidhaalay_app/widgets/common_button.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';
import '../../routers/my_routers.dart';
import '../../widgets/appTheme.dart';
import 'package:get/get.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';

class UpdateAssignmentScreen extends StatefulWidget {

  final String id;

  const UpdateAssignmentScreen({super.key, required this.id});

  @override
  State<UpdateAssignmentScreen> createState() => _UpdateAssignmentScreenState();
}

class _UpdateAssignmentScreenState extends State<UpdateAssignmentScreen> {

  final updateAssignmentController = Get.put(UpdateAssignmentController());

  final formKey = GlobalKey<FormState>();
  // final _formKey = GlobalKey<FormState>();

  // final List<String> items = [
  //   'Item1',
  //   'Item2',
  //   'Item3',
  //   'Item4',
  //   'Item5',
  //   'Item6',
  //   'Item7',
  //   'Item8',
  // ];
  // String? selectedValue;

  @override
  void initState() {
    updateAssignmentController.getAssignmentDetailsData(id: widget.id);
    updateAssignmentController.getMyClass();
    super.initState();
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
        () =>  updateAssignmentController.isDetailsLoading.value ?
        Center(child: const CommonProgressIndicator())
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
                          child: Text('Update Assignment',
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
                                  hintText: 'Enter assignment name',
                                  obSecure: false,
                                  controller: updateAssignmentController.assignmentName,
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Please enter assignment name')
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

                                DropdownButtonHideUnderline(
                                  child: DropdownButtonFormField2(
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
                                    items: updateAssignmentController.selectClassData.toList()
                                        .map((item) => DropdownMenuItem(
                                      value: item.id.toString(),
                                      child: Text(item.name),
                                    )).toList(),
                                    value: updateAssignmentController.selectClass,
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
                                        updateAssignmentController.selectClass = value;
                                        updateAssignmentController.getSubjectListData(classId: updateAssignmentController.selectClass.toString());

                                        print("value : ${updateAssignmentController.selectClass}");
                                      });
                                    },
                                    dropdownStyleData: DropdownStyleData(
                                      maxHeight: size.height * 0.28,
                                      width: size.width * 0.92,
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


                                Obx(
                                      () => updateAssignmentController.isSubjectLoading.value ?
                                  SizedBox.shrink()
                                      :
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const SizedBox(
                                        height: 25,
                                      ),

                                      Text('Subject',
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
                                          items: updateAssignmentController.getSubjectListModel.value.data!.toList()
                                              .map((item) => DropdownMenuItem(
                                            value: item.id.toString(),
                                            child: Text(item.name!),
                                          )).toList(),
                                          value: updateAssignmentController.selectedSubject,
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
                                            updateAssignmentController.selectedSubject = value;
                                            print(updateAssignmentController.selectedSubject);
                                            // });
                                          },
                                          dropdownStyleData: DropdownStyleData(
                                            maxHeight: size.height * 0.28,
                                            width: size.width * 0.92,
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
                                    ],
                                  ),
                                ),

                                const SizedBox(
                                  height: 25,
                                ),
                                Text('Due Date',
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
                                  hintText: 'Enter due date here',
                                  obSecure: false,
                                  readOnly: true,
                                  keyboardType: TextInputType.number,
                                  controller: updateAssignmentController.dobController,
                                  onTap: () {
                                    updateAssignmentController.selectDate(context);
                                  },
                                  suffixIcon: IconButton(
                                      onPressed: () {
                                        updateAssignmentController.selectDate(context);
                                      },
                                      icon: Icon(Icons.calendar_month,color: Colors.grey)
                                  ),
                                  validator: MultiValidator([
                                    RequiredValidator(errorText: 'Please select due date'),
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
                                Text('Details',
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
                                  controller: updateAssignmentController.message,
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                  decoration:  InputDecoration(
                                    hintText: 'Write details...',
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
                                    RequiredValidator(errorText: 'Details is required'),
                                  ]),
                                ),
                                const SizedBox(
                                  height: 35,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if(formKey.currentState!.validate()) {
                                      print(updateAssignmentController.selectClass);
                                      updateAssignmentController.updateAssignmentAPI(context: context,id: widget.id);
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
                                      title: 'Update',
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
      ),
    );
  }
}