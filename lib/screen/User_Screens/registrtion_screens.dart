import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/resourses/api_constant.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import '../../controller/get_country_controller.dart';
import '../../repositories/addmission_repo.dart';
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
  // List<GlobalKey> formKeys = List.generate(
  //     14, (_) => GlobalKey());

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
  final ScrollController _scrollController = ScrollController();

  /////
  final _formKeyPrevious = GlobalKey<FormState>();
  // final ScrollController _scrollController1 = ScrollController();
  TextEditingController schoolNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  TextEditingController classPrevCon = TextEditingController();
  TextEditingController yearprevSchoolCon = TextEditingController();

  ////

  final _formKeyFathers = GlobalKey<FormState>();
  TextEditingController qualificationController = TextEditingController();
  TextEditingController occupationController = TextEditingController();
  TextEditingController mobileNOController = TextEditingController();
  TextEditingController aadharController = TextEditingController();
  TextEditingController emailIdController = TextEditingController();
  TextEditingController annualIncomeController = TextEditingController();
  TextEditingController landlineNOController = TextEditingController();
  TextEditingController organizationController1 = TextEditingController();
  TextEditingController schoolSibblingCon = TextEditingController();

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
              // backgroundColor: Colors.white,
              // cardColor: Colors.white,
              colorScheme: const ColorScheme.light(
                primary:
                // Colors.black,
                Color(0xFF7ED957),
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
        firstDate: DateTime(1970),
        lastDate: DateTime.now()
    );

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
        print("currentStep : $currentStep");
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
  TextEditingController organizationController = TextEditingController();

  String gender = "male";
  String? category;
  // String category = 'Select category';
  var categoryitems = [
    // 'Select category',
    'General',
    'SC',
    'ST',
    'OBC',
    'Others',
  ];

  // String motherTongue = 'Select mother tongue';
  String? motherTongue;
  var motherTongueItems = [
    // 'Select mother tongue',
    'English',
    'Hindi',
  ];

  // String bloodType = 'Select blood group';
  String? bloodType;
  var bloodGroupItems = [
    // 'Select blood group',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-',
  ];


  // String religion = 'Select your religion';
  String? religion;
  var religionItems = [
    // 'Select your religion',
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



  String? selectedCityValue;
  final getCountryController = Get.put(GetCountryListController());


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCountryController.getCountryListFunction();
    getCountryController.getStateListFunction();
    getCountryController.getCityListFunction("1");
    // getCountryController.getCityListFunction();
  }


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
        body:
        SingleChildScrollView(
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
                                )))
                    ),
                    Positioned.fill(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                              (index) => InkWell(
                            onTap: () {
                              // int decimalPartAsInt = (kk * 10).toInt() % 10;
                              // print('Decimal part as int: $decimalPartAsInt');
                              // int currentIndex = (decimalPartAsInt / 2).toInt();
                              int currentIndex = (kk * 5).toInt();
                              print('currentIndex : $currentIndex');


                              if(currentIndex == index) {
                                  print("Equal");
                                } else if(currentIndex < index) {
                                  print("Increase");

                                  switch (currentIndex) {
                                    case 0:
                                      print('The number is 0');
                                      if(_formKey.currentState!.validate()) {
                                        kk = (currentIndex+1) / 5;
                                      }
                                      break;

                                    case 1:
                                      print('The number is 1');
                                      if(_formKeyResidential.currentState!.validate()) {
                                        kk = (currentIndex+1) / 5;
                                      }
                                      break;

                                    case 2:
                                      print('The number is 2');
                                      if(_formKeyPrevious.currentState!.validate()) {
                                        kk = (currentIndex+1) / 5;
                                      }
                                      break;

                                    case 3:
                                      print('The number is 3');
                                      if(_formKeyFathers.currentState!.validate()) {
                                        kk = (currentIndex+1) / 5;
                                      }
                                      break;

                                    case 4:
                                      print('The number is 3');
                                      if(_formKeyMother.currentState!.validate()) {
                                        kk = (currentIndex+1) / 5;
                                      }
                                      break;

                                    default:
                                      print('The number is not 1, 2, or 3');
                                  }

                                } else {
                                  kk = index / 5;
                                  print("Decrease");
                                }

                              print("index : $index");
                              print("kk : $kk");
                              // print(_formKey.currentState!.validate());
                              // print(_formKeyResidential.currentState!.validate());
                              // print(_formKeyPrevious.currentState!.validate());

                              // if(_formKey.currentState!.validate()) {
                                // if(index == 0) {
                                //   kk = index / 5;
                                // } else {
                                //   if(_formKeyResidential.currentState!.validate()) {
                                //     if(index == 1) {
                                //       kk = index / 5;
                                //     } else {
                                //       if(_formKeyPrevious.currentState!.validate()) {
                                //         if(index == 2) {
                                //           kk = index / 5;
                                //         } else {
                                //           if(_formKeyFathers.currentState!.validate()) {
                                //             if(index == 3) {
                                //               kk = index / 5;
                                //             } else {
                                //               if(_formKeyMother.currentState!.validate()) {
                                //                 if(index == 4) {
                                //                   kk = index / 5;
                                //                 } else {
                                //                   if(_formKeySibling.currentState!.validate()) {
                                //                     if(index == 5) {
                                //                       kk = index / 5;
                                //                     } else {
                                //                       print("All info submitted");
                                //                     }
                                //                   }
                                //                 }
                                //               }
                                //             }
                                //           }
                                //         }
                                //       }
                                //     }
                                //   }
                                // }
                              // }
                              print("kk : $kk");
                              setState(() {});

                            },
                            child: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  // color: Colors.deepOrange,
                                  image:  DecorationImage(image: AssetImage(AppAssets.activeStep),fit: BoxFit.fill),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 5.0),
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
                                icon: Icon(Icons.calendar_month,color: Colors.grey
                                )
                            ),
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Please select date of birth'),
                            ]),
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
                                  color: Colors.black)
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Card Number',
                            controller: adharcardNo,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            validator: MultiValidator([
                              RequiredValidator(errorText: 'Please enter aadhar number'),
                              LengthRangeValidator(min: 12, max: 12, errorText: "Please enter at least 12 character")
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

                          // DropdownButtonFormField(
                          //     focusColor: Colors.grey.shade50,
                          //     isExpanded: true,
                          //     iconEnabledColor: const Color(0xff97949A),
                          //     icon: const Icon(Icons.keyboard_arrow_down),
                          //     hint: Text(
                          //       category,
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
                          //                 Radius.circular(25.0)
                          //             )
                          //         )
                          //     ),
                          //     value: category,
                          //     items: categoryitems.map((String items) {
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
                          //         category = newValue!;
                          //       });
                          //     },
                          //   ),
                          /**/
                          // DropdownMenuTheme(
                          //   data: DropdownMenuThemeData(
                          //     menuStyle: MenuStyle(
                          //       surfaceTintColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                          //         return Colors.white;
                          //       }),
                          //     ),
                          //     textStyle: TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: AddSize.font14),
                          //     inputDecorationTheme: InputDecorationTheme(
                          //       alignLabelWithHint: true,
                          //       floatingLabelAlignment: FloatingLabelAlignment.center,
                          //       constraints: BoxConstraints(
                          //         maxHeight: 50,
                          //         // minHeight: 30
                          //       ),
                          //       hintStyle: TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: AddSize.font14,),
                          //       contentPadding: EdgeInsets.only(left: 15),
                          //       enabledBorder: OutlineInputBorder(
                          //           gapPadding: 0.0,
                          //           borderRadius: BorderRadius.circular(50),
                          //           borderSide: BorderSide(
                          //               color: Colors.grey!.withOpacity(0.5),
                          //               width: 1
                          //           )
                          //       ),
                          //     ),
                          //   ),
                          //   child: DropdownMenu<String>(
                          //     width: size.width * 0.93,
                          //     menuHeight: size.height * 0.3,
                          //     hintText: 'Select category',
                          //     textStyle:  TextStyle(
                          //         color: Colors.grey,
                          //         fontSize: AddSize.font14),
                          //     onSelected: (String? value) {
                          //       category = value!;
                          //       print(value);
                          //     },
                          //     trailingIcon: const Icon(Icons.keyboard_arrow_down),
                          //     dropdownMenuEntries: categoryitems.toList().map((value) {
                          //       return DropdownMenuEntry(value: value.toString(), label: value.toString());
                          //     }).toList(),
                          //   ),
                          // ),

                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              value: category,
                              items: categoryitems.toList()
                                  .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                                  .toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select category';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                setState(() {
                                  category = value!;
                                });
                              },
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                hintText: 'Select Category',
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
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.28,
                                width: size.width * 0.925,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                isOverButton: false,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),

                                offset: const Offset(2, -10),
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

                          // DropdownButtonFormField<String>(
                          //   value: motherTongue,
                          //   items: motherTongueItems.toList()
                          //       .map((item) => DropdownMenuItem(
                          //     value: item,
                          //     child: Text(item),
                          //   ))
                          //       .toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       motherTongue = value!;
                          //     });
                          //   },
                          //   menuMaxHeight: size.height * 0.25,
                          //   borderRadius: BorderRadius.circular(10),
                          //   decoration: InputDecoration(
                          //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          //     hintText: 'Select mother tongue',
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
                          //       return 'Please select mother tongue';
                          //     }
                          //     return null;
                          //   },
                          // ),

                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              value: motherTongue,
                              items: motherTongueItems.toList()
                                  .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              ))
                                  .toList(),
                              onChanged: (value) {
                                setState(() {
                                  motherTongue = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select mother tongue';
                                }
                                return null;
                              },
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                hintText: 'Select mother tongue',
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
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.28,
                                width: size.width * 0.925,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                isOverButton: false,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),

                                offset: const Offset(2, -10),
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
                          // DropdownButtonFormField<String>(
                          //   value: bloodType,
                          //   // isExpanded: true,
                          //   // padding: EdgeInsets.symmetric(horizontal: 15),
                          //   // alignment: Alignment.center,
                          //   items: bloodGroupItems.toList()
                          //       .map((item) => DropdownMenuItem(
                          //     value: item,
                          //     child: Text(item),
                          //   )).toList(),
                          //   onChanged: (value) {
                          //     setState(() {
                          //       bloodType = value!;
                          //     });
                          //   },
                          //   menuMaxHeight: size.height * 0.25,
                          //   borderRadius: BorderRadius.circular(10),
                          //   decoration: InputDecoration(
                          //     // constraints: BoxConstraints(
                          //     //   maxWidth: size.width * 0.8
                          //     // ),
                          //     // isCollapsed: false,
                          //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                          //     hintText: 'Select your blood group',
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
                          //       return 'Please select your blood group';
                          //     }
                          //     return null;
                          //   },
                          // ),

                          DropdownButtonHideUnderline(
                            child: DropdownButtonFormField2(
                              value: bloodType,
                              items: bloodGroupItems.toList()
                                  .map((item) => DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              )).toList(),
                              onChanged: (value) {
                                setState(() {
                                  bloodType = value!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your blood group';
                                }
                                return null;
                              },
                              isExpanded: true,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                hintText: 'Select your blood group',
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
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: size.height * 0.28,
                                width: size.width * 0.925,
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                isOverButton: false,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: Colors.white,
                                ),

                                offset: const Offset(2, -10),
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
                                if (_formKey.currentState!.validate()) {
                                  // getCountryController.getCountryListFunction();
                                  kk = 0.2;

                                  setState(() {
                                    _scrollController.animateTo(
                                      0.0,
                                      duration: Duration(milliseconds: 10),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              },
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
                  // height: Get.height,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      controller: _scrollController,
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
                            // DropdownButtonFormField<String>(
                            //   value: religion,
                            //   items: religionItems.toList()
                            //       .map((item) => DropdownMenuItem(
                            //     value: item,
                            //     child: Text(item),
                            //   )).toList(),
                            //   onChanged: (value) {
                            //     setState(() {
                            //       religion = value!;
                            //     });
                            //   },
                            //   menuMaxHeight: size.height * 0.25,
                            //   borderRadius: BorderRadius.circular(10),
                            //   decoration: InputDecoration(
                            //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                            //     hintText: 'Select religion',
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
                            //       return 'Please select religion';
                            //     }
                            //     return null;
                            //   },
                            // ),

                            DropdownButtonHideUnderline(
                              child: DropdownButtonFormField2(
                                value: religion,
                                items: religionItems.toList()
                                    .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Text(item),
                                )).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    religion = value!;
                                  });
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please select religion';
                                  }
                                  return null;
                                },
                                isExpanded: true,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  hintText: 'Select religion',
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
                                dropdownStyleData: DropdownStyleData(
                                  maxHeight: size.height * 0.28,
                                  width: size.width * 0.925,
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  isOverButton: false,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Colors.white,
                                  ),

                                  offset: const Offset(2, -10),
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


                            // Container(
                            //   height: 55,
                            //   width: Get.width,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       border: Border.all(
                            //           color: Colors.grey,
                            //           width: 0.5
                            //       )
                            //   ),
                            //   child: PopupMenuButton<String>(
                            //     shape: Border.all(
                            //         color: AppThemes.primaryColor
                            //     ),
                            //     onSelected: (String newValue) {
                            //       setState(() {
                            //         religion = newValue;
                            //       });
                            //     },
                            //     itemBuilder: (BuildContext context) {
                            //       return religionItems.map((String item) {
                            //         return PopupMenuItem<String>(
                            //           value: item,
                            //           child: Text(
                            //             item,
                            //             style: const TextStyle(color: AppThemes.black, fontSize: 14),
                            //           ),
                            //         );
                            //       }).toList();
                            //     },
                            //     child: ListTile(
                            //       title: Text(
                            //         religion,
                            //         style: const TextStyle(
                            //           color: Colors.grey,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w300,
                            //         ),
                            //         textAlign: TextAlign.justify,
                            //       ),
                            //       trailing: const Icon(Icons.keyboard_arrow_down),
                            //     ),
                            //   ),
                            //   // DropdownButtonFormField(
                            //   //   focusColor: Colors.grey.shade50,
                            //   //   isExpanded: true,
                            //   //   iconEnabledColor: const Color(0xff97949A),
                            //   //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   //   hint: Text(
                            //   //     religion,
                            //   //     style: const TextStyle(
                            //   //         color: Color(0xff463B57),
                            //   //         fontSize: 16,
                            //   //         fontWeight: FontWeight.w300),
                            //   //     textAlign: TextAlign.justify,
                            //   //   ),
                            //   //   decoration: InputDecoration(
                            //   //       fillColor: Colors.grey.shade50,
                            //   //       contentPadding: const EdgeInsets.symmetric(
                            //   //           horizontal: 20, vertical: 10),
                            //   //       focusedBorder: OutlineInputBorder(
                            //   //         borderSide:
                            //   //         BorderSide(color: Colors.grey.shade300),
                            //   //         borderRadius: BorderRadius.circular(25.0),
                            //   //       ),
                            //   //       enabledBorder: const OutlineInputBorder(
                            //   //           borderSide:
                            //   //           BorderSide(color: Color(0xffE3E3E3)),
                            //   //           borderRadius:
                            //   //           BorderRadius.all(Radius.circular(25.0)))),
                            //   //   value: religion,
                            //   //   items: religionItems.map((String items) {
                            //   //     return DropdownMenuItem(
                            //   //       value: items,
                            //   //       child: Text(
                            //   //         items,
                            //   //         style: const TextStyle(
                            //   //             color: Colors.grey, fontSize: 14),
                            //   //       ),
                            //   //     );
                            //   //   }).toList(),
                            //   //   onChanged: (String? newValue) {
                            //   //     setState(() {
                            //   //       religion = newValue!;
                            //   //     });
                            //   //   },
                            //   // ),
                            // ),
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


                           Obx(() {
                           return getCountryController.isDataLoading.value == true ?

                           DropdownButtonHideUnderline(
                             child: DropdownButtonFormField2(
                               value: getCountryController.selectCountyValue,
                               items: getCountryController.getCountryModel.value.data!.toList()
                                   .map((item) => DropdownMenuItem(
                                 value: item.id.toString(),
                                 child: Container(
                                   width: size.width * 0.75,
                                   child: Text(
                                     // "Test",
                                     item.name.toString(),
                                     overflow: TextOverflow.ellipsis,maxLines: 5,),
                                 ),
                               )).toList(),
                               // isExpanded: false,
                               onChanged: (value) {
                                 setState(() {
                                   getCountryController.selectCountyValue = value!.toString();
                                 });
                               },
                               validator: (value) {
                                 if (value == null || value == '') {
                                   return 'Please select Country';
                                 }
                                 return null;
                               },
                               isExpanded: true,
                               style: TextStyle(
                                 color: Colors.grey,
                                 fontSize: 15,
                               ),
                               decoration: InputDecoration(
                                 contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                 hintText: 'Select Country',
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
                               dropdownStyleData: DropdownStyleData(
                                 maxHeight: size.height * 0.28,
                                 width: size.width * 0.925,
                                 padding: EdgeInsets.symmetric(horizontal: 5),
                                 isOverButton: false,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(14),
                                   color: Colors.white,
                                 ),

                                 offset: const Offset(2, -10),
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
                           )

                             : SizedBox();
                           }),
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
                            const Text('State',
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: Colors.black)),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return getCountryController.isGetStateLoading.value == true ?
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField2(
                                  value: getCountryController.selectStateValue,
                                  items: getCountryController.getStateListModel.value.data!.toList()
                                      .map((item) => DropdownMenuItem(
                                    value:
                                    // "test",
                                    item.id.toString(),
                                    child: Text(
                                      // "test",
                                      item.name.toString(),
                                      overflow: TextOverflow.ellipsis,maxLines: 5,),
                                  )).toList(),
                                  // isExpanded: false,
                                  onChanged: (value) {
                                    getCountryController.selectStateValue = value!.toString();
                                    getCountryController.selectCityValue = null;
                                    getCountryController.getCityListFunction(getCountryController.selectStateValue!);
                                    print(value);
                                    setState(() {});
                                  },
                                  validator: (value) {
                                    if (value == null || value == '') {
                                      return 'Please select state';
                                    }
                                    return null;
                                  },
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                    hintText: 'Select State',
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
                                  dropdownStyleData: DropdownStyleData(
                                    maxHeight: size.height * 0.28,
                                    width: size.width * 0.925,
                                    padding: EdgeInsets.symmetric(horizontal: 5),
                                    isOverButton: false,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(14),
                                      color: Colors.white,
                                    ),

                                    offset: const Offset(2, -10),
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
                              )
                              : SizedBox();
                            }),

                            Obx(() {
                            return getCountryController.isGetCityLoading.value == true ?
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                Obx(() {
                                  return getCountryController.isGetCityLoading.value == true ?
                                  // DropdownButtonFormField<String>(
                                  //   value: getCountryController.selectCityValue,
                                  //   items: getCountryController.getCityListModel.value.data!.toList()
                                  //       .map((item) => DropdownMenuItem(
                                  //     value:
                                  //     // "test",
                                  //     item.id.toString(),
                                  //     child: Text(
                                  //       // "test",
                                  //       item.city.toString(),
                                  //       overflow: TextOverflow.ellipsis,maxLines: 5,),
                                  //   )).toList(),
                                  //   // isExpanded: false,
                                  //   onChanged: (value) {
                                  //     setState(() {
                                  //       getCountryController.selectCityValue = value!.toString();
                                  //     });
                                  //   },
                                  //   menuMaxHeight: size.height * 0.25,
                                  //   borderRadius: BorderRadius.circular(10),
                                  //   decoration: InputDecoration(
                                  //     contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                  //     hintText: 'Select City',
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
                                  //     if (value == null || value == '') {
                                  //       return 'Please select city';
                                  //     }
                                  //     return null;
                                  //   },
                                  // )
                                  DropdownButtonHideUnderline(
                                    child: DropdownButtonFormField2(
                                      value: getCountryController.selectCityValue,
                                      items: getCountryController.getCityListModel.value.data!.toList()
                                          .map((item) => DropdownMenuItem(
                                        value:
                                        item.id.toString(),
                                        child: Text(
                                          item.city.toString(),
                                          overflow: TextOverflow.ellipsis,maxLines: 5,),
                                      )).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          getCountryController.selectCityValue = value!.toString();
                                        });
                                      },
                                      validator: (value) {
                                        if (value == null || value == '') {
                                          return 'Please select city';
                                        }
                                        return null;
                                      },
                                      isExpanded: true,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 15,
                                      ),
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                                        hintText: 'Select City',
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
                                      dropdownStyleData: DropdownStyleData(
                                        maxHeight: size.height * 0.28,
                                        width: size.width * 0.925,
                                        padding: EdgeInsets.symmetric(horizontal: 5),
                                        isOverButton: false,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(14),
                                          color: Colors.white,
                                        ),

                                        offset: const Offset(2, -10),
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
                                  )

                                  : SizedBox();
                                }),

                                // DropdownMenuTheme(
                                //   data: DropdownMenuThemeData(
                                //     menuStyle: MenuStyle(
                                //       surfaceTintColor: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                //         return Colors.white;
                                //       }),
                                //     ),
                                //     textStyle: TextStyle(
                                //         color: Colors.grey,
                                //         fontSize: AddSize.font14),
                                //     inputDecorationTheme: InputDecorationTheme(
                                //       alignLabelWithHint: true,
                                //       floatingLabelAlignment: FloatingLabelAlignment.center,
                                //       // floatingLabelAlignment: ,
                                //       constraints: BoxConstraints(
                                //         maxHeight: 50,
                                //         // minHeight: 30
                                //       ),
                                //       contentPadding: EdgeInsets.only(left: 15),
                                //       hintStyle: TextStyle(
                                //         color: Colors.grey,
                                //         fontSize: AddSize.font14,),
                                //       enabledBorder: OutlineInputBorder(
                                //           gapPadding: 0.0,
                                //           borderRadius: BorderRadius.circular(50),
                                //           borderSide: BorderSide(
                                //               color: Colors.grey!.withOpacity(0.5),
                                //               width: 1
                                //           )
                                //       ),
                                //     ),
                                //   ),
                                //   child: DropdownMenu<String>(
                                //     width: size.width * 0.93,
                                //     menuHeight: size.height * 0.3,
                                //     hintText: 'Select City',
                                //     textStyle:  TextStyle(
                                //         color: Colors.grey,
                                //         fontSize: AddSize.font14),
                                //     onSelected: (String? value) {
                                //       getCountryController.selectCityValue = value!;
                                //       print(value);
                                //     },
                                //     trailingIcon: const Icon(Icons.keyboard_arrow_down),
                                //     dropdownMenuEntries: getCountryController.getCityListModel.value.data!.toList().map((value) {
                                //       return DropdownMenuEntry(value: value.id.toString(), label: value.city.toString());
                                //     }).toList(),
                                //   ),
                                // ),
                              ],
                            )

                            // Container(
                            // height: 55,
                            // width: Get.width,
                            // decoration: BoxDecoration(
                            // borderRadius: BorderRadius.circular(50),
                            // border: Border.all(
                            // color: Colors.grey,
                            // width: 0.5
                            // )
                            // ),
                            // child: DropdownButtonFormField<dynamic>(
                            // focusColor: Colors.white,
                            // isExpanded: true,
                            // validator: (value) {
                            // if (value == null) {
                            // return 'Please enter allergens';
                            // }
                            // return null;
                            // },
                            // iconEnabledColor: const Color(0xff97949A),
                            // icon: const Icon(Icons.keyboard_arrow_down),
                            // hint: Text(
                            // "Select City",
                            // style: TextStyle(
                            // color: Colors.grey,
                            // fontSize: AddSize.font14),
                            // textAlign: TextAlign.justify,
                            // ),
                            // decoration: InputDecoration(
                            // fillColor: const Color(0xFFF2F2F2),
                            // contentPadding:
                            // const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                            // focusedBorder: OutlineInputBorder(
                            // borderSide: const BorderSide(color: Colors.transparent),
                            // borderRadius: BorderRadius.circular(50.0),
                            // ),
                            // enabledBorder: const OutlineInputBorder(
                            // borderSide: BorderSide(color: Colors.transparent),
                            // borderRadius:
                            // BorderRadius.all(Radius.circular(50.0)))),
                            // value: getCountryController.selectCityValue,
                            // items: getCountryController.getCityListModel.value.data!.toList().map((value) {
                            // return DropdownMenuItem(
                            // value: value.id.toString(),
                            // child: Text(
                            // value.city.toString(),
                            // style: TextStyle(
                            // color: Colors.grey,
                            // fontSize: AddSize.font14),
                            // ),
                            // );
                            // }).toList(),
                            // onChanged: (newValue) {
                            // setState(() {
                            // getCountryController.selectCityValue = newValue!;
                            // });
                            // },
                            // ),
                            // )

                                : SizedBox();
                            }),

                            // Container(
                            //   height: 55,
                            //   width: Get.width,
                            //   decoration: BoxDecoration(
                            //       borderRadius: BorderRadius.circular(50),
                            //       border: Border.all(
                            //           color: Colors.grey,
                            //           width: 0.5
                            //       )
                            //   ),
                            //   child: PopupMenuButton<String>(
                            //     shape: Border.all(
                            //         color: AppThemes.primaryColor
                            //     ),
                            //     onSelected: (String newValue) {
                            //       setState(() {
                            //         optionCity = newValue;
                            //       });
                            //     },
                            //     itemBuilder: (BuildContext context) {
                            //       return optionCityItems.map((String item) {
                            //         return PopupMenuItem<String>(
                            //           value: item,
                            //           child: Text(
                            //             item,
                            //             style: const TextStyle(color: AppThemes.black, fontSize: 14),
                            //           ),
                            //         );
                            //       }).toList();
                            //     },
                            //     child: ListTile(
                            //       title: Text(
                            //         optionCity,
                            //         style: const TextStyle(
                            //           color: Colors.grey,
                            //           fontSize: 16,
                            //           fontWeight: FontWeight.w300,
                            //         ),
                            //         textAlign: TextAlign.justify,
                            //       ),
                            //       trailing: const Icon(Icons.keyboard_arrow_down),
                            //     ),
                            //   ),
                            //   // DropdownButtonFormField(
                            //   //   focusColor: Colors.grey.shade50,
                            //   //   isExpanded: true,
                            //   //   iconEnabledColor: const Color(0xff97949A),
                            //   //   icon: const Icon(Icons.keyboard_arrow_down),
                            //   //   hint: Text(
                            //   //     religion,
                            //   //     style: const TextStyle(
                            //   //         color: Color(0xff463B57),
                            //   //         fontSize: 16,
                            //   //         fontWeight: FontWeight.w300),
                            //   //     textAlign: TextAlign.justify,
                            //   //   ),
                            //   //   decoration: InputDecoration(
                            //   //       fillColor: Colors.grey.shade50,
                            //   //       contentPadding: const EdgeInsets.symmetric(
                            //   //           horizontal: 20, vertical: 10),
                            //   //       focusedBorder: OutlineInputBorder(
                            //   //         borderSide:
                            //   //         BorderSide(color: Colors.grey.shade300),
                            //   //         borderRadius: BorderRadius.circular(25.0),
                            //   //       ),
                            //   //       enabledBorder: const OutlineInputBorder(
                            //   //           borderSide:
                            //   //           BorderSide(color: Color(0xffE3E3E3)),
                            //   //           borderRadius:
                            //   //           BorderRadius.all(Radius.circular(25.0)))),
                            //   //   value: religion,
                            //   //   items: religionItems.map((String items) {
                            //   //     return DropdownMenuItem(
                            //   //       value: items,
                            //   //       child: Text(
                            //   //         items,
                            //   //         style: const TextStyle(
                            //   //             color: Colors.grey, fontSize: 14),
                            //   //       ),
                            //   //     );
                            //   //   }).toList(),
                            //   //   onChanged: (String? newValue) {
                            //   //     setState(() {
                            //   //       religion = newValue!;
                            //   //     });
                            //   //   },
                            //   // ),
                            // ),
                            //
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
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(6),
                                  FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                                ],
                                validator: MultiValidator([
                                  RequiredValidator(errorText: 'Please Enter pincode'),
                                  LengthRangeValidator(min: 6, max: 6, errorText: "Please enter at least 6 character")
                                ]),
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            SizedBox(
                              width: double.maxFinite,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    primary: AppThemes.primaryColor,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 50, vertical: 13),
                                    textStyle: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w500)),
                                onPressed: () {
                                  if (_formKeyResidential.currentState!
                                      .validate()) {
                                    kk = 0.4;
                                    setState(() {});
                                  }
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              if (kk == 0.4)
                Container(
                  // height: Get.height,
                  decoration: const BoxDecoration(
                    borderRadius:
                    BorderRadius.only(topRight: Radius.circular(50)),
                    color: Colors.white,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      // controller: _scrollController1,
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

                            CommonTextfield(
                              obSecure: false,
                              hintText: 'Enter class',
                              controller: classPrevCon,
                              keyboardType: TextInputType.name,
                              validator: MultiValidator([
                                RequiredValidator(
                                    errorText:
                                    'Please Enter class'),

                              ]),
                            ),
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
                            CommonTextfield(
                              obSecure: false,
                              hintText: 'Enter year',
                              controller: yearprevSchoolCon,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(2),
                                FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                              ],
                              validator: MultiValidator([
                                RequiredValidator(errorText: 'Please enter years'),
                              ]),
                            ),
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
                              height: 50,
                            ),
                          ],
                        ),
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
                            hintText: 'Enter Qualification',
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
                          // Container(
                          //   height: 55,
                          //   width: Get.width,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       border: Border.all(
                          //           color: Colors.grey,
                          //           width: 0.5
                          //       )
                          //   ),
                          //   child: PopupMenuButton<String>(
                          //     shape: Border.all(
                          //         color: AppThemes.primaryColor
                          //     ),
                          //     onSelected: (String newValue) {
                          //       setState(() {
                          //         organization = newValue;
                          //       });
                          //     },
                          //     itemBuilder: (BuildContext context) {
                          //       return organizationItem.map((String item) {
                          //         return PopupMenuItem<String>(
                          //           value: item,
                          //           child: Text(
                          //             item,
                          //             style: const TextStyle(color: AppThemes.black, fontSize: 14),
                          //           ),
                          //         );
                          //       }).toList();
                          //     },
                          //     child: ListTile(
                          //       title: Text(
                          //         organization,
                          //         style: const TextStyle(
                          //           color: Colors.grey,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w300,
                          //         ),
                          //         textAlign: TextAlign.justify,
                          //       ),
                          //       trailing: const Icon(Icons.keyboard_arrow_down),
                          //     ),
                          //   ),
                          //   // DropdownButtonFormField(
                          //   //   focusColor: Colors.grey.shade50,
                          //   //   isExpanded: true,
                          //   //   iconEnabledColor: const Color(0xff97949A),
                          //   //   icon: const Icon(Icons.keyboard_arrow_down),
                          //   //   hint: Text(
                          //   //     religion,
                          //   //     style: const TextStyle(
                          //   //         color: Color(0xff463B57),
                          //   //         fontSize: 16,
                          //   //         fontWeight: FontWeight.w300),
                          //   //     textAlign: TextAlign.justify,
                          //   //   ),
                          //   //   decoration: InputDecoration(
                          //   //       fillColor: Colors.grey.shade50,
                          //   //       contentPadding: const EdgeInsets.symmetric(
                          //   //           horizontal: 20, vertical: 10),
                          //   //       focusedBorder: OutlineInputBorder(
                          //   //         borderSide:
                          //   //         BorderSide(color: Colors.grey.shade300),
                          //   //         borderRadius: BorderRadius.circular(25.0),
                          //   //       ),
                          //   //       enabledBorder: const OutlineInputBorder(
                          //   //           borderSide:
                          //   //           BorderSide(color: Color(0xffE3E3E3)),
                          //   //           borderRadius:
                          //   //           BorderRadius.all(Radius.circular(25.0)))),
                          //   //   value: religion,
                          //   //   items: religionItems.map((String items) {
                          //   //     return DropdownMenuItem(
                          //   //       value: items,
                          //   //       child: Text(
                          //   //         items,
                          //   //         style: const TextStyle(
                          //   //             color: Colors.grey, fontSize: 14),
                          //   //       ),
                          //   //     );
                          //   //   }).toList(),
                          //   //   onChanged: (String? newValue) {
                          //   //     setState(() {
                          //   //       religion = newValue!;
                          //   //     });
                          //   //   },
                          //   // ),
                          // ),
                          CommonTextfield(
                            hintText: 'Enter Organization',
                            obSecure: false,
                            readOnly: false,
                            keyboardType: TextInputType.text,
                            controller: organizationController,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter Organization'),

                            ]),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            validator: MultiValidator([
                            RequiredValidator(
                                  errorText:
                                  'Please Enter father\'s aadhar number'),
                              LengthRangeValidator(min: 12, max: 12, errorText: "Please enter at least 12 character"),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 13),
                                  textStyle: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500)),
                              onPressed: () {
                                if (_formKeyFathers.currentState!.validate()) {
                                  kk = 0.8;
                                  setState(() {});
                                }
                              },
                              child: const Text(
                                'Continue',
                                style: TextStyle(color: Colors.white),
                              ),
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
                          // Container(
                          //   height: 55,
                          //   width: Get.width,
                          //   decoration: BoxDecoration(
                          //       borderRadius: BorderRadius.circular(50),
                          //       border: Border.all(
                          //           color: Colors.grey,
                          //           width: 0.5
                          //       )
                          //   ),
                          //   child: PopupMenuButton<String>(
                          //     shape: Border.all(
                          //         color: AppThemes.primaryColor
                          //     ),
                          //     onSelected: (String newValue) {
                          //       setState(() {
                          //         organization = newValue;
                          //       });
                          //     },
                          //     itemBuilder: (BuildContext context) {
                          //       return organizationItem.map((String item) {
                          //         return PopupMenuItem<String>(
                          //           value: item,
                          //           child: Text(
                          //             item,
                          //             style: const TextStyle(color: AppThemes.black, fontSize: 14),
                          //           ),
                          //         );
                          //       }).toList();
                          //     },
                          //     child: ListTile(
                          //       title: Text(
                          //         organization,
                          //         style: const TextStyle(
                          //           color: Colors.grey,
                          //           fontSize: 16,
                          //           fontWeight: FontWeight.w300,
                          //         ),
                          //         textAlign: TextAlign.justify,
                          //       ),
                          //       trailing: const Icon(Icons.keyboard_arrow_down),
                          //     ),
                          //   ),
                          //   // DropdownButtonFormField(
                          //   //   focusColor: Colors.grey.shade50,
                          //   //   isExpanded: true,
                          //   //   iconEnabledColor: const Color(0xff97949A),
                          //   //   icon: const Icon(Icons.keyboard_arrow_down),
                          //   //   hint: Text(
                          //   //     religion,
                          //   //     style: const TextStyle(
                          //   //         color: Color(0xff463B57),
                          //   //         fontSize: 16,
                          //   //         fontWeight: FontWeight.w300),
                          //   //     textAlign: TextAlign.justify,
                          //   //   ),
                          //   //   decoration: InputDecoration(
                          //   //       fillColor: Colors.grey.shade50,
                          //   //       contentPadding: const EdgeInsets.symmetric(
                          //   //           horizontal: 20, vertical: 10),
                          //   //       focusedBorder: OutlineInputBorder(
                          //   //         borderSide:
                          //   //         BorderSide(color: Colors.grey.shade300),
                          //   //         borderRadius: BorderRadius.circular(25.0),
                          //   //       ),
                          //   //       enabledBorder: const OutlineInputBorder(
                          //   //           borderSide:
                          //   //           BorderSide(color: Color(0xffE3E3E3)),
                          //   //           borderRadius:
                          //   //           BorderRadius.all(Radius.circular(25.0)))),
                          //   //   value: religion,
                          //   //   items: religionItems.map((String items) {
                          //   //     return DropdownMenuItem(
                          //   //       value: items,
                          //   //       child: Text(
                          //   //         items,
                          //   //         style: const TextStyle(
                          //   //             color: Colors.grey, fontSize: 14),
                          //   //       ),
                          //   //     );
                          //   //   }).toList(),
                          //   //   onChanged: (String? newValue) {
                          //   //     setState(() {
                          //   //       religion = newValue!;
                          //   //     });
                          //   //   },
                          //   // ),
                          // ),
                          CommonTextfield(
                            hintText: 'Enter Organization',
                            obSecure: false,
                            readOnly: false,
                            keyboardType: TextInputType.number,
                            controller: organizationController1,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter Organization'),

                            ]),
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
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(12),
                              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                            ],
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter mother\'s aadhar number'),
                              LengthRangeValidator(min: 12, max: 12, errorText: "Please enter at least 12 character"),
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
                  height: Get.height,
                  // height: AddSize.screenHeight,
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

                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Class Name',
                            controller: schoolSibblingCon,
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter Class Name'),

                            ]),
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
                                addMissionRepo(context: context,appliedForId: 1,appliedFor: 'School',name: stNameController.text.trim(),
                                  fatherName: fatherNameController.text.trim(),motherName: motherNameController.text.trim(),dob: dobController.text.trim(),
                                  category: category.toString(),adharNo: adharcardNo.text.trim(),
                                  gender: gender.toString(), motherTongue: 'hindi',bloodGroup: bloodGroup.text.trim(),religion: 'hindhu',nationality: 'indian',
                                  address: addressController.text.trim(),state: 'raj',city: 'hmh',pincode: pincodeController.text.trim(),previous_school_name: schoolNameController.text.trim(),
                                  location: locationController.text.trim(),classprev: classPrevCon.text.trim(),yearOfStudy: yearprevSchoolCon.text.trim(),
                                  percentage: percentageController.text.trim(),father_name: fatherNameController.text.trim(),occupation: occupationController.text.trim(),
                                  organization: organizationController.text.trim(),mobile_number: mobileNOController.text.trim(),aadhar_number: aadharController.text.trim(),
                                  email_father: emailIdController.text.trim(),annual_income_father: annualIncomeController.text.trim(),landline_number: landlineNOController.text.trim(),
                                  mother_name: motherNameController.text.trim(),occupation_mother: occupationController.text.trim(),
                                  organization_mother: organizationController.text.trim(),mobile_mother: mobileNOController.text.trim(),
                                  aadhar_mother: aadharController.text.trim(),email_mother: emailIdController.text.trim(),annual_income_mother: annualIncomeController.text.trim(),
                                  landline_mother: landlineNOController.text.trim(),name_sibling: siblingController.text.trim(),class_school_sibling: classPrevCon.text.trim(),
                                  class_sibling: schoolSibblingCon.text.trim()
                                ).then((value) {
                                  if(value.status == true){
                                    showToast(value.msg.toString().toString());
                                    Get.toNamed(MyRouters.drawerForUser);
                                  }else{
                                    showToast(value.msg.toString().toString());
                                  }
                                });
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
        )
    );
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
