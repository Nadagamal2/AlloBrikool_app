import 'dart:convert';
import 'package:allo_prikool/CONTROLLER/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../components/app_style.dart';
import 'donePassword_screen.dart';

class EditPasswordScreen extends StatefulWidget {
  const EditPasswordScreen({Key? key}) : super(key: key);

  @override
  State<EditPasswordScreen> createState() => _EditPasswordScreenState();
}

class _EditPasswordScreenState extends State<EditPasswordScreen> {
  final userData = GetStorage();

  TextEditingController OldPaasswordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();
  TextEditingController ConfirmNewPasswordController = TextEditingController();
  bool isChange = false;

  @override
  void dispose() {
    OldPaasswordController.dispose();
    NewPasswordController.dispose();
    ConfirmNewPasswordController.dispose();

    super.dispose();
  }

  void changePassword({
    required dynamic OldPaassword,
    required dynamic NewPassword,
    required dynamic ConfirmNewPassword,
  }) async {
    var response = await http.post(
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/Auth/EditePassword/${userData.read('token')}'),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "id": "${userData.read('token')}",
          "OldPaassword": OldPaassword,
          "NewPassword": NewPassword,
          "ConfirmNewPassword": ConfirmNewPassword
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      userData.write("isChanged", true);
      userData.write('NewPassword', NewPassword);
      userData.write('ConfirmNewPassword', ConfirmNewPassword);
      setState(() {
        isChange = false;
      });
      Get.offAll(const DonePassScreen());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    LocaleKeys.Change_Password.tr(),
                    style: TextStyle(
                      fontFamily: 'Tajawal7',
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Gap(40.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    controller: OldPaasswordController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: const Color(0xffF6F5F5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        labelText: LocaleKeys.Old_Password.tr(),
                        hintText:  LocaleKeys.Old_Password.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    controller: NewPasswordController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: const Color(0xffF6F5F5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        labelText:  LocaleKeys.New_Password.tr(),
                        hintText:  LocaleKeys.New_Password.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(15.h),
                  TextFormField(
                    cursorColor: Colors.grey.shade400,
                    keyboardType: TextInputType.text,
                    controller: ConfirmNewPasswordController,
                    decoration: InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 3.h, horizontal: 10.h),
                        filled: true,
                        fillColor: const Color(0xffF6F5F5),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: const OutlineInputBorder(),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              width: .1.r, color: Colors.transparent),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        labelText:LocaleKeys.Confirm_Password.tr(),
                        hintText: LocaleKeys.Confirm_Password.tr(),
                        labelStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400),
                        hintStyle: TextStyle(
                            fontSize: 15.sp, color: Colors.grey.shade400)),
                  ),
                  Gap(80.h),
                  SizedBox(
                    width: double.infinity.h,
                    height: 34.h,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isChange = true;
                        });
                        changePassword(
                            OldPaassword:
                                OldPaasswordController.text.toString(),
                            NewPassword: NewPasswordController.text.toString(),
                            ConfirmNewPassword:
                                ConfirmNewPasswordController.text.toString());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.defualtColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                      ),
                      child: Text(
                        LocaleKeys.Change.tr(),
                        style: TextStyle(
                          color: Styles.defualtColorWhite,
                          fontFamily: 'Tajawal7',
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                  Gap(20.h),
                  TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(LocaleKeys.Back.tr(),
                          style:
                              TextStyle(color: Colors.grey, fontSize: 16.sp))),
                ],
              ),
            ),
          ),
        ),
        if (isChange == true)
          AbsorbPointer(
            child: Center(
                child: CircularProgressIndicator(
              color: Styles.defualtColor,
            )),
          ),
      ],
    );
  }

  Widget buildBottum({
    required double height,
    required double width,
    required Text text,
    required Function() onTap,
    EdgeInsetsGeometry? margin,
    required BoxDecoration? decoration,
  }) =>
      Container(
        height: height,
        margin: margin,
        width: width,
        decoration: decoration,
        child: InkWell(
          child: Center(
            child: text,
          ),
          onTap: onTap,
        ),
      );
}
