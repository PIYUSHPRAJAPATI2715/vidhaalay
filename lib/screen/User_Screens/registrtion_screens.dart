import 'package:flutter/material.dart';
import 'package:fx_stepper/fx_stepper.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:intl/intl.dart';
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
  String productcatvalue = 'Product category';
  var productcatitems = [
    'Product category',
    '350gm',
    '450gm',
    '550gm',
    '650gm',
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
                    children: [
                      Text('Step 1'),
                    ],
                  ),
                  title: const Text(''),
                  content:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Student Name',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey.shade200
                            )]
                        ),
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
                      const Text('Father\'s Name',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey.shade200
                            )]
                        ),
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
                      const Text('Mother\'s Name',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey.shade200
                            )]
                        ),
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
                      const Text('Date of Birth',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      CommonTextfield(
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
                            icon: Icon(Icons.calendar_month)
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Gender',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              Text("Female"),
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
                              Text("Male"),
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
                              Text("Other"),
                            ],
                          ),


                        ],
                      ),
                      const SizedBox(height: 25,),
                      const Text('Aadhar Card No.',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey.shade200
                            )]
                        ),
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
                      const Text('Category',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        height: 60,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(.1, .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField(
                          focusColor: Colors.grey.shade50,
                          isExpanded: true,
                          iconEnabledColor: Color(0xff97949A),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            productcatvalue,
                            style: TextStyle(
                                color: Color(0xff463B57),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.justify,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)))),
                          value: productcatvalue,
                          items: productcatitems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              productcatvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Mother Tongue',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        height: 60,
                        width: Get.width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(11),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade300,
                              offset: const Offset(.1, .1,
                              ),
                              blurRadius: 20.0,
                              spreadRadius: 1.0,
                            ),
                          ],
                        ),
                        child: DropdownButtonFormField(
                          focusColor: Colors.grey.shade50,
                          isExpanded: true,
                          iconEnabledColor: Color(0xff97949A),
                          icon: const Icon(Icons.keyboard_arrow_down),
                          hint: Text(
                            productcatvalue,
                            style: TextStyle(
                                color: Color(0xff463B57),
                                fontSize: 16,
                                fontWeight: FontWeight.w300),
                            textAlign: TextAlign.justify,
                          ),
                          decoration: InputDecoration(
                              fillColor: Colors.grey.shade50,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Color(0xffE3E3E3)),
                                  borderRadius:
                                  const BorderRadius.all(Radius.circular(10.0)))),
                          value: productcatvalue,
                          items: productcatitems.map((String items) {
                            return DropdownMenuItem(
                              value: items,
                              child: Text(
                                items,
                                style: TextStyle(
                                    color: Colors.pink,
                                    fontSize: 14),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              productcatvalue = newValue!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 25,),
                      const Text('Blood Group',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14,color: Colors.black)),
                      const SizedBox(height: 10,),
                      Container(
                        decoration: BoxDecoration(
                            boxShadow: [BoxShadow(
                                spreadRadius: 1,
                                blurRadius: 15,
                                color: Colors.grey.shade200
                            )]
                        ),
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
                content: const Text('This is the Second step.'),
                isActive: currentStep >= 0,
                state: currentStep >= 1 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 3'),
                content: const Text('This is the Third step.'),
                isActive: currentStep >= 0,
                state: currentStep >= 2 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 4'),
                content: const Text('This is the Third step.'),
                isActive: currentStep >= 0,
                state: currentStep >= 3 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 5'),
                content: const Text('This is the Third step.'),
                isActive: currentStep >= 0,
                state: currentStep >= 4 ? FxStepState.complete : FxStepState.disabled,
              ),
              FxStep(
                title: const Text('Step 6'),
                content: const Text('This is the Third step.'),
                isActive: currentStep >= 0,
                state: currentStep >= 5 ? FxStepState.complete : FxStepState.disabled,
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: Container(
      //   height: 50,
      //   child: controlBuilders,
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
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}
