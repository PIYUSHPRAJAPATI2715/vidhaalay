import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/widgets/appTheme.dart';
import 'package:vidhaalay_app/widgets/common_textfield.dart';

class SiblingInfo {
  String? name;
  String? className;
  String? schoolName;

  SiblingInfo({this.name, this.className, this.schoolName});

  SiblingInfo.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    className = json['className'];
    schoolName = json['schoolName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['className'] = this.className;
    data['schoolName'] = this.schoolName;
    return data;
  }
}


class MyFormPage extends StatefulWidget {
  @override
  _MyFormPageState createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  List<SiblingInfo> siblingInfoList = [
    SiblingInfo(name: '', className: '', schoolName: ''),
  ];

  // final _formKeySibling = List.generate(10, (index) => GlobalKey<FormState>());

  List<GlobalKey<FormState>> formKeySibling = [];
  List<TextEditingController> siblingNameControllers = [];
  List<TextEditingController> siblingClassControllers = [];
  List<TextEditingController> siblingSchoolControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    formKeySibling =
        siblingInfoList.map((_) => GlobalKey<FormState>()).toList();
    siblingNameControllers =
        siblingInfoList.map((_) => TextEditingController()).toList();
    siblingClassControllers =
        siblingInfoList.map((_) => TextEditingController()).toList();
    siblingSchoolControllers =
        siblingInfoList.map((_) => TextEditingController()).toList();

    // for (int i = 0; i < siblingInfoList.length; i++) {
    //   siblingNameControllers[i].text = siblingInfoList[i].name ?? '';
    //   siblingClassControllers[i].text = siblingInfoList[i].className ?? '';
    //   siblingSchoolControllers[i].text = siblingInfoList[i].schoolName ?? '';
    // }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Sibling Information'),
      ),
      body: Column(
        children: [
          Container(
            height: size.height * 0.75,
            width: size.width,
            child: ListView.builder(
              itemCount: siblingInfoList.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: formKeySibling[index],
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text('Sibling ${index + 1}',
                          //     style:
                          //     TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                          // TextField(
                          //   controller: siblingNameControllers[index],
                          //   decoration: InputDecoration(labelText: 'Name'),
                          //   onChanged: (value) {
                          //     siblingInfoList[index].name = siblingNameControllers[index].text;
                          //     printList();
                          //   },
                          // ),
                          // SizedBox(height: 10),
                          // TextField(
                          //   controller: siblingClassControllers[index],
                          //   decoration: InputDecoration(labelText: 'Class'),
                          //   onChanged: (value) {
                          //     siblingInfoList[index].name = siblingNameControllers[index].text;
                          //     printList();
                          //   },
                          // ),

                          // TextField(
                          //   controller: siblingSchoolControllers[index],
                          //   decoration: InputDecoration(labelText: 'School'),
                          // ),
                          // SizedBox(height: 10),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Sibling ${(index + 1).toString()}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.black)),
                              IconButton(
                                  onPressed: () {
                                    _deleteSiblingInfo(index);
                                    isFieldEmpty();
                                  }, icon: const Icon(Icons.delete,color: Colors.red,size: 19,)
                              ),
                            ],
                          ),

                          SizedBox(height: 10),

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
                            controller: siblingNameControllers[index],
                            keyboardType: TextInputType.name,
                            obSecure: false,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter sibling\'s name'),

                            ]),
                            onChanged: (value) {
                              siblingInfoList[index].name = siblingNameControllers[index].text;
                              printList();
                            },
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
                          SizedBox(height: 10),
                          CommonTextfield(
                            obSecure: false,
                            hintText: 'Enter Class Name',
                            controller: siblingClassControllers[index],
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter Class Name'),
                            ]),
                            onChanged: (value) {
                              siblingInfoList[index].className = siblingClassControllers[index].text;
                              printList();
                            },
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
                            controller: siblingSchoolControllers[index],
                            keyboardType: TextInputType.name,
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText:
                                  'Please Enter colage\'s name'),
                            ]),
                            onChanged: (value) {
                              siblingInfoList[index].schoolName = siblingSchoolControllers[index].text;
                              printList();
                            },
                          ),

                          Visibility(
                              visible: index == siblingInfoList.length -1 ,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: GestureDetector(
                                  onTap: () async {
                                    bool isFieldEmpty0 = await isFieldEmpty();
                                    print("isFieldEmpty0 : $isFieldEmpty0");

                                    if(!isFieldEmpty0) {
                                      _addSiblingInfo();
                                    }
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,

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
                                ),
                              ),
                          )
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     ElevatedButton(
                          //       onPressed: () {
                          //         _updateSiblingInfo(index);
                          //       },
                          //       child: Text('Update'),
                          //     ),
                          //     ElevatedButton(
                          //       onPressed: () {
                          //         _deleteSiblingInfo(index);
                          //       },
                          //       style: ButtonStyle(
                          //         backgroundColor:
                          //         MaterialStateProperty.all(Colors.red),
                          //       ),
                          //       child: Text('Delete'),
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: isFieldEmpty,
        child: Icon(Icons.mark_as_unread),
      ),
    );
  }

  Future<bool> isFieldEmpty() async {
    List<bool> booleanList = [];

    for (int i = 0; i < siblingInfoList.length; i++) {
      print(i);
      bool isValid = formKeySibling[i].currentState!.validate();
      booleanList.add(isValid);
    }
    print(booleanList);

    bool result = booleanList.contains(false);
    print(result);

    return await result;
  }

  void _addSiblingInfo() {
    setState(() {
      siblingInfoList.add(SiblingInfo());
      formKeySibling.add(GlobalKey<FormState>());
      siblingNameControllers.add(TextEditingController());
      siblingClassControllers.add(TextEditingController());
      siblingSchoolControllers.add(TextEditingController());
      printList();
    });
  }

  void printList() {
    List<Map<String, dynamic>> listMap =
    siblingInfoList.map((model) => model.toJson()).toList();
    print("submitSiblingInfo : $listMap");
  }

  void _updateSiblingInfo(int index) {
    setState(() {
      siblingInfoList[index].name = siblingNameControllers[index].text;
      siblingInfoList[index].className = siblingClassControllers[index].text;
      siblingInfoList[index].schoolName = siblingSchoolControllers[index].text;
      printList();
    });
  }

  void _deleteSiblingInfo(int  index) {
    setState(() {
      siblingInfoList.removeAt(index);
      siblingNameControllers.removeAt(index).dispose();
      siblingClassControllers.removeAt(index).dispose();
      siblingSchoolControllers.removeAt(index).dispose();
      printList();
    });
  }

}
