import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Chat/chat_screen.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../Chat/chat_screen.dart';
import '../User/HomeNavScreen/bottomNav_screen.dart';
import '../components/app_style.dart';

class PaymentDoneScreen extends StatefulWidget {
  String nam;
  String requestOrderwId;
  String requestOrderPhone;
  String fcmToken;

  PaymentDoneScreen(
      {Key? key,
      required this.nam,
      required this.fcmToken,
      required this.requestOrderwId,
      required this.requestOrderPhone})
      : super(key: key);

  @override
  State<PaymentDoneScreen> createState() => _PaymentDoneScreenState();
}

class _PaymentDoneScreenState extends State<PaymentDoneScreen> {
  final userData = GetStorage();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColor,
      body: Center(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 80.h,
                      backgroundColor: const Color(0xff303457),
                    ),
                    CircleAvatar(
                      radius: 60.h,
                      backgroundColor: const Color(0xff5c65af),
                    ),
                    CircleAvatar(
                      radius: 40.h,
                      backgroundColor: const Color(0xffFFFFFF),
                      child: Icon(
                        Icons.check,
                        color: Colors.green,
                        size: 40.h,
                      ),
                    ),
                  ],
                ),
                Gap(30.h),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    LocaleKeys.Your_service_has.tr(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Tajawal7',
                        color: Styles.defualtColorWhite,
                        fontSize: 15.sp),
                  ),
                ),
                Gap(10.h),
              ],
            ),
            Container(
              height: 200.h,
              padding: EdgeInsets.all(15.h),
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.h),
                      topRight: Radius.circular(20.h))),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                color: Styles.defualtColorWhite,
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage("assets/logo2.png"),
                                )),
                            height: 50.h,
                            padding: EdgeInsets.all(2.h),
                            width: 50.h,
                          ),
                          Gap(10.h),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.nam,
                                style: TextStyle(
                                    fontFamily: 'Tajawal7',
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12.h,
                                    color: Styles.defualtColor),
                              ),
                              Gap(10.h),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star,
                                    color: Colors.grey.shade300,
                                    size: 15.sp,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Styles.defualtColor,
                                    size: 15.sp,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Styles.defualtColor,
                                    size: 15.sp,
                                  ),
                                  Icon(
                                    Icons.star,
                                    color: Styles.defualtColor,
                                    size: 15.sp,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Get.to(Chat2Screen(
                                    serviceID: widget.requestOrderwId,
                                    fcmToken: widget.fcmToken,
                                  ));
                                },
                                child: CircleAvatar(
                                  radius: 15.h,
                                  backgroundColor: Styles.defualtColor,
                                  child: Icon(
                                    Icons.chat_bubble,
                                    color: Styles.defualtColorWhite,
                                    size: 15.h,
                                  ),
                                ),
                              ),
                              Gap(3.h),
                              Text(
                                LocaleKeys.Chat.tr(),
                                style: TextStyle(
                                    fontFamily: 'Tajawal7',
                                    fontSize: 12.sp,
                                    color: Styles.defualtColor),
                              )
                            ],
                          ),
                          Gap(5.h),
                          InkWell(
                            onTap: () {
                              _launchUrl(
                                  'whatsapp://send?phone=+2${widget.requestOrderPhone}');
                            },
                            child: CircleAvatar(
                              radius: 15.h,
                              backgroundColor: Colors.green,
                              child: Icon(
                                Icons.phone,
                                color: Styles.defualtColorWhite,
                                size: 15.h,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(20.h),
                  SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.offAll(const BottomNavScreen());
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String link) async {
    if (await launchUrl(Uri.parse(link))) {
      throw Exception('Could not launch  ');
    }
  }
}
