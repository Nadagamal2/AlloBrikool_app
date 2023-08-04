import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../Auth/sign_in.dart';
import '../components/app_style.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';

class BoardingModel {
  final String image;
  // final String title;
  final String body;

  BoardingModel({
    required this.image,
    // required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/1.png',
      // title: "Search Doctor".tr(),
      body: 'جميع مستلزماتك الشرائية بارخص الاسعار ولاتنسي زيارة صفحة العروض',
    ),
    BoardingModel(
      image: 'assets/2.png',
      // title: "Book Appointment ".tr(),
      body: 'اطلبها ونوصلها بنتابع كل طلبياتك لحد متوصلك بكل عنايه',
    ),
    BoardingModel(
      image: 'assets/3.png',
      // title: "Book Appointment ".tr(),
      body: 'تسوق الآن',
    ),
  ];
  int currentIndex = 0;
  PageController? _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Gap(25.h),
        SizedBox(
          height: 355.h,
          child: PageView.builder(
              controller: _controller,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              physics: const BouncingScrollPhysics(),
              itemCount: boarding.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.all(15.h),
                  child: Center(
                    child: Image(
                        image: AssetImage(
                      boarding[index].image,
                    )),
                  ),
                );
              }),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Gap(30.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    boarding.length,
                    (index) => Padding(
                          padding: EdgeInsets.symmetric(horizontal: 3.h),
                          child: AnimatedContainer(
                            curve: Curves.fastLinearToSlowEaseIn,
                            duration: const Duration(seconds: 1),
                            width: index == currentIndex ? 22 : 8,
                            height: 5,
                            decoration: BoxDecoration(
                                color: index == currentIndex
                                    ? Styles.defualtColor
                                    : Colors.grey.shade300,
                                borderRadius: BorderRadius.circular(2)),
                          ),
                        )),
              ),
            ],
          ),
        ),
        Gap(20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            children: [
              Text(
                LocaleKeys.Learn_about_the_AlloBrikool_app.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  fontFamily: 'Tajawal7',
                ),
              ),
              Gap(5.h),
              Text(
                LocaleKeys.AnEasy.tr(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade400,
                  fontFamily: 'Tajawal7',
                ),
              ),
            ],
          ),
        ),
        Gap(20.h),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (currentIndex == boarding.length - 3)
              SizedBox(
                width: 70.h,
                height: 34.h,
                child: ElevatedButton(
                  onPressed: () {
                    _controller?.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.defualtColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    color: Styles.defualtColorWhite,
                    size: 20.h,
                  )),
                ),
              ),
            if (currentIndex == boarding.length - 2)
              SizedBox(
                width: 70.h,
                height: 34.h,
                child: ElevatedButton(
                  onPressed: () {
                    _controller?.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.defualtColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Center(
                      child: Icon(
                    Icons.arrow_forward_ios,
                    color: Styles.defualtColorWhite,
                    size: 20.h,
                  )),
                ),
              ),
            if (currentIndex == boarding.length - 1)
              SizedBox(
                width: 100.h,
                height: 40.h,
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAll(const SignIn());
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.defualtColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.r),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      LocaleKeys.Start_now.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontFamily: 'Tajawal7',
                          color: Styles.defualtColorWhite,
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    ));
  }
}
