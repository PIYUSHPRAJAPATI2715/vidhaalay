import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../resourses/size.dart';
import '../../widgets/appTheme.dart';
import '../../widgets/common_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  int _currentStep = 0;
  TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  TextEditingController promotion = TextEditingController();
  TextEditingController stNameController = TextEditingController();
  TextEditingController fatherNameController = TextEditingController();
  TextEditingController motherNameController = TextEditingController();
  TextEditingController adharcardNo = TextEditingController();
  TextEditingController bloodGroup = TextEditingController();

  /////
  final _formKeyResidential = GlobalKey<FormState>();
  TextEditingController pincodeController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  /////
  final _formKeyPrevious = GlobalKey<FormState>();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController percentageController = TextEditingController();

  ////

  final _formKeyFathers = GlobalKey<FormState>();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController mobileNOController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController annualIncomeController = TextEditingController();
  TextEditingController landlineNOController = TextEditingController();

  ////
  final _formKeyMother = GlobalKey<FormState>();
  TextEditingController motherqualificationController = TextEditingController();
  TextEditingController motheroccupationController = TextEditingController();
  TextEditingController mothermobileNOController = TextEditingController();
  TextEditingController motheraadharController = TextEditingController();
  TextEditingController motheremailIdController = TextEditingController();
  TextEditingController motherannualIncomeController = TextEditingController();
  TextEditingController motherlandlineNOController = TextEditingController();

  ///
  final _formKeySibling = GlobalKey<FormState>();
  TextEditingController siblingController = TextEditingController();
  TextEditingController collegController = TextEditingController();
  String number = '';
  int result = 0;
  RxString selectedDate1 = "".obs;
  var selectedDate = DateTime
      .now()
      .obs;
  DateTime today = DateTime.now();
  RxInt difference = 0.obs;
  String dateWithSubtract = "";
  double kk = 0.0;

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

  String selectedDate2 = "";
  RxInt selectedDate4 = 0.obs;
  DateTime currentDate = DateTime.now();
  int currentStep = 0;

  continueStep() {
    if (currentStep < 5) {
      setState(() {
        currentStep = currentStep + 1; //currentStep+=1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1; //currentStep-=1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController referalCodeController = TextEditingController();
  String gender = "male";
  String category = 'Select category';
  var categoryitems = [
    'Select category',
    'test1',
    'test2',
  ];
  String motherTongue = 'Select mother tongue';
  var motherTongueItems = [
    'Select mother tongue',
    'English',
    'Hindi',
  ];
  String religion = 'Select your religion';
  var religionItems = [
    'Select your religion',
    'hindu',
    'muslim',
  ];
  String nationality = 'Select Nationality';
  var nationalityItems = [
    'Select Nationality',
    'indian',
    'test2',
  ];
  String optionCity = 'Select City';
  var optionCityItems = [
    'Select City',
    'jaipur',
    'bikaner',
  ];
  String optionState = 'Select State';
  var optionStateItems = [
    'Select State',
    'rajasthan',
    'delhi',
  ];
  String selectClass = 'Select Class';
  var selectClassItems = [
    'Select Class',
    '1st',
    '2nd',
  ];
  String selectClassSibbling = 'Select Class';
  var selectClassSibblingItem = [
    'Select Class',
    'test1',
    'test2',
  ];
  String selectYearsStudy = 'Select no. of years';
  var selectYearsStudyItems = [
    'Select no. of years',
    '2020',
    '2021',
  ];
  String organization = 'Select organization';
  var organizationItem = [
    'Select organization',
    'test1',
    'test2',
  ];
  String organizationMother = 'Select organization';
  var organizationMotherItem = [
    'Select organization',
    'test1',
    'test2',
  ];
  List<String> fields = [
    "Student info",
    "Residential info",
    "Previous info",
    "Fathers info",
    "Mothers info",
    "Sibling info",
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: AppThemes.primaryColor,
        appBar: AppBar(
          surfaceTintColor: Colors.white,
          actionsIconTheme: const IconThemeData(color: Colors.black),
          title: const Text(
            'Admission Form',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          centerTitle: true,
          leading: InkWell(
            onTap: (){
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_rounded,
              color: Colors.black,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 80,
                decoration:  const BoxDecoration(color: AppThemes.primaryColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
                width: double.maxFinite,
                child: Stack(
                  children: [
                    Positioned(
                        child: Center(
                            child: Padding(
                                padding:
                                const EdgeInsets.symmetric(horizontal: 12),
                                child: TweenAnimationBuilder(
                                  tween: Tween<double>(begin: 0, end: kk),
                                  duration: const Duration(milliseconds: 600),
                                  builder: (BuildContext context, double value,
                                      Widget? child) {
                                    return LinearProgressIndicator(
                                      backgroundColor: Colors.white,
                                      color: Colors.black,
                                      value: value,
                                      minHeight: 3,
                                    );
                                  },
                                )))),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                              (index) => InkWell(
                            onTap: () {
                              kk = index / 5;
                              setState(() {});
                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  image:  DecorationImage(image: AssetImage(AppAssets.activeStep)),
                                ),
                                child: Center(
                                  child: Text(
                                    (index + 1).toString(),
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: AppThemes.primaryColor,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                          ),
                        ),
                      ),
                    )

                  ],
                ),
              ),
              Container(
                 height:40,
                decoration:  BoxDecoration(color: AppThemes.primaryColor,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40))),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:[
                      Column(
                          children: [
                  Text("Student",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                      Column(
                          children: [
                  Text("Residential",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                      Column(
                          children: [
                  Text("Previous",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                      Column(
                          children: [
                  Text("Fathers",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                      Column(
                          children: [
                  Text("Mothers",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                      Column(
                          children: [
                  Text("Sibling",style: TextStyle(
                              color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 12
                          ),),

                  Text("info",style: TextStyle(
                               color: Colors.black,
                             fontWeight: FontWeight.w400,
                             fontSize: 12
                           ),),



                            ],
                      ),
                    ]


                    //     List.generate(
                    //   fields.length,
                    //       (index) => Text(fields[index],style: TextStyle(
                    //           color: Colors.black,
                    //         fontWeight: FontWeight.w400,
                    //         fontSize: 12
                    //       ),),
                    // ),
                  ),
                ),
              ),
              if (kk == 0)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text('Student information'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Student Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter your name'),

                            ]),
                            hintText: 'Enter Full Name',
                            controller: stNameController,
                            keyboardType: TextInputType.name,
                            obSecure: false,
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Father\'s Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Full Name',
                            controller: fatherNameController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                          RequiredValidator(
                            errorText:
                            'Please Enter father\'s name'),

                        ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Mother\'s Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s name'),

                            ]),
                            hintText: 'Enter Full Name',
                            obSecure: false,
                            controller: motherNameController,
                            keyboardType: TextInputType.name,

                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Date of Birth',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
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
                                icon: const Icon(Icons.calendar_month)),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Gender',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Radio(
                                    value: "female",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  const Text("Female"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: "male",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  const Text("Male"),
                                ],
                              ),
                              Row(
                                children: [
                                  Radio(
                                    value: "other",
                                    groupValue: gender,
                                    onChanged: (value) {
                                      setState(() {
                                        gender = value.toString();
                                      });
                                    },
                                  ),
                                  const Text("Other"),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Aadhar Card No.',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Card Number',
                            controller: adharcardNo,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter adhar no '),

                            ]),

                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Category',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  category = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return categoryitems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  category,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // child: DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     category,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(25.0)))),
                            //   value: category,
                            //   items: categoryitems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       category = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Mother Tongue',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child:  PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  motherTongue = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return motherTongueItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  motherTongue,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     motherTongue,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius: BorderRadius.all(
                            //               Radius.circular(25.0)))),
                            //   value: motherTongue,
                            //   items: motherTongueItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       motherTongue = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Blood Group',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Blood Group',
                            controller: bloodGroup,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter blood group'),

                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
    if (_formKey.currentState!.validate()) {
      kk = 0.2;
      setState(() {

      });
    }  },
                              child: const Text('Continue',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (kk == .2)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKeyResidential,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                              child: Text('residential information'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Religion',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  religion = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return religionItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  religion,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Nationality',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //
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
                          //       nationality,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: nationality,
                          //     items: nationalityItems.map((String items) {
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
                          //         nationality = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  nationality = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return nationalityItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  nationality,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Residential Address',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(

                            child: CommonTextfield(
                              hintText: 'Enter Address',
                              obSecure: false,
                              controller: addressController,
                              keyboardType: TextInputType.name,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText:
                                    'Please Enter address'),

                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('City',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  optionCity = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return optionCityItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  optionCity,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          // Container(
                          //
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
                          //       optionCity,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: optionCity,
                          //     items: optionCityItems.map((String items) {
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
                          //         optionCity = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('State',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  optionState = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return optionStateItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  optionState,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          // Container(
                          //
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
                          //       optionState,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: optionState,
                          //     items: optionStateItems.map((String items) {
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
                          //         optionState = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Pincode',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(

                            child: CommonTextfield(
                              obSecure: false,
                              hintText: 'Enter Pincode',
                              controller: pincodeController,
                              keyboardType: TextInputType.number,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText:
                                    'Please Enter pincode'),

                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
    if (_formKeyResidential.currentState!.validate()) {
      kk = 0.4;
      setState(() {

      });
    }},
                              child: const Text('Continue',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (kk == 0.4)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKeyPrevious,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Center(
                              child: Text('previous school info'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Name of Previous School',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Full Name',
                            obSecure: false,
                            controller: schoolNameController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter school name'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Location',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter School Location',
                            obSecure: false,
                            controller: locationController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter loaction'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Class',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  selectClass = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return selectClassItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  selectClass,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          // Container(
                          //
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: selectClass,
                          //     items: selectClassItems.map((String items) {
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
                          const Text('Years of study in that school',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  selectYearsStudy = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return selectYearsStudyItems.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  selectYearsStudy,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                          ),
                          // Container(
                          //
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
                          //       selectYearsStudy,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: selectYearsStudy,
                          //     items: selectYearsStudyItems.map((String items) {
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
                          //         selectYearsStudy = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Percentage/Grade',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(

                            child: CommonTextfield(
                              obSecure: false,
                              hintText: 'Enter Card Number',
                              controller: percentageController,
                              keyboardType: TextInputType.name,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText:
                                    'Please Enter percentage'),

                              ]),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
    if (_formKeyPrevious.currentState!.validate()) {
      kk = 0.6;
      setState(() {

      });
    } },
                              child: const Text('Continue',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (kk == 0.6)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKeyFathers,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Center(
                              child: Text('father\'s information'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Father\'s Qualification',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Full Name',
                            controller: qualificationController,
                            keyboardType: TextInputType.name,
                            obSecure: false,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s qualification'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Occupation',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Father Occupation',
                            controller: occupationController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s occupation'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Organization',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //
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
                          //       organization,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: organization,
                          //     items: organizationItem.map((String items) {
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
                          //         organization = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  organization = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return organizationItem.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  organization,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Mobile Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Mobile Number',
                            obSecure: false,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            controller: mobileNOController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s mobile no'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Aadhar Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Father Aadhar Number',
                            controller: aadharController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s aadhar'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Email Id',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Father Email Address',
                            controller: emailIdController,
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s email'),
                              EmailValidator(errorText: "enter a valid mail")

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Annual Income',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Father annual Income',
                            controller: annualIncomeController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s annual income'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Landline Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Landline Number',
                            controller: landlineNOController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s landline no'),

                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
    if (_formKeyFathers.currentState!.validate()) {
      kk = 0.8;
      setState(() {

      });
    }},
                              child: const Text('Continue',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (kk == 0.8)
                Container(
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKeyMother,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Center(
                              child: Text('mother\'s information'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Mothers\'s Qualification',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Full Name',
                            controller: motherqualificationController,
                            keyboardType: TextInputType.name,
                            obSecure: false,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s qualification'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Occupation',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter mother Occupation',
                            controller: motheroccupationController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s occupation'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Organization',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  organization = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return organizationItem.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  organization,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          // Container(
                          //
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
                          //       organization,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: organization,
                          //     items: organizationItem.map((String items) {
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
                          //         organization = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),

                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Mobile Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Mobile Number',
                            obSecure: false,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            controller: mothermobileNOController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s mobile no'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Aadhar Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter mother Aadhar Number',
                            controller: motheraadharController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s aadhar'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Email Id',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter mother Email Address',
                            controller: motheremailIdController,
                            keyboardType: TextInputType.emailAddress,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s email'),
                              EmailValidator(errorText: "enter a valid mail")

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Annual Income',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter mother annual Income',
                            controller: motherannualIncomeController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s annual income'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Landline Number',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Landline Number',
                            controller: motherlandlineNOController,
                            keyboardType: TextInputType.number,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s landline no'),

                            ]),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
                                if (_formKeyMother.currentState!.validate()) {
                                  kk = 1;
                                  setState(() {

                                  });
                                }},
                              child: const Text('Continue',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (kk == 1)
                Container(
                  height: AddSize.screenHeight,
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKeySibling,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          Center(
                              child: Text('sibling information'.toUpperCase(),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 19,
                                      color: AppThemes.primaryColor))),
                          const SizedBox(
                            height: 15,
                          ),
                          const Text('Name',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            hintText: 'Enter Full Name',
                            controller: siblingController,
                            keyboardType: TextInputType.name,
                            obSecure: false,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter sibling\'s name'),

                            ]),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('Class',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          // Container(
                          //
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
                          //       organizationMother,
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
                          //             borderRadius:
                          //             BorderRadius.all(Radius.circular(25.0)))),
                          //     value: selectClassSibbling,
                          //     items: selectClassSibblingItem.map((String items) {
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
                          //         selectClassSibbling = newValue!;
                          //       });
                          //     },
                          //   ),
                          // ),
                          Container(
                            height: 55,
                            width: Get.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border.all(
                                    color: Colors.grey,
                                    width: 0.5
                                )
                            ),
                            child: PopupMenuButton<String>(
                              shape: Border.all(
                                  color: AppThemes.primaryColor
                              ),
                              onSelected: (String newValue) {
                                setState(() {
                                  selectClassSibbling = newValue;
                                });
                              },
                              itemBuilder: (BuildContext context) {
                                return selectClassSibblingItem.map((String item) {
                                  return PopupMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(color: AppThemes.black, fontSize: 14),
                                    ),
                                  );
                                }).toList();
                              },
                              child: ListTile(
                                title: Text(
                                  selectClassSibbling,
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                                trailing: const Icon(Icons.keyboard_arrow_down),
                              ),
                            ),
                            // DropdownButtonFormField(
                            //   focusColor: Colors.grey.shade50,
                            //   isExpanded: true,
                            //   iconEnabledColor: const Color(0xff97949A),
                            //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   hint: Text(
                            //     religion,
                            //     style: const TextStyle(
                            //         color: Color(0xff463B57),
                            //         fontSize: 16,
                            //         fontWeight: FontWeight.w300),
                            //     textAlign: TextAlign.justify,
                            //   ),
                            //   decoration: InputDecoration(
                            //       fillColor: Colors.grey.shade50,
                            //       contentPadding: const EdgeInsets.symmetric(
                            //           horizontal: 20, vertical: 10),
                            //       focusedBorder: OutlineInputBorder(
                            //         borderSide:
                            //         BorderSide(color: Colors.grey.shade300),
                            //         borderRadius: BorderRadius.circular(25.0),
                            //       ),
                            //       enabledBorder: const OutlineInputBorder(
                            //           borderSide:
                            //           BorderSide(color: Color(0xffE3E3E3)),
                            //           borderRadius:
                            //           BorderRadius.all(Radius.circular(25.0)))),
                            //   value: religion,
                            //   items: religionItems.map((String items) {
                            //     return DropdownMenuItem(
                            //       value: items,
                            //       child: Text(
                            //         items,
                            //         style: const TextStyle(
                            //             color: Colors.grey, fontSize: 14),
                            //       ),
                            //     );
                            //   }).toList(),
                            //   onChanged: (String? newValue) {
                            //     setState(() {
                            //       religion = newValue!;
                            //     });
                            //   },
                            // ),
                          ),
                          const SizedBox(
                            height: 25,
                          ),
                          const Text('School/Collage Currently Studing',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black)),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter School/Collage Name',
                            controller: collegController,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter colage\'s name'),

                            ]),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: AppThemes.primaryColor,
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                                  textStyle:
                                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                              onPressed: () {
                                Get.toNamed(MyRouters.bottomNavigationUserScreen);
                              },
                              child: const Text('Save',style: TextStyle(color: Colors.white),),
                            ),
                          ),
                          const SizedBox(
                            height:120,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ));
  }

  Widget controlBuilders(context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          width: double.maxFinite,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: AppThemes.primaryColor,
                padding:
                const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
                textStyle:
                const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            onPressed: () {

            },
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}
//import 'package:flutter/material.dart';
// import 'package:fx_stepper/fx_stepper.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:intl/intl.dart';
// import 'package:vidhaalay_app/widgets/appTheme.dart';
// import 'package:vidhaalay_app/widgets/common_textfield.dart';
//
// class RegistrationScreen extends StatefulWidget {
//   const RegistrationScreen({Key? key}) : super(key: key);
//
//   @override
//   State<RegistrationScreen> createState() => _RegistrationScreenState();
// }
//
// class _RegistrationScreenState extends State<RegistrationScreen> {
//   TextEditingController dobController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController promotion = TextEditingController();
//   String number = '';
//   int result = 0;
//   RxString selectedDate1="".obs;
//   var selectedDate = DateTime.now().obs;
//   DateTime today = DateTime.now();
//
//   //var selectedDate5 = DateFormat('d').format(selectedDate).toString();
//   RxInt difference = 0.obs;
//   String dateWithSubtract= "";
//
//   void selectDate() async {
//     final DateTime? pickedDate = await showDatePicker(
//         builder: (context, child) {
//           return Theme(
//             data: Theme.of(context).copyWith(
//               colorScheme: const ColorScheme.light(
//                 primary: Color(0xFF7ED957),
//                 // header background color
//                 onPrimary: Colors.white,
//                 // header text color
//                 onSurface: Color(0xFF7ED957), // body text color
//               ),
//               textButtonTheme: TextButtonThemeData(
//                 style: TextButton.styleFrom(
//                   foregroundColor: const Color(0xFF7ED957), // button text color
//                 ),
//               ),
//             ),
//             child: child!,
//           );
//         },
//         context: context,
//         initialDate: DateTime.now(),
//         firstDate: DateTime(1990),
//         lastDate: DateTime(2025));
//
//     if(pickedDate != null){
//       DateFormat dateFormat = DateFormat('yyyy-MM-dd');
//       dobController.text = dateFormat.format(pickedDate);
//     }
//   }
//   String selectedDate2= "";
//   RxInt selectedDate4= 0.obs;
//   DateTime currentDate= DateTime.now();
//   int currentStep = 0;
//   continueStep() {
//     if (currentStep < 5) {
//       setState(() {
//         currentStep = currentStep + 1; //currentStep+=1;
//       });
//     }
//   }
//   cancelStep() {
//     if (currentStep > 0) {
//       setState(() {
//         currentStep = currentStep - 1; //currentStep-=1;
//       });
//     }
//   }
//   onStepTapped(int value) {
//     setState(() {
//       currentStep = value;
//     });
//   }
//   TextEditingController nameController = TextEditingController();
//   TextEditingController phoneController = TextEditingController();
//   TextEditingController referalCodeController = TextEditingController();
//   String gender = "male";
//   String category = 'Select category';
//   var categoryitems = [
//     'Select category',
//     'test1',
//     'test2',
//   ];
//   String motherTongue = 'Select mother tongue';
//   var motherTongueItems = [
//     'Select mother tongue',
//     'test1',
//     'test2',
//   ];
//   String religion = 'Select your religion';
//   var religionItems = [
//     'Select your religion',
//     'test1',
//     'test2',
//   ];
//   String nationality = 'Select Nationality';
//   var nationalityItems = [
//     'Select Nationality',
//     'test1',
//     'test2',
//   ];
//   String optionCity = 'Select City';
//   var optionCityItems = [
//     'Select City',
//     'test1',
//     'test2',
//   ];
//   String optionState = 'Select State';
//   var optionStateItems = [
//     'Select State',
//     'test1',
//     'test2',
//   ];
//   String selectClass = 'Select Class';
//   var selectClassItems = [
//     'Select Class',
//     'test1',
//     'test2',
//   ];
//   String selectClassSibbling = 'Select Class';
//   var selectClassSibblingItem = [
//     'Select Class',
//     'test1',
//     'test2',
//   ];
//   String selectYearsStudy = 'Select no. of years';
//   var selectYearsStudyItems = [
//     'Select no. of years',
//     'test1',
//     'test2',
//   ];
//   String organization = 'Select organization';
//   var organizationItem = [
//     'Select organization',
//     'test1',
//     'test2',
//   ];
//   String organizationMother = 'Select organization';
//   var organizationMotherItem = [
//     'Select organization',
//     'test1',
//     'test2',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.only(top:30.0),
//         child: SizedBox(
//           width: MediaQuery.of(context).size.width,
//           child: FxStepper(
//             type: FxStepperType.horizontal,
//             elevation: 0,
//             controlsBuilder: controlBuilders,
//             physics: const ClampingScrollPhysics(),
//             onStepTapped: onStepTapped,
//             onStepContinue: continueStep,
//             //onStepCancel: cancelStep,
//             currentStep: currentStep,
//             steps: [
//               FxStep(
//                   label:  Column(
//                     children: const [
//                       Text('Student Info'),
//                     ],
//                   ),
//                   title: const Text(''),
//                   content:  Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//
//                        Center(child: Text('Student information'.toUpperCase(),
//                            style: const TextStyle(
//                                fontWeight: FontWeight.w600,
//                                fontSize: 19,
//                                color: AppThemes.primaryColor))),
//                      const SizedBox(
//                         height: 15,
//                       ),
//                       const Text('Student Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         height: 40,
//                         child: CommonTextfield(
//                           hintText: 'Enter Full Name',
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           obSecure: false,
//                           /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Father\'s Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         height: 40,
//                         child: CommonTextfield(
//                           obSecure: false,
//                           hintText: 'Enter Full Name',
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Mother\'s Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         height: 40,
//                         child: CommonTextfield(
//                           hintText: 'Enter Full Name',
//                           obSecure: false,
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         height: 40,
//                         child: CommonTextfield(
//                           hintText: 'Enter days here',
//                           obSecure: false,
//                           // validator: MultiValidator([
//                           //   RequiredValidator(
//                           //       errorText: 'Please Enter The Days'),
//                           // ]),
//                           // onChanged: (val){
//                           //   setState(() {
//                           //     difference.value = val ;
//                           //     if(val.trim().isEmpty){
//                           //       difference.value = '';
//                           //       result = 0;
//                           //       return;
//                           //     }
//                           //     int a = int.parse(val);
//                           //       result = a*3;
//                           //   });
//                           // },
//                           readOnly: true,
//                           keyboardType: TextInputType.number,
//                           controller: dobController,
//                           onTap: (){
//                             selectDate();
//                           },
//                           suffixIcon: IconButton(
//                               onPressed: (){
//                                 selectDate();
//                               },
//                               icon: const Icon(Icons.calendar_month)
//                           ),
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Gender',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Radio(
//                                 value: "female",
//                                 groupValue: gender,
//                                 onChanged: (value){
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("Female"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//
//                               Radio(
//                                 value: "male",
//                                 groupValue: gender,
//                                 onChanged: (value){
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("Male"),
//                             ],
//                           ),
//                           Row(
//                             children: [
//                               Radio(
//                                 value: "other",
//                                 groupValue: gender,
//                                 onChanged: (value){
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 },
//                               ),
//                               const Text("Other"),
//                             ],
//                           ),
//
//
//                         ],
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Aadhar Card No.',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                         height: 40,
//                         child: CommonTextfield(
//                           obSecure: false,
//                           hintText: 'Enter Card Number',
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Category',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       Container(
//                         height: 40,
//                         width: Get.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: DropdownButtonFormField(
//                           focusColor: Colors.grey.shade50,
//                           isExpanded: true,
//                           iconEnabledColor: const Color(0xff97949A),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           hint: Text(
//                             category,
//                             style: const TextStyle(
//                                 color: Color(0xff463B57),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w300),
//                             textAlign: TextAlign.justify,
//                           ),
//                           decoration: InputDecoration(
//                               fillColor: Colors.grey.shade50,
//                               contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(25.0),
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(25.0)))),
//                           value: category,
//                           items: categoryitems.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(
//                                 items,
//                                 style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               category = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Mother Tongue',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       Container(
//                         height: 40,
//                         width: Get.width,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                         child: DropdownButtonFormField(
//                           focusColor: Colors.grey.shade50,
//                           isExpanded: true,
//                           iconEnabledColor: const Color(0xff97949A),
//                           icon: const Icon(Icons.keyboard_arrow_down),
//                           hint: Text(
//                             motherTongue,
//                             style: const TextStyle(
//                                 color: Color(0xff463B57),
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.w300),
//                             textAlign: TextAlign.justify,
//                           ),
//                           decoration: InputDecoration(
//                               fillColor: Colors.grey.shade50,
//                               contentPadding:
//                               const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                               focusedBorder: OutlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.grey.shade300),
//                                 borderRadius: BorderRadius.circular(25.0),
//                               ),
//                               enabledBorder: const OutlineInputBorder(
//                                   borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                   borderRadius:
//                                   BorderRadius.all(Radius.circular(25.0)))),
//                           value: motherTongue,
//                           items: motherTongueItems.map((String items) {
//                             return DropdownMenuItem(
//                               value: items,
//                               child: Text(
//                                 items,
//                                 style: const TextStyle(
//                                     color: Colors.grey,
//                                     fontSize: 14),
//                               ),
//                             );
//                           }).toList(),
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               motherTongue = newValue!;
//                             });
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 25,),
//                       const Text('Blood Group',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                       const SizedBox(height: 10,),
//                       SizedBox(
//                      height: 40,
//                         child: CommonTextfield(
//                           obSecure: false,
//                           hintText: 'Enter Blood Group',
//                           controller: nameController,
//                           keyboardType: TextInputType.name,
//                           /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                         ),
//                       ),
//                     ],
//                   ),
//                   isActive: currentStep >= 0,
//                   state:
//                   currentStep >= 0 ? FxStepState.complete : FxStepState.disabled),
//               FxStep(
//                 title: const Text('Step 2'),
//                 content: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Center(child: Text('residential information'.toUpperCase(),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 19,
//                             color: AppThemes.primaryColor))),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text('Religion',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           religion,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: religion,
//                         items: religionItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             religion = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Nationality',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           nationality,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: nationality,
//                         items: nationalityItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             nationality = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Residential Address',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Address',
//                         obSecure: false,
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('City',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           optionCity,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: optionCity,
//                         items: optionCityItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             optionCity = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('State',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           optionState,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: optionState,
//                         items: optionStateItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             optionState = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Pincode',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Pincode',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                   ],
//                 ),
//                 isActive: currentStep >= 0,
//                 state: currentStep >= 1 ? FxStepState.complete : FxStepState.disabled,
//               ),
//               FxStep(
//                 title: const Text('Step 3'),
//                 content: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Center(child: Text('previous school info'.toUpperCase(),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 19,
//                             color: AppThemes.primaryColor))),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text('Name of Previous School',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Full Name',
//                         obSecure: false,
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Location',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter School Location',
//                         obSecure: false,
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Class',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           selectClass,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: selectClass,
//                         items: selectClassItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectClass = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Years of study in that school',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           selectYearsStudy,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: selectYearsStudy,
//                         items: selectYearsStudyItems.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectYearsStudy = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Percentage/Grade',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Card Number',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                   ],
//                 ),
//                 isActive: currentStep >= 0,
//                 state: currentStep >= 2 ? FxStepState.complete : FxStepState.disabled,
//               ),
//               FxStep(
//                 title: const Text('Step 4'),
//                 content:  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Center(child: Text('father\'s information'.toUpperCase(),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 19,
//                             color: AppThemes.primaryColor))),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text('Father\'s Qualification',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Full Name',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         obSecure: false,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Occupation',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Father Occupation',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Organization',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           organization,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: organization,
//                         items: organizationItem.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             organization = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Mobile Number',
//                         obSecure: false,
//                         // validator: MultiValidator([
//                         //   RequiredValidator(
//                         //       errorText: 'Please Enter The Days'),
//                         // ]),
//                         // onChanged: (val){
//                         //   setState(() {
//                         //     difference.value = val ;
//                         //     if(val.trim().isEmpty){
//                         //       difference.value = '';
//                         //       result = 0;
//                         //       return;
//                         //     }
//                         //     int a = int.parse(val);
//                         //       result = a*3;
//                         //   });
//                         // },
//                         readOnly: true,
//                         keyboardType: TextInputType.number,
//                         controller: dobController,
//                         onTap: (){
//                           selectDate();
//                         },
//                         suffixIcon: IconButton(
//                             onPressed: (){
//                               selectDate();
//                             },
//                             icon: const Icon(Icons.calendar_month)
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Aadhar Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Father Aadhar Number',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Email Id',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Father Email Address',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Annual Income',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Father annual Income',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Landline Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Landline Number',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//
//                   ],
//                 ),
//                 isActive: currentStep >= 0,
//                 state: currentStep >= 3 ? FxStepState.complete : FxStepState.disabled,
//               ),
//               FxStep(
//                 title: const Text('Step 5'),
//                 content:  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Center(child: Text('mother\'s information'.toUpperCase(),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 19,
//                             color: AppThemes.primaryColor))),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text('Mother\'s Qualification',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Full Name',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         obSecure: false,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Occupation',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Mother Occupation',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Organization',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           organizationMother,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: organizationMother,
//                         items: organizationMotherItem.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             organization = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Mobile Number',
//                         obSecure: false,
//                         // validator: MultiValidator([
//                         //   RequiredValidator(
//                         //       errorText: 'Please Enter The Days'),
//                         // ]),
//                         // onChanged: (val){
//                         //   setState(() {
//                         //     difference.value = val ;
//                         //     if(val.trim().isEmpty){
//                         //       difference.value = '';
//                         //       result = 0;
//                         //       return;
//                         //     }
//                         //     int a = int.parse(val);
//                         //       result = a*3;
//                         //   });
//                         // },
//                         readOnly: true,
//                         keyboardType: TextInputType.number,
//                         controller: dobController,
//                         onTap: (){
//                           selectDate();
//                         },
//                         suffixIcon: IconButton(
//                             onPressed: (){
//                               selectDate();
//                             },
//                             icon: const Icon(Icons.calendar_month)
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Aadhar Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Mother Aadhar Number',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Email Id',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Mother Email Address',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Annual Income',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Mother annual Income',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Landline Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter Landline Number',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//
//                   ],
//                 ),
//                 isActive: currentStep >= 0,
//                 state: currentStep >= 4 ? FxStepState.complete : FxStepState.disabled,
//               ),
//               FxStep(
//                 title: const Text('Step 6'),
//                 content:  Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//
//                     Center(child: Text('sibling information'.toUpperCase(),
//                         style: const TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 19,
//                             color: AppThemes.primaryColor))),
//                     const SizedBox(
//                       height: 15,
//                     ),
//                     const Text('Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         hintText: 'Enter Full Name',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         obSecure: false,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('Class',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     Container(
//                       height: 40,
//                       width: Get.width,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       child: DropdownButtonFormField(
//                         focusColor: Colors.grey.shade50,
//                         isExpanded: true,
//                         iconEnabledColor: const Color(0xff97949A),
//                         icon: const Icon(Icons.keyboard_arrow_down),
//                         hint: Text(
//                           organizationMother,
//                           style: const TextStyle(
//                               color: Color(0xff463B57),
//                               fontSize: 16,
//                               fontWeight: FontWeight.w300),
//                           textAlign: TextAlign.justify,
//                         ),
//                         decoration: InputDecoration(
//                             fillColor: Colors.grey.shade50,
//                             contentPadding:
//                             const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                             focusedBorder: OutlineInputBorder(
//                               borderSide: BorderSide(color: Colors.grey.shade300),
//                               borderRadius: BorderRadius.circular(25.0),
//                             ),
//                             enabledBorder: const OutlineInputBorder(
//                                 borderSide: BorderSide(color: Color(0xffE3E3E3)),
//                                 borderRadius:
//                                 BorderRadius.all(Radius.circular(25.0)))),
//                         value: selectClassSibbling,
//                         items: selectClassSibblingItem.map((String items) {
//                           return DropdownMenuItem(
//                             value: items,
//                             child: Text(
//                               items,
//                               style: const TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 14),
//                             ),
//                           );
//                         }).toList(),
//                         onChanged: (String? newValue) {
//                           setState(() {
//                             selectClassSibbling = newValue!;
//                           });
//                         },
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//                     const Text('School/Collage Currently Studing',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
//                     const SizedBox(height: 10,),
//                     SizedBox(
//                       height: 40,
//                       child: CommonTextfield(
//                         obSecure: false,
//                         hintText: 'Enter School/Collage Name',
//                         controller: nameController,
//                         keyboardType: TextInputType.name,
//                         /*validator: MultiValidator([
//                             RequiredValidator(
//                                 errorText:
//                                 'Please Enter Referral Code'),
//                             // PatternValidator(r'^[0-9]',
//                             //     errorText: 'Only digits are allow'),
//                             // MinLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number must be at list 10 digit'),
//                             // MaxLengthValidator(10,
//                             //     errorText:
//                             //         'Phone number is not greater then 10 digit'),
//                           ]),*/
//                       ),
//                     ),
//                     const SizedBox(height: 25,),
//
//                   ],
//                 ),
//                 isActive: currentStep >= 0,
//                 state: currentStep >= 5 ? FxStepState.complete : FxStepState.disabled,
//               ),
//             ],
//           ),
//         ),
//       ),
//       // bottomNavigationBar: Container(
//       //   height: 50,
//       //   child: controlBuilders(context,),
//       // ),
//     );
//   }
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
