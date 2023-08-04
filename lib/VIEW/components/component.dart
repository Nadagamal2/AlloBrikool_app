import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

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
        onTap: onTap,
        child: Center(
          child: text,
        ),
      ),
    );
Widget BuildQuestionScreen({
  required String text1,
  required String text2,
}) =>
    Column(
      children: [
        Row(
          children: [
            Container(
              width: 210,
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 5.h),
              decoration: const BoxDecoration(
                color: Color(0xff1D2042),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(23),
                    topLeft: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
              ),
              child: Center(
                child: Text(
                  text1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Tajawal7',
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
        const Gap(8),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              width: 220,
              padding: EdgeInsets.symmetric(horizontal: 30.h, vertical: 5.h),
              decoration: const BoxDecoration(
                color: Color(0xff31355e),
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(23),
                    topLeft: Radius.circular(23),
                    bottomLeft: Radius.circular(23)),
              ),
              child: Center(
                child: Text(
                  text2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'Tajawal7',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
