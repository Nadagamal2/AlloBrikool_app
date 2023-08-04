import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'dart:ui' as ui;
import 'package:http/http.dart' as http;

import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../MODEL/termsAndCondition_model.dart';
import '../components/app_style.dart';

List<TermsAndConditionsModel> termsAndConditions = [];
Future<List<TermsAndConditionsModel>> getData() async {
  final response = await http.get(Uri.parse(
      'http://eibtek2-001-site20.atempurl.com/api/TermsConditionsApi/GetAll'));
  var data = jsonDecode(response.body.toString());
  for (var element in data) {
    termsAndConditions.add(TermsAndConditionsModel.fromJson(element));
  }
  if (response.statusCode == 200) {
    List jsonData = (data);
    return jsonData
        .map((categoryData) => TermsAndConditionsModel.fromJson(categoryData))
        .toList();
  } else {
    throw Exception('Failed to load album');
  }
}

class TermsAndConditionsScreen extends StatelessWidget {
  const TermsAndConditionsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: ui.TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Styles.defualtColorWhite,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.bottomCenter,
                height: 100.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(25.r),
                      bottomRight: Radius.circular(25.r)),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.h, vertical: 28.h),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              color: Styles.defualtColorWhite,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade200,
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                      0, 1), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 19.h,
                            )),
                      ),
                      Text(
                        LocaleKeys.Terms_and_Conditions.tr(),
                        style: TextStyle(
                          fontFamily: 'Tajawal7',
                          color: Styles.defualtColor2,
                          fontSize: 17.sp,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                            height: 20.h,
                            width: 20.h,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: Icon(
                              Icons.keyboard_arrow_right_outlined,
                              size: 19.h,
                              color: Colors.transparent,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  FutureBuilder<List<TermsAndConditionsModel?>>(
                    future: getData(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<TermsAndConditionsModel?>? item = snapshot.data;
                        return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.h),
                            child: SizedBox(
                              height: 500.h,
                              child: ListView.separated(
                                  itemBuilder: (context, index) => Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CircleAvatar(
                                              radius: 5.r,
                                              backgroundColor:
                                                  Styles.defualtColorBlack,
                                            ),
                                            Gap(5.h),
                                            SizedBox(
                                              width: 270.h,
                                              child: Text(
                                                item[index]!.details,
                                                textAlign: TextAlign.start,
                                                style: const TextStyle(
                                                    fontFamily: 'Tajawal7'),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                  separatorBuilder: (context, index) =>
                                      Gap(20.h),
                                  itemCount: item!.length),
                            ));
                      } else {
                        return Column(
                          children: [
                            Gap(100.h),
                            Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Styles.defualtColor),
                              ),
                            ),
                          ],
                        );
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
