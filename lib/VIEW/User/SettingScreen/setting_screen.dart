import 'package:allo_prikool/VIEW/Auth/sign_in.dart';
import 'package:allo_prikool/VIEW/components/app_style.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../Auth/language_screen.dart';
import '../../OtherScreen/question_screen.dart';
import 'change_password.dart';
import 'edit_profile1_screen.dart';

final userData = GetStorage();

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColorWhite,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.h),
        child: Column(
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
                              child:
                                  SvgPicture.asset('assets/Group 88666.svg')),
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
                                InkWell(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: const Icon(
                                      Icons.arrow_back,
                                      color: Colors.white,
                                    )),
                                Text(
                                  LocaleKeys.Settings.tr(),
                                  style: TextStyle(
                                      fontFamily: 'Tajawal7',
                                      color: Styles.defualtColorWhite,
                                      fontWeight: FontWeight.w600,
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
            Gap(20.h),
            InkWell(
              onTap: () {
                Get.to(const EditPasswordScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.lock),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Change_Password.tr(),
                              style: const TextStyle(
                                fontFamily: 'Tajawal7',
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        )
                      ],
                    )),
              ),
            ),
            Gap(10.h),
            InkWell(
              onTap: () {
                Get.to(EditProfileData1Screen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.person),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Edit_Profile.tr(),
                              style: const TextStyle(
                                fontFamily: 'Tajawal7',
                              ),
                            )
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        )
                      ],
                    )),
              ),
            ),
            Gap(10.h),
            InkWell(
              onTap: () {
                Get.to(const QuestionScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.question_mark_sharp),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Questions.tr(),
                              style: const TextStyle(
                                fontFamily: 'Tajawal7',
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        )
                      ],
                    )),
              ),
            ),
            Gap(10.h),
            InkWell(
              onTap: () {
                Get.to(const LanguageScreen());
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.language),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Language.tr(),
                              style: const TextStyle(
                                fontFamily: 'Tajawal7',
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        )
                      ],
                    )),
              ),
            ),
            Gap(10.h),
            InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  dialogType: DialogType.info,
                  borderSide: const BorderSide(
                    color: Colors.green,
                    width: 2,
                  ),
                  width: 350.w,
                  btnCancelText: LocaleKeys.Cancel.tr(),
                  btnOkText: LocaleKeys.Ok.tr(),
                  buttonsBorderRadius: const BorderRadius.all(
                    Radius.circular(2),
                  ),
                  dismissOnTouchOutside: true,
                  dismissOnBackKeyPress: false,
                  headerAnimationLoop: false,
                  animType: AnimType.bottomSlide,
                  title: LocaleKeys.Log_out.tr(),
                  desc: LocaleKeys.Are_you_sure_to_leave.tr(),
                  titleTextStyle: TextStyle(
                    fontFamily: 'Tajawal7',
                    fontSize: 16.sp,
                  ),
                  descTextStyle: TextStyle(
                    fontFamily: 'Tajawal7',
                    fontSize: 18.sp,
                  ),
                  buttonsTextStyle: TextStyle(
                    fontFamily: 'Tajawal7',
                    fontSize: 16.sp,
                  ),
                  showCloseIcon: true,
                  btnCancelOnPress: () {
                    Get.back();
                  },
                  btnOkOnPress: () {
                    userData.write('isLogged', false);
                    userData.remove('Email');
                    userData.remove('PhoneNumber');
                    userData.remove('token');
                    userData.remove('Name');
                    userData.remove('Title');
                    userData.remove('NationalId');
                    Get.offAll(() => const SignIn());
                  },
                ).show();
                // showDialog(
                //     context: context,
                //     builder: (context) => AlertDialog(
                //           title: Text(LocaleKeys.Log_out.tr()),
                //           content: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisSize: MainAxisSize.min,
                //             children: [
                //               Text(
                //                 LocaleKeys.Are_you_sure_to_leave.tr(),
                //                 style: const TextStyle(
                //                   fontFamily: 'Tajawal7',
                //                   fontSize: 18,
                //                 ),
                //               ),
                //               const SizedBox(
                //                 height: 32,
                //               ),
                //             ],
                //           ),
                //           actions: [
                //             TextButton(
                //                 onPressed: () =>
                //                     Get.offAll(() => const SignIn()),
                //                 child: Text(
                //                   LocaleKeys.Ok.tr(),
                //                   style: const TextStyle(
                //                     fontSize: 18,
                //                   ),
                //                 )),
                //             TextButton(
                //                 onPressed: () => Get.back(),
                //                 child: Text(
                //                   LocaleKeys.Cancel.tr(),
                //                   style: TextStyle(
                //                     fontFamily: 'Tajawal7',
                //                     fontSize: 18.sp,
                //                   ),
                //                 )),
                //           ],
                //         ));
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.h),
                child: Container(
                    height: 50.h,
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.h, vertical: 5.h),
                    decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.shade100,
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.logout),
                            Gap(10.h),
                            Text(
                              LocaleKeys.Log_out.tr(),
                              style: const TextStyle(
                                fontFamily: 'Tajawal7',
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20.sp,
                        )
                      ],
                    )),
              ),
            ),
            Gap(15.h),
          ],
        ),
      ),
    );
  }
}
