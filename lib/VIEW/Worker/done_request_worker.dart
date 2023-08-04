import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../components/app_style.dart';
import 'HomeNavWorker/bottomNavWorker.dart';

class DoneRequestScreen extends StatelessWidget {
  const DoneRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            image: const AssetImage('assets/www.png'),
            height: 100.h,
          ),
          Gap(30.h),
          Center(
              child: Text(
            LocaleKeys.Offer_sent_pending_approval.tr(),
            style: TextStyle(
                color: Styles.defualtColor,
                fontSize: 18.sp,
                fontFamily: 'Tajawal7'),
          )),
          Gap(20.h),
          ElevatedButton(
              onPressed: () {
                Get.offAll(const BottomNavWokerScreen());
              },
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Styles.defualtColor),
                  padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
                  textStyle: MaterialStateProperty.all(TextStyle(
                    fontSize: 15.sp,
                    fontFamily: 'Tajawal7',
                  ))),
              child: Text(
                LocaleKeys.Go_To_Home.tr(),
              ))
        ],
      ),
    );
  }
}
