import 'dart:convert';
import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import '../../Chat/chat_screen.dart';
import '../../components/app_style.dart';
import '../../../MODEL/request_order_model.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import 'bottomNavWorker.dart';

class RequestWorkerScreen extends StatefulWidget {
  const RequestWorkerScreen({Key? key}) : super(key: key);

  @override
  State<RequestWorkerScreen> createState() => _RequestWorkerScreenState();
}

class _RequestWorkerScreenState extends State<RequestWorkerScreen> {
  Future DeleteClintId(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  Future<List<Records>> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/GetAllRequestOrders'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data['records']);
      return jsonData.map((Data) => Records.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  final userData = GetStorage();
  Future Delete(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/RequestOrderApi/DeleteRequestOrder/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      Get.offAll(const BottomNavWokerScreen());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.My_Orders.tr(),
          style: TextStyle(
              fontFamily: 'Tajawal7',
              color: Styles.defualtColorWhite,
              fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: FutureBuilder<List<Records>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Records?>? item = snapshot.data;
              return item!.length == 0
                  ? Center(
                      child: Column(
                        children: [
                          Gap(50.h),
                          SvgPicture.asset('assets/2222.svg'),
                          Gap(30.h),
                          Text(
                            LocaleKeys.There_are_no_request_to_display.tr(),
                            style: TextStyle(
                                fontFamily: 'Tajawal7',
                                fontWeight: FontWeight.w600,
                                fontSize: 15.h),
                          )
                        ],
                      ),
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
                                            BorderRadius.circular(10.r),
                                        color: Styles.defualtColorWhite,
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Styles.defualtColor,
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                          fit: BoxFit.fill,
                                                          image: NetworkImage(
                                                              "http://eibtek2-001-site20.atempurl.com/Files/Imgs/${item[index]!.clientOrder!.photoName}"),
                                                        )),
                                                    height: 50.h,
                                                    padding:
                                                        EdgeInsets.all(2.h),
                                                    width: 50.h,
                                                  ),
                                                  Gap(10.h),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 170.h,
                                                        child: Text(
                                                          '${item[index]!.clientOrder!.desc}',
                                                          style: TextStyle(
                                                            fontFamily:
                                                                'Tajawal7',
                                                            color: Styles
                                                                .defualtColor,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 15.h,
                                                          ),
                                                        ),
                                                      ),
                                                      Gap(5.h),
                                                      Text(
                                                        '${LocaleKeys.City_.tr()} ${item[index]!.clientOrder!.title}',
                                                        style: TextStyle(
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
                                                    EdgeInsets.only(left: 10.w),
                                                child: InkWell(
                                                    onTap: () {
                                                      Get.to(() => Chat2Screen(
                                                          serviceID:
                                                              '${item[index]!.id}',
                                                          fcmToken: item[index]!
                                                                  .clientOrder!
                                                                  .applicationUser![
                                                              'deviceToken']));
                                                    },
                                                    child: Icon(
                                                      Icons.chat,
                                                      color:
                                                          Styles.defualtColor,
                                                    )),
                                              ),
                                            ],
                                          ),
                                          Gap(10.h),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                LocaleKeys.Note_.tr(),
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal7',
                                                  color: Styles.defualtColor,
                                                ),
                                              ),
                                              Gap(10.h),
                                              Text(
                                                LocaleKeys.You_must_confirm_the
                                                    .tr(),
                                                style: TextStyle(
                                                  fontFamily: 'Tajawal7',
                                                  color: Styles.defualtColor,
                                                ),
                                              ),
                                              Gap(10.h),
                                              Container(
                                                height: 30.h,
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.grey,
                                                      width: .5),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.h),
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    LocaleKeys
                                                            .Was_the_work_completed_for_the_client
                                                        .tr(),
                                                    style: const TextStyle(
                                                      fontFamily: 'Tajawal7',
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Gap(20.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                height: 35.h,
                                                width: 130.h,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    Delete(item[index]!.id!);
                                                    DeleteClintId(item[index]!
                                                        .clientOrder!
                                                        .id!);
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.green,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.r),
                                                    ),
                                                  ),
                                                  child: Text(
                                                    LocaleKeys.Confirm_Request
                                                        .tr(),
                                                    style: TextStyle(
                                                      color: Styles
                                                          .defualtColorWhite,
                                                      fontFamily: 'Tajawal7',
                                                      fontSize: 14.sp,
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
                            separatorBuilder: (context, index) => Gap(10.h),
                            itemCount: item.length),
                      ));
            } else {
              return Center(
                child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(Styles.defualtColor),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
