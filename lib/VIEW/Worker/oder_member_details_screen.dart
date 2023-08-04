import 'dart:convert';
import 'package:allo_prikool/VIEW/Worker/oder_member_details_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

import '../../CONTROLLER/Chat/widget/noti.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../components/app_style.dart';
import '../components/notifications.dart';
import 'HomeNavWorker/bottomNavWorker.dart';
import 'done_request_worker.dart';

class OrderMemberDetailsScreen extends StatefulWidget {
  String name;
  int id;
  String img1;
  Widget img2;
  String City;
  String description;
  String Phone;
  String fcmToken;

  OrderMemberDetailsScreen({
    Key? key,
    required this.id,
    required this.name,
    required this.description,
    required this.City,
    required this.img1,
    required this.img2,
    required this.Phone,
    required this.fcmToken,
  }) : super(key: key);

  @override
  State<OrderMemberDetailsScreen> createState() =>
      _OrderMemberDetailsScreenState();
}

class _OrderMemberDetailsScreenState extends State<OrderMemberDetailsScreen> {
  final userData = GetStorage();
  TextEditingController priceController = TextEditingController();

  void dispose() {
    priceController.dispose();

    super.dispose();
  }

  Future DeleteClintId(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  void Comfirm(
    String price,
  ) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/CreateRequestOrder'));
    request.body = json.encode({
      "clientOrderId": userData.read('clintId'),
      "workerApplicationUserId": '${userData.read('token')}',
      "isAccepted": 1,
      "requestPrice": price
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.offAll(DoneRequestScreen());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Styles.defualtColor,
      appBar: AppBar(
        title: Text(
          'Order Details',
          style: TextStyle(color: Styles.defualtColor, fontFamily: 'Tajawal7'),
        ),
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back, color: Styles.defualtColor)),
        elevation: 0,
        backgroundColor: Styles.defualtColorWhite,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Styles.defualtColorWhite,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          widget.img1,
                        ),
                      )),
                  height: 50.h,
                  padding: EdgeInsets.all(2.h),
                  width: 50.h,
                ),
                Gap(10.h),
                Column(
                  children: [
                    Text(
                      widget.name,
                      style: TextStyle(
                        fontFamily: 'Tajawal7',
                        color: Styles.defualtColorWhite,
                        fontWeight: FontWeight.w600,
                        fontSize: 15.h,
                      ),
                    ),
                    Gap(5.h),
                    Text(
                      '${LocaleKeys.Order_No.tr()} ${widget.id}',
                      style: TextStyle(
                        fontFamily: 'Tajawal7',
                        color: Styles.defualtColorWhite,
                      ),
                    ),
                  ],
                )
              ],
            ),
            Gap(15.h),
            Container(
              padding: EdgeInsets.all(5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF6F5F5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  widget.City,
                  style: const TextStyle(
                    fontFamily: 'Tajawal7',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Gap(10.h),
            Container(
              padding: EdgeInsets.all(5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF6F5F5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  widget.description,
                  style: const TextStyle(
                    fontFamily: 'Tajawal7',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Gap(10.h),
            Container(
              padding: EdgeInsets.all(5.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xffF6F5F5),
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Center(
                child: Text(
                  widget.Phone,
                  style: const TextStyle(
                    fontFamily: 'Tajawal7',
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Gap(10.h),
            widget.img2,
            Gap(10.h),
            TextFormField(
              validator: (String? val) {
                if (val!.isEmpty) {}
                return null;
              },
              style: const TextStyle(
                fontFamily: 'Tajawal7',
              ),
              cursorColor: Colors.grey.shade400,
              keyboardType: TextInputType.number,
              controller: priceController,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.never,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.h),
                filled: true,
                fillColor: const Color(0xffF6F5F5),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: .1.r, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                ),
                border: const OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(width: .1.r, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                labelText: LocaleKeys.price.tr(),
                hintText: LocaleKeys.price.tr(),
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
            Gap(20.h),
            SizedBox(
              width: 150.h,
              height: 40.h,
              child: ElevatedButton(
                onPressed: () {
                  Comfirm(priceController.text.toString());
                  APIs.sendPushNotification(
                    channelID: '1',
                    fcmToken: widget.fcmToken,
                    title: 'عرض سعر',
                    msg: 'تم ارسال عرض سعر للموافقة عليه',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                child: Text(
                  LocaleKeys.Send.tr(),
                  style: TextStyle(
                    color: Styles.defualtColorWhite,
                    fontFamily: 'Tajawal7',
                    fontSize: 15.sp,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
