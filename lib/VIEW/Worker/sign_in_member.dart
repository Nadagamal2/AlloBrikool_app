import 'dart:convert';
import 'package:allo_prikool/VIEW/Auth/forgetPassword.dart';
import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/bottomNavWorker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:http/http.dart' as http;
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../components/app_style.dart';

class SignInMember extends StatefulWidget {
  SignInMember({Key? key}) : super(key: key);

  @override
  State<SignInMember> createState() => _SignInMemberState();
}

class _SignInMemberState extends State<SignInMember> {
  void ValidateEmail(String email) {
    bool isvalid = EmailValidator.validate(email);
    print(isvalid);
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

  final emailController = new TextEditingController();
  final passwordController = new TextEditingController();
  var formKey = GlobalKey<FormState>();
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  final userData = GetStorage();
  void login(
    String email,
    String password,
  ) async {
    try {
      final fcmToken = await FirebaseMessaging.instance.getToken();
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site20.atempurl.com/api/Auth/Login'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "email": email,
            "password": password,
            "deviceToken": fcmToken,
            "Role": "Worker",
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
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
        userData.write('role', false);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('Name', payload['Name']);
        userData.write('token', payload['Id']);
        userData.write('Title', payload['Title']);
        userData.write('Specialty', payload['Specialty']);
        userData.write('email', email);
        userData.write('password', password);
        Get.offAll(const BottomNavWokerScreen());
      } else {
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {}
  }

  bool isLogin = false;
  bool isVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Styles.defualtColorBlack,
            )),
        elevation: 0,
        backgroundColor: Styles.defualtColorWhite,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.h),
                  child: Column(
                    children: [
                      Image(
                        image: const AssetImage(
                          'assets/logoooo.png',
                        ),
                        height: 200.h,
                        width: 220.h,
                      ),
                      Gap(20.h),
                      Text(
                        LocaleKeys.Log_in_as_a_technical_member.tr(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontWeight: FontWeight.w600,
                            fontSize: 20.sp),
                      ),
                      Gap(20.h),
                      Column(
                        children: [
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return LocaleKeys.Please_enter_your_email
                                          .tr();
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.grey.shade400,
                                  keyboardType: TextInputType.emailAddress,
                                  controller: emailController,
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
                                    labelText: LocaleKeys.User_Name.tr(),
                                    hintText: LocaleKeys.User_Name.tr(),
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
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                  validator: (String? val) {
                                    if (val!.isEmpty) {
                                      return LocaleKeys
                                          .Please_enter_your_password.tr();
                                    }
                                    return null;
                                  },
                                  cursorColor: Colors.grey.shade400,
                                  keyboardType: TextInputType.text,
                                  controller: passwordController,
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
                              ],
                            ),
                          ),
                          Gap(15.h),
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
                      SizedBox(
                        width: double.infinity,
                        height: 34.h,
                        child: ElevatedButton(
                          onPressed: () {
                            ValidateEmail(emailController.text.toString());
                            if (formKey.currentState!.validate() &&
                                userData.read('isvalid') == true) {
                              setState(() {
                                isLogin = true;
                              });
                              login(
                                emailController.text.toString(),
                                passwordController.text.toString(),
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
                      Gap(20.h),
                    ],
                  ),
                ),
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
