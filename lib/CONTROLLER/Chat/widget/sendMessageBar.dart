import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

import '../../../VIEW/components/app_style.dart';
import '../../translations/locale_keys.g.dart';
import '../const.dart';

class customSenderBar extends StatelessWidget {
  customSenderBar(
      {Key? key,
      required this.messageController,
      required this.sendMessage,
      required this.sendLocation})
      : super(key: key);
  TextEditingController messageController = TextEditingController();
  VoidCallback sendMessage;
  // VoidCallback sendImage;
  // VoidCallback sendFile;
  VoidCallback sendLocation;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: double.infinity,
      margin: EdgeInsets.only(left: 17.w, right: 17.w, bottom: 5.h),
      child: SafeArea(
        bottom: true,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: TextFormField(
                  maxLines: null,
                  keyboardType: TextInputType.multiline,
                  controller: messageController,
                  cursorColor: Colors.grey,
                  style: TextStyle(
                      fontSize: 13.sp,
                      fontFamily: 'Tajawal7',
                      color: Colors.black),
                  decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                    filled: true,
                    fillColor: const Color(0xffffffff),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: .1.r, color: Colors.black),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    border: const OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(width: .1.r, color: Colors.black),
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    labelText: LocaleKeys.Write_message.tr(),
                    hintText: LocaleKeys.Write_message.tr(),
                    prefixIcon: GestureDetector(
                      onTap: sendLocation,
                      child: Icon(
                        Icons.location_on_outlined,
                        color: Styles.defualtColorBlack,
                      ),
                    ),
                    labelStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'Tajawal7',
                        color: Colors.grey.shade400),
                    hintStyle: TextStyle(
                        fontSize: 13.sp,
                        fontFamily: 'Tajawal7',
                        color: Colors.grey.shade400),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.w),
            GestureDetector(
              onTap: sendMessage,
              child: Container(
                child: CircleAvatar(
                    radius: 22.r,
                    backgroundColor: Styles.defualtColor,
                    child: Center(
                        child: Icon(
                      Icons.send,
                      color: Styles.defualtColorWhite,
                    ))),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
