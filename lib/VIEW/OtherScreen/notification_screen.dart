import 'package:allo_prikool/VIEW/components/app_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColorWhite,
      appBar: AppBar(
        title: Text(
          LocaleKeys.Notifications.tr(),
          style: TextStyle(
              fontFamily: 'Tajawal7',
              color: Styles.defualtColorBlack,
              fontWeight: FontWeight.w600),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Styles.defualtColorWhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: Column(
          children: [
            Container(
              height: 90.h,
              padding: EdgeInsets.all(10.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(15.h),
              ),
              child: const Center(
                child: Text(
                  'There is no notifications',
                  style: TextStyle(fontFamily: 'Tajawal7'),
                ),
              ),
            ),
            Gap(15.h),
          ],
        ),
      ),
    );
  }
}
