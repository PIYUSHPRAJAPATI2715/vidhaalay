import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vidhaalay_app/controller/authentication/signin_controller.dart';
import 'package:vidhaalay_app/models/multi_login_model.dart';
import 'package:vidhaalay_app/repositories/multi_login_repo.dart';
import 'package:vidhaalay_app/resourses/app_assets.dart';
import 'package:vidhaalay_app/routers/my_routers.dart';
import 'package:vidhaalay_app/screen/bottom_navbar_screen.dart';
import '../../widgets/appTheme.dart';
import '../controller/common.dart';
import '../repositories/login_repo.dart';
import '../repositories/social_login_repo.dart';
import '../resourses/api_constant.dart';
import '../widgets/common_textfield.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInController = Get.put(SignInController());
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // String userType = 'user';
  // var userTypeitems = [
  //   'Institute Finding',
  //   'Faculty Login',
  //   'Student Login',
  // ];

  // RxBool isPasswordShow = true.obs;
  // RxBool checkboxColor = false.obs;
  // bool showValidation = false;

  // String _displayedValue = '';

  // String getDeviceType() {
  //   if (Platform.isAndroid) {
  //     return 'A';
  //   } else if (Platform.isIOS) {
  //     return 'I';
  //   } else {
  //     return 'Unknown';
  //   }
  //
  // }
  //
  // void getDevice(){
  //   print('type is ${getDeviceType().toString()}');
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    signInController.getDeviceInfo();
    // getDeviceType();
    // getDevice();
  }

  @override
  void dispose() {
    super.dispose();
  }

  // void updateDisplayedValue(String input) {
  //   if (input.isEmpty) {
  //     setState(() {
  //       _displayedValue = '';
  //     });
  //   }
  //   else if (int.tryParse(input) != null ) {
  //     setState(() {
  //       _displayedValue = '+91';
  //     });
  //   } else {
  //     setState(() {
  //       _displayedValue = '';
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Obx(
        () => Form(
          key: signInController.formKey,
          child: Stack(
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
                height: 220,
                decoration: const BoxDecoration(
                  color: AppThemes.signupBg,
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(70)),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.only(bottomLeft: Radius.circular(60)),
                  child: Image.asset(
                    AppAssets.signIn,
                    fit: BoxFit.fitWidth,
                    width: double.maxFinite,
                  ),
                ),
              ),
              Positioned.fill(
                top: 220,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  height: size.height,
                  width: size.width,
                  decoration: const BoxDecoration(
                    color: AppThemes.white,
                    borderRadius:
                        BorderRadius.only(topRight: Radius.circular(60)),
                  ),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 30,
                        ),
                        const Text(
                          "Welcome Back!",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w800),
                        ),
                        const Text(
                          "Hello please login to continue",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: AppThemes.textGray,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  signInWithGoogle();
                                },
                                child: Expanded(
                                    child: Container(
                                  height: size.height * .049,
                                  width: size.width * .41,
                                  // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          'assets/images/google_logo.png',
                                          height: 25,
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "Google",
                                          style: TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w600,
                                            color: AppThemes.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )),
                              ),
                              SizedBox(
                                width: size.width * .060,
                              ),
                              InkWell(
                                onTap: () {
                                  // signInWithGoogle();
                                  signInFaceBook();
                                },
                                child: Expanded(
                                    child: Container(
                                  height: size.height * .049,
                                  width: size.width * .41,
                                  // padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(50),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        'assets/images/facbook_image.png',
                                        height: 25,
                                      ),
                                      const SizedBox(
                                        width: 6,
                                      ),
                                      const Text(
                                        "Facebook",
                                        style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: AppThemes.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.020,
                        ),
                        const Center(
                          child: Text(
                            "or login with",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: AppThemes.textGray,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.030,
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
                              hintText: 'Select Role',
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
                            value: signInController.userType.value,
                            items: signInController.userTypeData.map((Map items) {
                              return DropdownMenuItem(
                                value: items['key'].toString(),
                                child : Text(
                                  items['value'].toString(),
                                  style: const TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) {
                              print(value);
                              signInController.userType.value =
                                  value.toString();
                              // setState(() {
                              // });
                            },
                            validator: (value) {
                              print("validator :  $value");
                              if (value == null || value.isEmpty) {
                                return 'Please select role';
                              } else {
                                return null;
                              }
                            },
                            dropdownStyleData: DropdownStyleData(
                              maxHeight: size.height * 0.28,
                              width: size.width * 0.90,
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
                        const SizedBox(
                          height: 10,
                        ),

                        const Text(
                          "Unique Id,Mobile No./Email Id",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.black,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CommonTextfield(
                          // prefix: Column(
                          //   crossAxisAlignment: CrossAxisAlignment.center,
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     Text(_displayedValue,textAlign: TextAlign.center,),
                          //   ],
                          // ),
                          // onChanged: (text) {
                          //   // updateDisplayedValue(text);
                          // },
                          hintText: 'Enter Email or Phone or Unique ID',
                          obSecure: false,
                          controller: signInController.emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Email or Phone or Unique ID is required";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: size.height * 0.025,
                        ),
                        const Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppThemes.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.010,
                        ),
                        CommonTextfield(
                            controller: signInController.passwordController,
                            obSecure: signInController.isPasswordVisibile.value,
                            hintText: "Password",
                            validator: MultiValidator([
                              RequiredValidator(
                                  errorText: 'Password is required'),
                              MinLengthValidator(8,
                                  errorText:
                                      'Password must be at least 8 digits long'),
                              PatternValidator(
                                  r"(?=.*[A-Z])(?=.*\W)(?=.*?[#?!@$%^&*-])(?=.*[0-9])",
                                  errorText:
                                      'Password must be minimum 8 characters,with 1 Capital letter 1 special character & 1 numerical.')
                            ]),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                signInController.isPasswordVisibile.value =
                                    !signInController.isPasswordVisibile.value;
                              },
                              child: Icon(
                                  signInController.isPasswordVisibile.value
                                      ? CupertinoIcons.eye_slash_fill
                                      : CupertinoIcons.eye,
                                  size: 20,
                                  color: Colors.grey),
                            )),
                        SizedBox(
                          height: size.height * 0.016,
                        ),
                        InkWell(
                          onTap: () {
                            Get.toNamed(MyRouters.forgotPasswordScreen);
                          },
                          child: const Center(
                            child: Text(
                              "Forgot Password?",
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppThemes.black,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100 * 0.2,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // String? token = await FirebaseMessaging.instance.getToken();
                            if (signInController.formKey.currentState!.validate()) {
                              FocusManager.instance.primaryFocus!.unfocus();
                              signInController.login(context: context,email: signInController.emailController.text,
                                type:  signInController.userType.value,
                                pass: signInController.passwordController.text,
                              );
                            }
                            // _showMultiLoginAlertDialog(context);
                          },
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.maxFinite, 0),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            backgroundColor: AppThemes.primaryColor,
                          ),
                          child: Text(
                            "login".toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 100 * 0.3,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppThemes.black,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // printAllRecord();
                                Get.toNamed(MyRouters.signupScreen);
                              },
                              child: Text(
                                " create account".toUpperCase(),
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppThemes.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 100 * 0.1,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showMultiLoginAlertDialog(BuildContext context) async {
    final signInController = Get.put(SignInController());

    List<MultiLoginModel> loginData =
    [
      MultiLoginModel(userName: "teacher",email: "teachermk@yopmail.com",type :"teacher",password: "12@Mckumar", token: 'test1'),
      MultiLoginModel(userName: "student1",email: "student6@yopmail.com",type :"student",password: "12@Mckumar", token: 'test2'),
      MultiLoginModel(userName: "student2",email: "student7@yopmail.com",type :"student",password: "User@1234", token: 'test2'),
      // MultiLoginModel(userName: "user1",email: "student7@yopmail.com",type :"user",password: "User@123", token: 'test2'),
      // MultiLoginModel(userName: "student1",email: "sumits@yopmail.com",type :"student",password: "12@Mckumar", token: 'test2'),
      MultiLoginModel(userName: "user",email: "mkm@mk.com",type :"user",password: "12@Mckumar", token: 'test3'),
      MultiLoginModel(userName: "user",email: "usert@yopmail.com",type :"user",password: "User@123", token: 'test3'),
    ];
    print("loginData : $loginData");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // titlePadding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          contentPadding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
          title: Text('Switch Account',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: AppThemes.black,
            ),
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: loginData.length, // Set your itemCount according to your data
              itemBuilder: (BuildContext context, int index) {
                var items = loginData[index];

                return Column(
                  children: [
                    Divider(
                      thickness: 1.0,
                      height: 2,
                    ),
                    ListTile(
                      // dense: true,
                      visualDensity: VisualDensity(vertical: -3),
                      // contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 0),
                      leading: Icon(Icons.person),
                      title: Text(items.userName!),
                      subtitle: Text(items.email!),
                      onTap: () {
                        signInController.login(context: context,email: items.email!,
                          type: items.type!,
                          pass: items.password!,
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }


  // signInWithGoogle() async {
  //   await GoogleSignIn().signOut();
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn().catchError((e){
  //     throw Exception(e);
  //   });
  //
  //   log(googleUser!.email.toString());
  //
  //   final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
  //   final credential = GoogleAuthProvider.credential(
  //     idToken: googleAuth.idToken,
  //     accessToken: googleAuth.accessToken,
  //   );
  //   final value = await FirebaseAuth.instance.signInWithCredential(credential);
  //   log(value.credential!.accessToken!);
  //   //log(value.additionalUserInfo.a);
  //   var fromToken = await FirebaseMessaging.instance.getToken();
  //
  //   socialLogin(provider: "google", token: value.credential!.accessToken!, context: context).then((value) async {
  //     if (value.status == true) {
  //       SharedPreferences pref = await SharedPreferences.getInstance();
  //       pref.setString('user_info', jsonEncode(value));
  //       showToast(message:value.message.toString());
  //       // Get.offAllNamed(MyRouters.bottomNavbar);
  //     } else {
  //       showToast(message:value.message.toString());
  //     }
  //   });
  // }
  signInWithGoogle() async {
    await GoogleSignIn().signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    print("Token----------${googleAuth.accessToken}");
    print("Token---------${googleUser.email.toString()}");
    final value = await FirebaseAuth.instance.signInWithCredential(credential);
    log(value.credential!.accessToken!);

    String deviceToken = (await FirebaseMessaging.instance.getToken())!;

    socialLogin(
            photo: googleUser.photoUrl.toString(),
            context: context,
            email: googleUser.email.toString(),
            name: googleUser.displayName.toString(),
            deviceType: signInController.deviceType.toString(),
            soGoogle: '1')
        .then((value) async {
      if (value.status == true) {
        MultiLoginModel data = MultiLoginModel(image:  googleUser.photoUrl.toString(),isSocialLogin: true,userName: value.data!.name.toString(),email: value.data!.email.toString(),type :"user",password: "", token: value.data!.token!);
        saveLoginData(data);

        SharedPreferences pref = await SharedPreferences.getInstance();
        pref.setString('user_info', jsonEncode(value));
        pref.setString('cookie', value.data!.token.toString());
        pref.setString('id', value.data!.id.toString());
        pref.setString('type', value.data!.userType.toString());
        pref.setString('username', value.data!.name.toString());
        pref.setString('email', value.data!.email.toString());
        pref.setBool('isLoggedIn', true);
        // Get.offAllNamed(MyRouters.drawerForUser);
        Get.offAll(() => BottomBarScreen(userType: 0,));
        showToast(message:value.msg.toString());
      } else {
        showToast(message:value.msg.toString());
      }
    });
  }

  // loda rent to baki ry gyu

  signInFaceBook() async {
    final LoginResult loginResult = await FacebookAuth.instance.login(
        permissions: ["public_profile", "email"],
        loginBehavior: LoginBehavior.webOnly);
    print("qqqqqqqqqqqq");
    final OAuthCredential oAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    final value = await FirebaseAuth.instance
        .signInWithCredential(oAuthCredential)
        .then((value1) async {
      socialFacebook(
              context: context,
              email: value1.user!.email.toString(),
              name: value1.user!.displayName.toString(),
              deviceType: signInController.deviceType.toString())
          .then((value) async {
        if (value.status == true) {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('user_info', jsonEncode(value));
          pref.setString('cookie', value.data!.token.toString());
          showToast(message:value.msg.toString());
          pref.setBool('isLoggedIn', true);
          // Get.offAllNamed(MyRouters.drawerForUser);
          Get.offAll(() => BottomBarScreen(userType: 0,));
        } else {
          showToast(message:value.msg.toString());
        }
      });
    }).catchError((FirebaseAuthException? e) {
      showToast(message:e.toString());
      throw Exception(e!.message);
    });
    log("Firebase response.... ${value.toString()}");
  }

}
