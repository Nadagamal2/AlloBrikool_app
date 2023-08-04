import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../components/app_style.dart';
import 'checkemail.dart';

class ForgetNumberScreen extends StatefulWidget {
  const ForgetNumberScreen({Key? key}) : super(key: key);

  @override
  State<ForgetNumberScreen> createState() => _ForgetNumberScreenState();
}

class _ForgetNumberScreenState extends State<ForgetNumberScreen> {
  final userData = GetStorage();
  final emailController = TextEditingController();
  void forget(String email) async {
    try {
      var request = http.Request(
          'POST',
          Uri.parse(
              'http://eibtek2-001-site20.atempurl.com/api/Auth/ForgetPassword/${email}'));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);
      final result = jsonDecode(response.body) as Map<String, dynamic>;

      if (response.statusCode == 200) {
        Get.to(const CheckEmail());
      } else {}
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.h, vertical: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios_rounded,
                        size: 30.sp,
                      )),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 33.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: Image.asset(
                    'assets/99.png',
                    fit: BoxFit.cover,
                    height: 130.h,
                    width: 130.h,
                    color: Colors.grey.shade600,
                  )),
                  Gap(20.h),
                  Text(
                    LocaleKeys.Forget_Your_Password.tr(),
                    style: TextStyle(
                      fontFamily: 'Tajawal7',
                      color: Styles.defualtColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(12.h),
                  Text(
                    LocaleKeys.Provide_your_email.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Tajawal7',
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Gap(32.h),
                  defaultFieldForm(
                    controller: emailController,
                    padding: const EdgeInsets.symmetric(vertical: 3),
                    Type: TextInputType.emailAddress,
                    prefix: FluentSystemIcons.ic_fluent_mail_regular,
                    lable: LocaleKeys.Email.tr(),
                    hint: LocaleKeys.Email.tr(),
                  ),
                  Gap(60.h),
                  SizedBox(
                    width: double.infinity,
                    height: 34.h,
                    child: ElevatedButton(
                      onPressed: () {
                        forget(emailController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.defualtColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.Ok.tr(),
                        style: TextStyle(
                          color: Styles.defualtColorWhite,
                          fontFamily: 'Tajawal7',
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  Gap(8.h),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        LocaleKeys.Back.tr(),
                        style: TextStyle(
                          fontFamily: 'Tajawal7',
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey.shade600,
                        ),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget defaultFieldForm({
  required TextInputType Type,
  required IconData prefix,
  required String lable,
  required String hint,
  required EdgeInsets? padding,
  String? Function(String?)? validator,
  String? Function(String?)? onChanged,
  TextEditingController? controller,
}) =>
    TextFormField(
      validator: validator,
      onChanged: onChanged,
      cursorColor: Colors.grey.shade400,
      keyboardType: Type,
      controller: controller,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.never,
        contentPadding: padding,
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5.h),
          borderRadius: BorderRadius.circular(6.r),
        ),
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: .5.h),
          borderRadius: BorderRadius.circular(6.r),
        ),
        prefixIcon: Icon(
          prefix,
          size: 20.sp,
          color: Styles.defualtColor,
        ),
        labelText: lable,
        hintText: hint,
      ),
    );
