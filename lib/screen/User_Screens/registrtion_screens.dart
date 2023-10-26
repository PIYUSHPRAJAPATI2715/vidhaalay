import 'package:flutter/material.dart';
import 'package:fx_stepper/fx_stepper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController dobController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  TextEditingController promotion = TextEditingController();
  String number = '';
  int result = 0;
  RxString selectedDate1="".obs;
  var selectedDate = DateTime.now().obs;
  DateTime today = DateTime.now();

  //var selectedDate5 = DateFormat('d').format(selectedDate).toString();
  RxInt difference = 0.obs;
  String dateWithSubtract= "";

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

    if(pickedDate != null){
      DateFormat dateFormat = DateFormat('yyyy-MM-dd');
      dobController.text = dateFormat.format(pickedDate);
    }
  }
  String selectedDate2= "";
  RxInt selectedDate4= 0.obs;
  DateTime currentDate= DateTime.now();
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
    'test1',
    'test2',
  ];
  String religion = 'Select your religion';
  var religionItems = [
    'Select your religion',
    'test1',
    'test2',
  ];
  String nationality = 'Select Nationality';
  var nationalityItems = [
    'Select Nationality',
    'test1',
    'test2',
  ];
  String optionCity = 'Select City';
  var optionCityItems = [
    'Select City',
    'test1',
    'test2',
  ];
  String optionState = 'Select State';
  var optionStateItems = [
    'Select State',
    'test1',
    'test2',
  ];
  String selectClass = 'Select Class';
  var selectClassItems = [
    'Select Class',
    'test1',
    'test2',
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
    'test1',
    'test2',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: FxStepper(
            type: FxStepperType.horizontal,
            elevation: 0,
            controlsBuilder: controlBuilders,
            physics: const ClampingScrollPhysics(),
            onStepTapped: onStepTapped,
            onStepContinue: continueStep,
            onStepCancel: cancelStep,
            currentStep: currentStep,
            steps: [

              FxStep(
                  label:  Column(
                    children: const [
                      Text('Step 1'),
                    ],
                  ),
                  title: const Text(''),
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                       Center(child: Text('Student information'.toUpperCase(),
                           style: const TextStyle(
                               fontWeight: FontWeight.w600,
                               fontSize: 19,
                               color: AppThemes.primaryColor))),
                     const SizedBox(
                        height: 15,
                      ),
                      const Text('Student Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: CommonTextfield(
                          hintText: 'Enter Full Name',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          obSecure: false,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Father\'s Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: CommonTextfield(
                          obSecure: false,
                          hintText: 'Enter Full Name',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Mother\'s Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: CommonTextfield(
                          hintText: 'Enter Full Name',
                          obSecure: false,
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: CommonTextfield(
                          hintText: 'Enter days here',
                          obSecure: false,
                          // validator: MultiValidator([
                          //   RequiredValidator(
                          //       errorText: 'Please Enter The Days'),
                          // ]),
                          // onChanged: (val){
                          //   setState(() {
                          //     difference.value = val ;
                          //     if(val.trim().isEmpty){
                          //       difference.value = '';
                          //       result = 0;
                          //       return;
                          //     }
                          //     int a = int.parse(val);
                          //       result = a*3;
                          //   });
                          // },
                          readOnly: true,
                          keyboardType: TextInputType.number,
                          controller: dobController,
                          onTap: (){
                            selectDate();
                          },
                          suffixIcon: IconButton(
                              onPressed: (){
                                selectDate();
                              },
                              icon: const Icon(Icons.calendar_month)
                          ),
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Gender',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: "female",
                                groupValue: gender,
                                onChanged: (value){
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
                                onChanged: (value){
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
                                onChanged: (value){
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
                      const SizedBox(height: 25,),
                      const Text('Aadhar Card No.',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                        height: 40,
                        child: CommonTextfield(
                          obSecure: false,
                          hintText: 'Enter Card Number',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Category',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        height: 40,
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
                            category,
                            style: const TextStyle(
                                color: Color(0xff463B57),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.justify,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                          value: category,
                          items: categoryitems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              category = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Mother Tongue',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        height: 40,
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
                            motherTongue,
                            style: const TextStyle(
                                color: Color(0xff463B57),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.justify,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding:
                              const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                  borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                          value: motherTongue,
                          items: motherTongueItems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              motherTongue = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Blood Group',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      SizedBox(
                     height: 40,
                        child: CommonTextfield(
                          obSecure: false,
                          hintText: 'Enter Blood Group',
                          controller: nameController,
                          keyboardType: TextInputType.name,
                          /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                        ),
                      ),
                    ],
                  ),
                  isActive: currentStep >= 0,
                  state:
                  currentStep >= 0 ? FxStepState.complete : FxStepState.disabled),
              FxStep(
                title: const Text('Step 2'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text('residential information'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: AppThemes.primaryColor))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Religion',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          religion,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: religion,
                        items: religionItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            religion = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Nationality',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          nationality,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: nationality,
                        items: nationalityItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            nationality = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Residential Address',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Address',
                        obSecure: false,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('City',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          optionCity,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: optionCity,
                        items: optionCityItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            optionCity = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('State',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          optionState,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: optionState,
                        items: optionStateItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            optionState = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Pincode',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Pincode',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep >= 1 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 3'),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text('previous school info'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: AppThemes.primaryColor))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Name of Previous School',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Full Name',
                        obSecure: false,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Location',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter School Location',
                        obSecure: false,
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Class',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: selectClass,
                        items: selectClassItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
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
                    const SizedBox(height: 25,),
                    const Text('Years of study in that school',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          selectYearsStudy,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: selectYearsStudy,
                        items: selectYearsStudyItems.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectYearsStudy = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Percentage/Grade',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Card Number',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep >= 2 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 4'),
                content:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text('father\'s information'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: AppThemes.primaryColor))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Father\'s Qualification',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Full Name',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        obSecure: false,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Occupation',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Father Occupation',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Organization',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          organization,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: organization,
                        items: organizationItem.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            organization = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Mobile Number',
                        obSecure: false,
                        // validator: MultiValidator([
                        //   RequiredValidator(
                        //       errorText: 'Please Enter The Days'),
                        // ]),
                        // onChanged: (val){
                        //   setState(() {
                        //     difference.value = val ;
                        //     if(val.trim().isEmpty){
                        //       difference.value = '';
                        //       result = 0;
                        //       return;
                        //     }
                        //     int a = int.parse(val);
                        //       result = a*3;
                        //   });
                        // },
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        controller: dobController,
                        onTap: (){
                          selectDate();
                        },
                        suffixIcon: IconButton(
                            onPressed: (){
                              selectDate();
                            },
                            icon: const Icon(Icons.calendar_month)
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Aadhar Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Father Aadhar Number',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Email Id',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Father Email Address',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Annual Income',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Father annual Income',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Landline Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Landline Number',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),

                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep >= 3 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 5'),
                content:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text('mother\'s information'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: AppThemes.primaryColor))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Mother\'s Qualification',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Full Name',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        obSecure: false,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Occupation',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Mother Occupation',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Organization',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          organizationMother,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: organizationMother,
                        items: organizationMotherItem.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            organization = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Mobile Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Mobile Number',
                        obSecure: false,
                        // validator: MultiValidator([
                        //   RequiredValidator(
                        //       errorText: 'Please Enter The Days'),
                        // ]),
                        // onChanged: (val){
                        //   setState(() {
                        //     difference.value = val ;
                        //     if(val.trim().isEmpty){
                        //       difference.value = '';
                        //       result = 0;
                        //       return;
                        //     }
                        //     int a = int.parse(val);
                        //       result = a*3;
                        //   });
                        // },
                        readOnly: true,
                        keyboardType: TextInputType.number,
                        controller: dobController,
                        onTap: (){
                          selectDate();
                        },
                        suffixIcon: IconButton(
                            onPressed: (){
                              selectDate();
                            },
                            icon: const Icon(Icons.calendar_month)
                        ),
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Aadhar Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Mother Aadhar Number',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Email Id',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Mother Email Address',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Annual Income',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Mother annual Income',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Landline Number',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter Landline Number',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),

                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep >= 4 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 6'),
                content:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Center(child: Text('sibling information'.toUpperCase(),
                        style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 19,
                            color: AppThemes.primaryColor))),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text('Name',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        hintText: 'Enter Full Name',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        obSecure: false,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('Class',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    Container(
                      height: 40,
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
                          organizationMother,
                          style: const TextStyle(
                              color: Color(0xff463B57),
                              fontSize: 16,
                              fontWeight: FontWeight.w300),
                          textAlign: TextAlign.justify,
                        ),
                        decoration: InputDecoration(
                            fillColor: Colors.grey.shade50,
                            contentPadding:
                            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                borderRadius:
                                BorderRadius.all(Radius.circular(25.0)))),
                        value: selectClassSibbling,
                        items: selectClassSibblingItem.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(
                              items,
                              style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectClassSibbling = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 25,),
                    const Text('School/Collage Currently Studing',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    const SizedBox(height: 10,),
                    SizedBox(
                      height: 40,
                      child: CommonTextfield(
                        obSecure: false,
                        hintText: 'Enter School/Collage Name',
                        controller: nameController,
                        keyboardType: TextInputType.name,
                        /*validator: MultiValidator([
                            RequiredValidator(
                                errorText:
                                'Please Enter Referral Code'),
                            // PatternValidator(r'^[0-9]',
                            //     errorText: 'Only digits are allow'),
                            // MinLengthValidator(10,
                            //     errorText:
                            //         'Phone number must be at list 10 digit'),
                            // MaxLengthValidator(10,
                            //     errorText:
                            //         'Phone number is not greater then 10 digit'),
                          ]),*/
                      ),
                    ),
                    const SizedBox(height: 25,),

                  ],
                ),
                isActive: currentStep >= 0,
                state: currentStep >= 5 ? FxStepState.complete : FxStepState.disabled,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: controlBuilders(context,),
      // ),
    );
  }
  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          ElevatedButton(
            onPressed: details.onStepContinue,
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
}
