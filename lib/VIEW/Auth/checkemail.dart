import 'package:allo_prikool/VIEW/Auth/sign_in.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../components/app_style.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';

class CheckEmail extends StatelessWidget {
  const CheckEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: Image.asset(
              'assets/check.png',
              fit: BoxFit.cover,
              height: 200.h,
              width: 200.h,
            )),
            Gap(20.h),
            Text(
              LocaleKeys.Check_Your_Email.tr(),
              style: TextStyle(
                color: Styles.defualtColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            Gap(50.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: SizedBox(
                width: double.infinity,
                height: 34.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(const SignIn());
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
            ),
          ],
        ),
      ),
    );
  }
}
