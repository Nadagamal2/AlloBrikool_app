import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:ui' as ui;
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../components/app_style.dart';
import 'editCity_screen.dart';
import 'editEmail_screen.dart';
import 'editName_screen.dart';
import 'editPhone_screen.dart';

class EditProfileData1Screen extends StatelessWidget {
  EditProfileData1Screen({Key? key}) : super(key: key);

  final userData = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        LocaleKeys.Modify_your_Account.tr(),
                        style: TextStyle(
                          fontFamily: 'Tajawal7',
                          color: Styles.defualtColor2,
                          fontSize: 17.sp,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Gap(20.h),
                        SizedBox(
                          width: double.infinity,
                          height: 34.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const EditProfileNameScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.defualtColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Change_Name.tr(),
                              style: TextStyle(
                                color: Styles.defualtColorWhite,
                                fontFamily: 'Tajawal7',
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        SizedBox(
                          width: double.infinity,
                          height: 34.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const EditProfilePhoneScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.defualtColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Change_phone.tr(),
                              style: TextStyle(
                                color: Styles.defualtColorWhite,
                                fontFamily: 'Tajawal7',
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        SizedBox(
                          width: double.infinity,
                          height: 34.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const EditProfileEmailScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.defualtColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Change_Email.tr(),
                              style: TextStyle(
                                color: Styles.defualtColorWhite,
                                fontFamily: 'Tajawal7',
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Gap(20.h),
                        SizedBox(
                          width: double.infinity,
                          height: 34.h,
                          child: ElevatedButton(
                            onPressed: () {
                              Get.to(const EditProfileCityScreen());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.defualtColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Change_Country.tr(),
                              style: TextStyle(
                                color: Styles.defualtColorWhite,
                                fontFamily: 'Tajawal7',
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                        Gap(200.h),
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text(LocaleKeys.Back.tr(),
                                style: TextStyle(
                                    fontFamily: 'Tajawal7',
                                    color: Colors.grey,
                                    fontSize: 17.sp))),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
