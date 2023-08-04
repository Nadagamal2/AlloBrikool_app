import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:url_launcher/url_launcher.dart';

import '../components/app_style.dart';

class ServicesInfo extends StatefulWidget {
  String img;
  String description;
  String name;
  String phone;
  String faceBook;
  String insta;
  String whats;
  Widget BuildingImg;
  String location;

  ServicesInfo({
    Key? key,
    required this.img,
    required this.description,
    required this.name,
    required this.BuildingImg,
    required this.faceBook,
    required this.insta,
    required this.whats,
    required this.location,
    required this.phone,
  }) : super(key: key);

  @override
  State<ServicesInfo> createState() => _ServicesInfoState();
}

class _ServicesInfoState extends State<ServicesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 200.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(widget.img),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(20.h),
                            bottomLeft: Radius.circular(20.h))),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Icon(
                    Icons.arrow_back,
                    color: Styles.defualtColorWhite,
                  ),
                ),
              )
            ],
          ),
          Gap(15.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30.r,
                  backgroundImage: NetworkImage(widget.img),
                ),
                Gap(15.h),
                SizedBox(
                  width: 200.h,
                  child: Text(
                    widget.name,
                    style: const TextStyle(
                        fontFamily: 'Tajawal7', fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: .5,
            height: 20.h,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: SizedBox(
              width: 230.h,
              child: Text(
                widget.description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontFamily: 'Tajawal7',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Divider(
            thickness: .5,
            height: 20.h,
            color: Colors.grey.shade300,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.photo,
                  color: Colors.cyan,
                ),
                Gap(15.h),
                const Text(
                  'صورنا المميزه',
                  style: TextStyle(
                      fontFamily: 'Tajawal7', fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
          Gap(15.h),
          widget.BuildingImg,
          Gap(30.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.h),
            child: Container(
              height: 100.h,
              padding: EdgeInsets.only(top: 10.h, right: 20.h, left: 20.h),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade100,
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    'تواصل مع المحل من خلال',
                    style: TextStyle(
                        fontFamily: 'Tajawal7', fontWeight: FontWeight.w600),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          launchInBrowser(Uri.parse(widget.location));
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(
                              child: Icon(Icons.location_on_outlined)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          makePhoneCall(widget.phone);
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: const Center(child: Icon(Icons.phone)),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchInBrowser(Uri.parse('https://${widget.insta}'));
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: Image(
                            image: const AssetImage('assets/insta.png'),
                            height: 20.h,
                          )),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          launchInBrowser(
                              Uri.parse('https://wa.me/+2${widget.whats}'));
                        },
                        child: Container(
                          height: 40.h,
                          width: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade100,
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(
                                    0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Center(
                              child: Image(
                            image: const AssetImage('assets/what.png'),
                            height: 20.h,
                          )),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
