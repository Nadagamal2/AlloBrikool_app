import 'dart:convert';
import 'package:allo_prikool/VIEW/Worker/oder_member_details_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../../MODEL/client_order_by_id.dart';
import '../../../MODEL/clintOrder_model.dart';
import '../../../MODEL/clintOrderbServices.dart';
import '../../../MODEL/request_order_model.dart';
import '../../components/app_style.dart';
import 'bottomNavWorker.dart';

class OrderMemberScreen extends StatefulWidget {
  const OrderMemberScreen({Key? key}) : super(key: key);

  @override
  State<OrderMemberScreen> createState() => _OrderMemberScreenState();
}

class _OrderMemberScreenState extends State<OrderMemberScreen> {
  int counter1 = 0;
  Future<List<clintOrderbServices>> getData() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/GetByServiceName?ServiceName=${userData.read('Specialty')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data['records']);
      return jsonData
          .map((Data) => clintOrderbServices.fromJson(Data))
          .toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  final userData = GetStorage();

  Future<List<ClientOrderIdModel>?> getData2(int id) async {
    var request = http.Request(
        'GET',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/${id}'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
    } else {}
  }

  Future Delete(int id) async {
    var request = http.Request(
        'DELETE',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi/${id}'));

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
          LocaleKeys.Current_Order.tr(),
          style: const TextStyle(
            fontFamily: 'Tajawal7',
          ),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 20.w, left: 20.w, top: 20.h),
        child: FutureBuilder<List<clintOrderbServices>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<clintOrderbServices?>? item = snapshot.data;
              return item!.length == 0
                  ? Center(
                      child: Column(
                        children: [
                          Gap(50.h),
                          SvgPicture.asset('assets/2222.svg'),
                          Gap(30.h),
                          Text(
                            LocaleKeys.There_are_no_orders_to_display.tr(),
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
                      child: Column(
                        children: item
                            .map(
                              (e) => Column(
                                children: [
                                  Container(
                                    height: 130.h,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.h),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      color: Styles.defualtColor,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                  color:
                                                      Styles.defualtColorWhite,
                                                  shape: BoxShape.circle,
                                                  image: DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(
                                                        "http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e!.photoName}"),
                                                  )),
                                              height: 50.h,
                                              padding: EdgeInsets.all(2.h),
                                              width: 50.h,
                                            ),
                                            Gap(10.h),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${e.name}',
                                                  style: TextStyle(
                                                    fontFamily: 'Tajawal7',
                                                    color: Styles
                                                        .defualtColorWhite,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 15.h,
                                                  ),
                                                ),
                                                Gap(5.h),
                                                Text(
                                                  '${LocaleKeys.Order_No.tr()} ${e.id}',
                                                  style: TextStyle(
                                                    fontFamily: 'Tajawal7',
                                                    color: Styles
                                                        .defualtColorWhite,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              height: 30.h,
                                              width: 70.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  userData.write(
                                                      'clintId', e.id);
                                                  Get.to(
                                                      OrderMemberDetailsScreen(
                                                    id: e.id!,
                                                    name: '${e.name}',
                                                    description: '${e.desc}',
                                                    City: '${e.title}',
                                                    fcmToken: 'wait to get it',
                                                    img1:
                                                        'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e.photoName}',
                                                    img2: Container(
                                                      width: double.infinity,
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 17.h,
                                                              horizontal: 0.h),
                                                      child: CarouselSlider(
                                                          options:
                                                              CarouselOptions(
                                                            onPageChanged:
                                                                (index,
                                                                    reason) {
                                                              setState(() {
                                                                counter1 =
                                                                    index;
                                                              });
                                                            },
                                                            height: 120.h,
                                                            viewportFraction:
                                                                .95.h,
                                                            enlargeCenterPage:
                                                                true,
                                                            aspectRatio:
                                                                16 / 9.h,
                                                            autoPlayCurve: Curves
                                                                .fastLinearToSlowEaseIn,
                                                            pauseAutoPlayOnTouch:
                                                                true,
                                                            autoPlayAnimationDuration:
                                                                const Duration(
                                                                    milliseconds:
                                                                        900),
                                                          ),
                                                          items: e
                                                              .clientOrderPhotos!
                                                              .map(
                                                                  (e) =>
                                                                      Container(
                                                                        margin: EdgeInsets.symmetric(
                                                                            horizontal:
                                                                                10.h),
                                                                        decoration:
                                                                            BoxDecoration(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10.h),
                                                                          image: DecorationImage(
                                                                              fit: BoxFit.fill,
                                                                              image: NetworkImage('http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e.imgURL}')),
                                                                        ),
                                                                      ))
                                                              .toList()),
                                                    ),
                                                    Phone: '${e.phoneNumber}',
                                                  ));
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.amber,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                  ),
                                                ),
                                                child: Text(
                                                  LocaleKeys.Accept.tr(),
                                                  style: TextStyle(
                                                    color: Styles
                                                        .defualtColorWhite,
                                                    fontFamily: 'Tajawal7',
                                                    fontSize: 13.sp,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Gap(10.h),
                                            SizedBox(
                                              height: 30.h,
                                              width: 70.h,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  Delete(e.id!);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15.r),
                                                  ),
                                                ),
                                                child: Text(
                                                  LocaleKeys.Reject.tr(),
                                                  style: TextStyle(
                                                    color: Styles
                                                        .defualtColorWhite,
                                                    fontFamily: 'Tajawal7',
                                                    fontSize: 13.sp,
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
                            )
                            .toList(),
                      ),
                    );
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
