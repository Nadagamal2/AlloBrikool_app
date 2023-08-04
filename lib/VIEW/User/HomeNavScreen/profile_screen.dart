import 'dart:developer';

import 'package:allo_prikool/VIEW/User/SettingScreen/setting_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../components/app_style.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final userData = GetStorage();
  @override
  void initState() {
    log(userData.read('token'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 130.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Styles.defualtColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15.r),
                                  bottomRight: Radius.circular(15.h))),
                        ),
                        Positioned(
                            height: 130.h,
                            right: 110.h,
                            top: -5,
                            child: SvgPicture.asset('assets/Group 88666.svg')),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        right: 20.h,
                        left: 20.h,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Icon(
                                FluentSystemIcons.ic_fluent_edit_regular,
                                color: Colors.transparent,
                              ),
                              Text(
                                LocaleKeys.Profile.tr(),
                                style: TextStyle(
                                    color: Styles.defualtColorWhite,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: 'Tajawal7',
                                    fontSize: 20.sp),
                              ),
                              InkWell(
                                  onTap: () {},
                                  child: const Icon(
                                    FluentSystemIcons.ic_fluent_edit_regular,
                                    color: Colors.transparent,
                                  )),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ]),
          Gap(40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: Styles.defualtColor3,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/Mask Group 7.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    Gap(15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.User_Name.tr(),
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                            color: Colors.grey,
                          ),
                        ),
                        Gap(5.h),
                        Text(
                          '${userData.read('Name')}',
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: .5,
                  height: 20.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        height: 40.h,
                        width: 40.h,
                        decoration: BoxDecoration(
                          color: Styles.defualtColor3,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Icon(
                          Icons.location_on,
                          color: Styles.defualtColor,
                          size: 26.sp,
                        )),
                    Gap(15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.City.tr(),
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                            color: Colors.grey,
                          ),
                        ),
                        Gap(5.h),
                        Text(
                          '${userData.read('Title')}',
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: .5,
                  height: 20.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: Styles.defualtColor3,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/Group 88815.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    Gap(15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.Email.tr(),
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                            color: Colors.grey,
                          ),
                        ),
                        Gap(5.h),
                        Text(
                          '${userData.read('Email')}',
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: .5,
                  height: 20.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 40.h,
                      width: 40.h,
                      decoration: BoxDecoration(
                        color: Styles.defualtColor3,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                      child: SvgPicture.asset(
                        'assets/Group 89115.svg',
                        fit: BoxFit.none,
                      ),
                    ),
                    Gap(15.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.Phone_number.tr(),
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                            color: Colors.grey,
                          ),
                        ),
                        Gap(5.h),
                        Text(
                          '${userData.read('PhoneNumber')}',
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Divider(
                  thickness: .5,
                  height: 20.h,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Gap(10.h),
          SizedBox(
            width: 240.h,
            height: 40.h,
            child: ElevatedButton(
              onPressed: () {
                Get.to(() => const SettingScreen());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Styles.defualtColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              child: Text(
                LocaleKeys.Settings.tr(),
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
    );
  }
}
