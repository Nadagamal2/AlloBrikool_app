import 'dart:convert';
import 'dart:developer';

import 'package:allo_prikool/VIEW/components/app_style.dart';
import 'package:allo_prikool/VIEW/User/HomeNavScreen/bottomNav_screen.dart';
import 'package:allo_prikool/VIEW/Payment/payment_screen.dart';
import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/bottomNavWorker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import '../../../MODEL/GetConfirmRequestOrderByApplcationUserId.dart';
import '../../../MODEL/GetRequestOrderByApplcationUserId_model.dart';
import '../../../MODEL/clintOrder_model.dart';
import '../../../MODEL/confirm_model.dart';
import '../../../MODEL/request_order_model.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import 'package:http/http.dart' as http;

import '../../Chat/chat_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  Future Delete(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/DeleteRequestOrder/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      Get.offAll(BottomNavScreen());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future Delete3(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/DeleteRequestOrder/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {
      print(response.reasonPhrase);
    }
  }

  Future Confirm(int requestOrderId) async {
    var headers = {'Content-Type': 'application/json'};
    var request = http.Request(
        'POST',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ConfirmRequestOrderApi/Create'));
    request.body =
        json.encode({"requestOrderId": requestOrderId, "IsConfirmAccepted": 1});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    } else {}
  }

  Future<List<GetRequestOrderByApplcationUserId>> getData() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/GetRequestOrderByApplcationUserId?UserId=${userData.read('token')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data['records']);
      return jsonData
          .map((Data) => GetRequestOrderByApplcationUserId.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future Delete2(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.offAll(const BottomNavScreen());
    } else {}
  }

  Future<List<GetConfirmRequestOrderByApplcationUserId>> getData2() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/ConfirmRequestOrderApi/GetConfirmRequestOrderByApplcationUserId?UserId=${userData.read('token')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      // print(response.body);
      // print(data);
      List jsonData = (data['records']);
      return jsonData
          .map(
              (Data) => GetConfirmRequestOrderByApplcationUserId.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  final userData = GetStorage();
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40.h, right: 20.h, left: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      counter = 0;
                      setState(() {});
                    },
                    child: Container(
                      width: 130.h,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: counter == 0
                              ? Styles.defualtColor
                              : Colors.grey.shade300),
                      child: Center(
                        child: Text(
                          LocaleKeys.All_Offers.tr(),
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontSize: 13.h,
                            color: counter == 0
                                ? Styles.defualtColorWhite
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      counter = 1;
                      setState(() {});
                    },
                    child: Container(
                      width: 130.h,
                      height: 40.h,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: counter == 1
                              ? Styles.defualtColor
                              : Colors.grey.shade300),
                      child: Center(
                        child: Text(
                          LocaleKeys.My_requests.tr(),
                          style: TextStyle(
                            fontFamily: 'Tajawal7',
                            fontSize: 13.h,
                            color: counter == 1
                                ? Styles.defualtColorWhite
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: .5,
              height: 20.h,
              color: Colors.grey,
            ),
            counter == 0
                ? FutureBuilder<List<GetRequestOrderByApplcationUserId>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<GetRequestOrderByApplcationUserId?>? item =
                            snapshot.data;
                        return item!.length == 0
                            ? Column(
                                children: [
                                  Gap(50.h),
                                  SvgPicture.asset('assets/2222.svg'),
                                  Gap(30.h),
                                  Text(
                                    LocaleKeys.There_are_no_offers_to_display
                                        .tr(),
                                    style: TextStyle(
                                        fontFamily: 'Tajawal7',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 15.h),
                                  )
                                ],
                              )
                            : Padding(
                                padding: EdgeInsets.symmetric(horizontal: 20.h),
                                child: Column(
                                  children: item
                                      .map(
                                        (e) => Column(
                                          children: [
                                            Container(
                                              height: 200.h,
                                              width: double.infinity,
                                              padding: EdgeInsets.all(10.h),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black,
                                                    width: 1),
                                                borderRadius:
                                                    BorderRadius.circular(15.h),
                                              ),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                                    color: Styles
                                                                        .defualtColorWhite,
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    image:
                                                                        const DecorationImage(
                                                                      fit: BoxFit
                                                                          .fitHeight,
                                                                      image: AssetImage(
                                                                          'assets/logo22.png'),
                                                                    )),
                                                            height: 50.h,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    1.h),
                                                            width: 50.h,
                                                          ),
                                                          Gap(10.h),
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                  '${e!.workerApplicationUser!.name}'),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons.star,
                                                            color: Colors
                                                                .grey.shade300,
                                                            size: 15.sp,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Styles
                                                                .defualtColor,
                                                            size: 15.sp,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Styles
                                                                .defualtColor,
                                                            size: 15.sp,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Styles
                                                                .defualtColor,
                                                            size: 15.sp,
                                                          ),
                                                          Icon(
                                                            Icons.star,
                                                            color: Styles
                                                                .defualtColor,
                                                            size: 15.sp,
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  Gap(10.h),
                                                  Text(
                                                    LocaleKeys.I_will_do_the
                                                        .tr(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Tajawal7',
                                                    ),
                                                  ),
                                                  Gap(10.h),
                                                  Container(
                                                    height: 40.h,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20.h),
                                                    width: double.infinity,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: Colors.black,
                                                          width: 1),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.h),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          LocaleKeys.price.tr(),
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              color: Colors.grey
                                                                  .shade400),
                                                        ),
                                                        Text(
                                                          '${e.requestPrice} ${LocaleKeys.DZD.tr()}',
                                                          style:
                                                              const TextStyle(
                                                            fontFamily:
                                                                'Tajawal7',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                  Gap(10.h),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: 120.h,
                                                        height: 34.h,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Confirm(e.id!);
                                                            Get.to(
                                                                PaymentScreen(
                                                              Name:
                                                                  '${e.clientOrder!.name}',
                                                              Price:
                                                                  '${e.requestPrice}',
                                                              requestOrderId:
                                                                  e.id!,
                                                              requestOrderwId:
                                                                  '${e.id}',
                                                              num:
                                                                  '${e.workerApplicationUser!.name}',
                                                              phone:
                                                                  '${e.workerApplicationUser!.phoneNumber}',
                                                              fcmToken:
                                                                  'wait to get from api',
                                                            ));

                                                            userData.write(
                                                                'NameWorker',
                                                                e.workerApplicationUser!
                                                                    .name);
                                                            userData.write(
                                                                'idRequest',
                                                                e.id);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.green,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.r),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            LocaleKeys.Accept
                                                                .tr(),
                                                            style: TextStyle(
                                                              color: Styles
                                                                  .defualtColorWhite,
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 120.h,
                                                        height: 34.h,
                                                        child: ElevatedButton(
                                                          onPressed: () {
                                                            Delete(e.id!);
                                                          },
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                Colors.red,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5.r),
                                                            ),
                                                          ),
                                                          child: Text(
                                                            LocaleKeys.Reject
                                                                .tr(),
                                                            style: TextStyle(
                                                              color: Styles
                                                                  .defualtColorWhite,
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Gap(15.h),
                                          ],
                                        ),
                                      )
                                      .toList(),
                                ),
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Styles.defualtColor),
                          ),
                        );
                      }
                    },
                  )
                : Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
                    child: FutureBuilder<
                        List<GetConfirmRequestOrderByApplcationUserId>>(
                      future: getData2(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          List<GetConfirmRequestOrderByApplcationUserId?>?
                              item = snapshot.data;
                          return item!.length == 0
                              ? Column(
                                  children: [
                                    Gap(50.h),
                                    SvgPicture.asset('assets/2222.svg'),
                                    Gap(30.h),
                                    Text(
                                      LocaleKeys.There_are_no_orders_to_display
                                          .tr(),
                                      style: TextStyle(
                                          fontFamily: 'Tajawal7',
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.h),
                                    )
                                  ],
                                )
                              : SingleChildScrollView(
                                  physics: const BouncingScrollPhysics(),
                                  child: SizedBox(
                                    height: 500.h,
                                    child: ListView.separated(
                                        itemBuilder: (context, index) => Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(10.h),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    color: Styles
                                                        .defualtColorWhite,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                        color: Styles
                                                                            .defualtColor,
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        image:
                                                                            DecorationImage(
                                                                          fit: BoxFit
                                                                              .fill,
                                                                          image:
                                                                              NetworkImage("http://eibtek2-001-site20.atempurl.com/Files/Imgs/${item[index]!.requestOrder!.clientOrder!.photoName}"),
                                                                        )),
                                                                height: 50.h,
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(2
                                                                            .h),
                                                                width: 50.h,
                                                              ),
                                                              Gap(10.h),
                                                              Column(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  SizedBox(
                                                                    width:
                                                                        170.h,
                                                                    child: Text(
                                                                      '${item[index]!.requestOrder!.clientOrder!.desc}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            'Tajawal7',
                                                                        color: Styles
                                                                            .defualtColor,
                                                                        fontWeight:
                                                                            FontWeight.w600,
                                                                        fontSize:
                                                                            15.h,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Gap(5.h),
                                                                  Text(
                                                                    '${LocaleKeys.City.tr()} : ${item[index]!.requestOrder!.clientOrder!.title}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          'Tajawal7',
                                                                      color: Styles
                                                                          .defualtColor,
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 10.w),
                                                            child: InkWell(
                                                                onTap:
                                                                    () async {
                                                                  Get.to(
                                                                      Chat2Screen(
                                                                    serviceID:
                                                                        '${item[index]!.requestOrder!.id}',
                                                                    fcmToken: item[index]!
                                                                            .requestOrder!
                                                                            .workerApplicationUser!
                                                                            .deviceToken ??
                                                                        '',
                                                                  ));
                                                                },
                                                                child: Icon(
                                                                  Icons.chat,
                                                                  color: Styles
                                                                      .defualtColor,
                                                                )),
                                                          ),
                                                        ],
                                                      ),
                                                      Gap(10.h),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            LocaleKeys.Note_
                                                                .tr(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              color: Styles
                                                                  .defualtColor,
                                                            ),
                                                          ),
                                                          Gap(10.h),
                                                          Text(
                                                            LocaleKeys
                                                                    .You_must_confirm_the
                                                                .tr(),
                                                            style: TextStyle(
                                                              fontFamily:
                                                                  'Tajawal7',
                                                              color: Styles
                                                                  .defualtColor,
                                                            ),
                                                          ),
                                                          Gap(10.h),
                                                          Container(
                                                            height: 45.h,
                                                            width:
                                                                double.infinity,
                                                            padding:
                                                                EdgeInsets.all(
                                                                    5.h),
                                                            decoration:
                                                                BoxDecoration(
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .grey,
                                                                  width: .5),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.h),
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                LocaleKeys
                                                                        .Your_reservation
                                                                    .tr(),
                                                                style:
                                                                    const TextStyle(
                                                                  fontFamily:
                                                                      'Tajawal7',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      Gap(20.h),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          SizedBox(
                                                            height: 35.h,
                                                            width: 130.h,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                showDialog(
                                                                    context:
                                                                        context,
                                                                    builder:
                                                                        (context) =>
                                                                            Dialog(
                                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                                                              child: SizedBox(
                                                                                height: 210.h,
                                                                                width: 280.w,
                                                                                child: Padding(
                                                                                  padding: EdgeInsets.symmetric(horizontal: 35.h, vertical: 15.h),
                                                                                  child: Column(
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Text(
                                                                                        LocaleKeys.Has_the_worker_been_contacted.tr(),
                                                                                        textAlign: TextAlign.center,
                                                                                        style: TextStyle(
                                                                                          fontFamily: 'Tajawal7',
                                                                                          fontWeight: FontWeight.w500,
                                                                                          fontSize: 17.sp,
                                                                                        ),
                                                                                      ),
                                                                                      Gap(20.h),
                                                                                      Row(
                                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                                        children: [
                                                                                          SizedBox(
                                                                                            width: 80.h,
                                                                                            height: 40.h,
                                                                                            child: ElevatedButton(
                                                                                              onPressed: () {
                                                                                                Delete(userData.read('idRequest'));

                                                                                                Delete2(item[index]!.requestOrder!.clientOrder!.id!);
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Styles.defualtColor,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(5.r),
                                                                                                ),
                                                                                              ),
                                                                                              child: Text(
                                                                                                LocaleKeys.yes.tr(),
                                                                                                style: TextStyle(
                                                                                                  color: Styles.defualtColorWhite,
                                                                                                  fontFamily: 'Tajawal7',
                                                                                                  fontSize: 15.sp,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          Gap(20.h),
                                                                                          SizedBox(
                                                                                            width: 80.h,
                                                                                            height: 40.h,
                                                                                            child: ElevatedButton(
                                                                                              onPressed: () {
                                                                                                Get.back();
                                                                                              },
                                                                                              style: ElevatedButton.styleFrom(
                                                                                                backgroundColor: Styles.defualtColor,
                                                                                                shape: RoundedRectangleBorder(
                                                                                                  borderRadius: BorderRadius.circular(5.r),
                                                                                                ),
                                                                                              ),
                                                                                              child: Text(
                                                                                                LocaleKeys.No.tr(),
                                                                                                style: TextStyle(
                                                                                                  color: Styles.defualtColorWhite,
                                                                                                  fontFamily: 'Tajawal7',
                                                                                                  fontSize: 15.sp,
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ));
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5.r),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                LocaleKeys
                                                                        .Confirm_Request
                                                                    .tr(),
                                                                style:
                                                                    TextStyle(
                                                                  color: Styles
                                                                      .defualtColorWhite,
                                                                  fontFamily:
                                                                      'Tajawal7',
                                                                  fontSize:
                                                                      14.sp,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Gap(10.h),
                                              ],
                                            ),
                                        separatorBuilder: (context, index) =>
                                            Gap(10.h),
                                        itemCount: item.length),
                                  ));
                        } else {
                          return Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Styles.defualtColor),
                            ),
                          );
                        }
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
