import 'dart:convert';
import 'package:allo_prikool/VIEW/Auth/sign_up.dart';
import 'package:allo_prikool/VIEW/Worker/sign_in_member.dart';
import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/bottomNavWorker.dart';
import 'package:allo_prikool/VIEW/Worker/sign_up_worker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../OtherScreen/term_condition_screen.dart';
import '../User/HomeNavScreen/bottomNav_screen.dart';
import '../components/app_style.dart';
import 'forgetPassword.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  void ValidateEmail(String email) {
    bool isvalid = EmailValidator.validate(email);
    userData.write('isvalid', isvalid);
    if (isvalid == false) {
      Fluttertoast.showToast(
          msg: LocaleKeys.Enter_the_correct_email_address.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
    }
  }

  final _kind = [
    LocaleKeys.Are__user_or_a_technical_worker.tr(),
    "User",
    "Worker"
  ];
  String? _selectvalue = LocaleKeys.Are__user_or_a_technical_worker.tr();
  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();

  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  var formKey = GlobalKey<FormState>();
  final userData = GetStorage();
  void login(
    String email,
    String password,
    String fcmToken,
  ) async {
    try {
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site20.atempurl.com/api/Auth/Login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
            "deviceToken": fcmToken,
            "Role": "User"
          }));
      var data = jsonDecode(response.body.toString());

      if (response.statusCode == 200) {
        userData.write('fcm', fcmToken);
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        var log = json.decode(response.body);

        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var userName = payload['Name'];
        var Email = payload['Email'];
        var PhoneNumber = payload['PhoneNumber'];

        userData.write('isLogged', true);
        userData.write('role', true);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('Name', payload['Name']);
        userData.write('token', payload['Id']);
        userData.write('Title', payload['Title']);

        userData.write('Specialty', payload['Specialty']);

        userData.write('email', email);
        userData.write('password', password);

        Get.offAll(const BottomNavScreen());
      } else {
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          isLogin = false;
        });
      }
    } catch (e) {}
  }

  bool isLogin = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                    child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Gap(40.h),
                      Image(
                        image: const AssetImage(
                          'assets/logoooo.png',
                        ),
                        height: 200.h,
                        width: 220.h,
                      ),
                      Text(
                        LocaleKeys.LogIn.tr(),
                        style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp),
                      ),
                      Gap(10.h),
                      Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return LocaleKeys.Please_enter_your_email
                                          .tr();
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                  controller: emailController,
                                  cursorColor: Colors.grey.shade400,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 10.h, horizontal: 10.h),
                                    filled: true,
                                    fillColor: const Color(0xffF6F5F5),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: LocaleKeys.Email.tr(),
                                    hintText: LocaleKeys.Email.tr(),
                                    labelStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontFamily: 'Tajawal7',
                                        color: Colors.grey.shade400),
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontFamily: 'Tajawal7',
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                                Gap(10.h),
                                TextFormField(
                                  obscureText: isVisible,
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return LocaleKeys
                                          .Please_enter_your_password.tr();
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                  controller: passwordController,
                                  cursorColor: Colors.grey.shade400,
                                  keyboardType: TextInputType.visiblePassword,
                                  decoration: InputDecoration(
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isVisible = !isVisible;
                                        });
                                      },
                                      child: isVisible == true
                                          ? const Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off,
                                              color: Styles.defualtColor),
                                    ),
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 3.h, horizontal: 10.h),
                                    filled: true,
                                    fillColor: const Color(0xffF6F5F5),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          width: .1.r,
                                          color: Colors.transparent),
                                      borderRadius: BorderRadius.circular(10.r),
                                    ),
                                    labelText: LocaleKeys.Password.tr(),
                                    hintText: LocaleKeys.Password.tr(),
                                    labelStyle: TextStyle(
                                        fontFamily: 'Tajawal7',
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade400),
                                    hintStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontFamily: 'Tajawal7',
                                        color: Colors.grey.shade400),
                                  ),
                                ),
                                Gap(10.h),
                              ],
                            ),
                          ),
                          Gap(5.h),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(const ForgetNumberScreen());
                                },
                                child: Text(
                                  LocaleKeys.did_you_forget_your_password.tr(),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: 'Tajawal7',
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Gap(15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: 40.h,
                              height: 35.h,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Styles.defualtColor,
                                    borderRadius: BorderRadius.circular(5.h)),
                                child: Center(
                                    child: Icon(
                                  Icons.fingerprint,
                                  color: Styles.defualtColorWhite,
                                  size: 25.h,
                                )),
                              )),
                          SizedBox(
                            width: 240.h,
                            height: 40.h,
                            child: ElevatedButton(
                              onPressed: () async {
                                final fcmToken =
                                    await FirebaseMessaging.instance.getToken();
                                ValidateEmail(emailController.text.toString());
                                if (formKey.currentState!.validate() &&
                                    userData.read('isvalid') == true) {
                                  setState(() {
                                    isLogin = true;
                                  });

                                  login(
                                    emailController.text.toString(),
                                    passwordController.text.toString(),
                                    fcmToken!,
                                  );
                                } else {
                                  setState(() {
                                    isLogin = false;
                                  });
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Styles.defualtColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.LogIn.tr(),
                                style: TextStyle(
                                  color: Styles.defualtColorWhite,
                                  fontFamily: 'Tajawal7',
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity.h,
                        height: 34.h,
                        child: ElevatedButton(
                          onPressed: () {
                            Get.to(SignInMember());
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.defualtColorWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.Log_in_as_a_technical_member.tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Styles.defualtColor,
                              fontFamily: 'Tajawal7',
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                      ),
                      Gap(20.h),
                      GestureDetector(
                        onTap: () {
                          Get.to(const TermsAndConditionsScreen());
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              LocaleKeys.Terms_and_Conditions.tr(),
                              style: TextStyle(
                                color: Styles.defualtColor,
                                fontFamily: 'Tajawal7',
                              ),
                            ),
                            Gap(15.h),
                            CircleAvatar(
                              backgroundColor: Styles.defualtColor,
                              radius: 15.h,
                              child: Icon(
                                FluentSystemIcons.ic_fluent_lightbulb_regular,
                                color: Styles.defualtColorWhite,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Gap(10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.Don_have_an_account.tr(),
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontFamily: 'Tajawal7',
                              color: Colors.black54,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        child: SizedBox(
                                          height: 210.h,
                                          width: 250.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                LocaleKeys.SIGN_UP.tr(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal7',
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 17.sp,
                                                ),
                                              ),
                                              Gap(20.h),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(const SignUp());
                                                    },
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 80.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.h),
                                                        color:
                                                            Styles.defualtColor,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          LocaleKeys.As_user
                                                              .tr(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Tajawal7',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Styles
                                                                .defualtColor3,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Gap(20.h),
                                                  InkWell(
                                                    onTap: () {
                                                      Get.to(
                                                          const SignUpWorker());
                                                    },
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 80.h,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.h),
                                                        color:
                                                            Styles.defualtColor,
                                                      ),
                                                      child: Center(
                                                        child: Text(
                                                          LocaleKeys.As_worker
                                                              .tr(),
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Tajawal7',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: Styles
                                                                .defualtColor3,
                                                            fontSize: 14.sp,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ));
                            },
                            child: Text(
                              LocaleKeys.SIGN_UP.tr(),
                              style: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Tajawal7',
                                color: Styles.defualtColor,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
          if (isLogin == true)
            AbsorbPointer(
              child: Center(
                child: CircularProgressIndicator(color: Styles.defualtColor),
              ),
            ),
        ],
      ),
    );
  }
}
