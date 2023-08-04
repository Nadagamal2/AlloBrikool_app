import 'dart:convert';
import 'package:allo_prikool/VIEW/Payment/payment_done.dart';
import 'package:allo_prikool/VIEW/components/app_style.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  String Name;
  String Price;
  String num;
  String phone;
  String fcmToken;
  int requestOrderId;
  String requestOrderwId;

  PaymentScreen({
    Key? key,
    required this.requestOrderwId,
    required this.Name,
    required this.fcmToken,
    required this.Price,
    required this.requestOrderId,
    required this.num,
    required this.phone,
  }) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool isClick = true;
  Future invioce() async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/InvoiceApi/Create'));
    request.body = json.encode(
        {"confirmRequestOrderId": widget.requestOrderId, "confirmInvoice": 1});
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  int counter = 0;
  bool isCurrent = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back,
              color: Styles.defualtColorBlack,
            )),
        title: Text(
          LocaleKeys.Payment.tr(),
          style: TextStyle(
              fontFamily: 'Tajawal7',
              color: Styles.defualtColorBlack,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.Name,
                    style: const TextStyle(
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Text(
                    LocaleKeys.Service_name.tr(),
                    style: const TextStyle(
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.Price} ${LocaleKeys.DZD.tr()}',
                    style: const TextStyle(
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                  Text(
                    LocaleKeys.total.tr(),
                    style: const TextStyle(
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                ],
              ),
              Divider(
                thickness: .5,
                height: 20.h,
                color: Colors.grey,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    LocaleKeys.payment_method.tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      fontFamily: 'Tajawal7',
                    ),
                  ),
                ],
              ),
              Gap(20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    child: Container(
                      height: 40.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          color: isCurrent
                              ? Styles.defualtColor
                              : Styles.defualtColorWhite,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: isCurrent
                                  ? Colors.transparent
                                  : Styles.defualtColor)),
                      child: Center(
                        child: Text(
                          LocaleKeys.Cash_payment.tr(),
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            color: isCurrent ? Colors.white : Colors.black54,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5.sp,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      counter = 0;
                      setState(() {});
                    },
                  ),
                  Gap(5.h),
                  InkWell(
                    child: Container(
                      height: 40.h,
                      width: 140.w,
                      decoration: BoxDecoration(
                          color: isCurrent
                              ? Styles.defualtColorWhite
                              : Styles.defualtColor,
                          borderRadius: BorderRadius.circular(10.r),
                          border: Border.all(
                              color: isCurrent
                                  ? Styles.defualtColor
                                  : Colors.transparent)),
                      child: Center(
                        child: Text(
                          LocaleKeys.Credit_card.tr(),
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            color: isCurrent ? Colors.black54 : Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 12.5,
                          ),
                        ),
                      ),
                    ),
                    onTap: () {
                      counter = 1;
                      setState(() {});
                    },
                  ),
                ],
              ),
              Gap(20.h),
              counter == 0
                  ? Container()
                  : Container(
                      height: 180.h,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(20.h),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.grey.shade400, width: .5),
                        borderRadius: BorderRadius.circular(10.h),
                      ),
                      child: Column(
                        children: [
                          Container(
                            height: 30.h,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10.h, right: 10.h),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.name.tr(),
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(15.h),
                          Container(
                            height: 30.h,
                            width: double.infinity,
                            padding: EdgeInsets.only(left: 10.h, right: 10.h),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  LocaleKeys.Card_number.tr(),
                                  style: const TextStyle(
                                    fontFamily: 'Tajawal7',
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Gap(15.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 30.h,
                                width: 120.h,
                                padding:
                                    EdgeInsets.only(left: 10.h, right: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.Expiry_date.tr(),
                                      style: const TextStyle(
                                        fontFamily: 'Tajawal7',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                height: 30.h,
                                width: 120,
                                padding:
                                    EdgeInsets.only(left: 10.h, right: 10.h),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(10.r)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: const [
                                    Text(
                                      'CVC',
                                      style: TextStyle(
                                        fontFamily: 'Tajawal7',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
              Gap(20.h),
              SizedBox(
                height: 40.h,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(PaymentDoneScreen(
                      nam: widget.num,
                      requestOrderwId: widget.requestOrderwId,
                      requestOrderPhone: widget.phone,
                      fcmToken: widget.fcmToken,
                    ));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Styles.defualtColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Text(
                    LocaleKeys.Complete_the_payment.tr(),
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
        ),
      ),
    );
  }
}
