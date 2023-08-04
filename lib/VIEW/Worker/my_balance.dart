import 'dart:convert';
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
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../MODEL/invice2.dart';
import '../../MODEL/invoice_model.dart';
import '../components/app_style.dart';

class MyBalanceScreen extends StatefulWidget {
  const MyBalanceScreen({Key? key}) : super(key: key);

  @override
  State<MyBalanceScreen> createState() => _MyBalanceScreenState();
}

class _MyBalanceScreenState extends State<MyBalanceScreen> {
  final userData = GetStorage();
  Future<List<InvoiceModel>> getData() async {
    final response = await http.post(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/InvoiceApi/GetCartItemsByWorkerId?WorkerId=${userData.read('token')}'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data['records']);
      return jsonData.map((Data) => InvoiceModel.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          LocaleKeys.Balance.tr(),
          style: TextStyle(
              fontFamily: 'Tajawal7',
              color: Styles.defualtColorWhite,
              fontWeight: FontWeight.w600),
        ),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
      ),
      body: Column(
        children: [
          Gap(40.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.h),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: FutureBuilder<List<InvoiceModel>>(
                future: getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<InvoiceModel?>? item = snapshot.data;
                    return SizedBox(
                      height: 500.h,
                      child: ListView.separated(
                          itemBuilder: (context, index) => Column(
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: double.infinity,
                                    padding: EdgeInsets.all(10.h),
                                    decoration: BoxDecoration(
                                        color: Styles.defualtColor,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10.r),
                                            topLeft: Radius.circular(10.r))),
                                    child: Row(
                                      children: [
                                        Text(
                                          '${LocaleKeys.Task.tr()}${item[index]!.records![index].id}',
                                          style: const TextStyle(
                                            fontFamily: 'Tajawal7',
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 100.h,
                                    padding: EdgeInsets.all(5.h),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.shade100,
                                          spreadRadius: 1,
                                          blurRadius: 3,
                                          offset: const Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Gap(20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.money),
                                                Gap(10.h),
                                                const Text('App Earn',
                                                    style: TextStyle(
                                                        fontFamily: 'Tajawal7'))
                                              ],
                                            ),
                                            Text(
                                              '${item[index]!.records![index].applicationPrice}',
                                              style: const TextStyle(
                                                fontFamily: 'Tajawal7',
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Gap(20.h),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                const Icon(Icons.money),
                                                Gap(10.h),
                                                const Text('My Earn',
                                                    style: TextStyle(
                                                        fontFamily: 'Tajawal7'))
                                              ],
                                            ),
                                            Text(
                                              '${item[0]!.records![index].workerPrice}',
                                              style: const TextStyle(
                                                  color: Colors.grey,
                                                  fontFamily: 'Tajawal7'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                          separatorBuilder: (context, index) => Gap(15.h),
                          itemCount: item!.length),
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
          ),
        ],
      ),
    );
  }
}
