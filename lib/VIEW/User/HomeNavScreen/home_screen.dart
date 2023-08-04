import 'dart:convert';
import 'dart:developer';
import 'package:allo_prikool/VIEW/User/SettingScreen/setting_screen.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../../MODEL/services_model.dart';
import '../../../MODEL/slider_model.dart';
import '../../OtherScreen/fill_Application_screen.dart';
import '../../OtherScreen/notification_screen.dart';
import '../../OtherScreen/search_screen.dart';
import '../../components/app_style.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<List<SliderModel>> getData2() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/Slider1Api/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data);
      return jsonData.map((Data) => SliderModel.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  int counter1 = 0;
  TextEditingController NameController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController DetailsController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();

  Future<List<ServicsModel>> getData() async {
    final response = await http.get(Uri.parse(
        'http://eibtek2-001-site20.atempurl.com/api/ServiceApi/GetAll'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      List jsonData = (data);
      return jsonData.map((Data) => ServicsModel.fromJson(Data)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  late PersistentBottomSheetController _controller; // <------ Instance variable
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final double height = 120.h;
  static File? file;
  String? imag;
  ImagePicker image = ImagePicker();
  getGallery() async {
    var img = await image.pickImage(source: ImageSource.gallery);
    setState(() {
      file = File(img!.path);
      imag = img.path;
    });
  }

  int count = 0;
  getFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    log(fcmToken.toString());
  }

  @override
  void initState() {
    getFcmToken();
    FirebaseMessaging.onMessage.listen((RemoteMessage messagr) {
      setState(() {
        count++;
        userData.write('count', count);
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    NameController.dispose();
    AddressController.dispose();
    DetailsController.dispose();
    PhoneController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Stack(
                children: [
                  Container(
                    height: 130.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Styles.defualtColor,
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15.r),
                            bottomRight: Radius.circular(15.h))),
                  ),
                  Positioned(
                      height: 130.h,
                      right: 110.h,
                      top: -5,
                      child: SvgPicture.asset('assets/Group 88666.svg')),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.h, right: 20.h, left: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          LocaleKeys.Welcome.tr(),
                          style: TextStyle(
                              fontFamily: 'Tajawal7',
                              color: Styles.defualtColorWhite,
                              fontWeight: FontWeight.w600),
                        ),
                        Gap(5.h),
                        Text(
                          LocaleKeys.In_the_AlloBrikool_app.tr(),
                          style: TextStyle(
                              fontFamily: 'Tajawal7',
                              color: Styles.defualtColorWhite,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(const NotificationScreen());
                              },
                              child: CircleAvatar(
                                radius: 20.r,
                                backgroundColor: Colors.black45,
                                child: Icon(
                                  Icons.notifications,
                                  color: Styles.defualtColorWhite,
                                ),
                              ),
                            ),
                            userData.read('count') == null
                                ? Positioned(
                                    left: 1,
                                    child: CircleAvatar(
                                      radius: 7.r,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '0',
                                        style: TextStyle(
                                            fontFamily: 'Tajawal7',
                                            color: Styles.defualtColorWhite,
                                            fontSize: 8.sp),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    left: 1,
                                    child: CircleAvatar(
                                      radius: 7.r,
                                      backgroundColor: Colors.red,
                                      child: Text(
                                        '${userData.read('count')}',
                                        style: TextStyle(
                                            fontFamily: 'Tajawal7',
                                            color: Styles.defualtColorWhite,
                                            fontSize: 6.sp),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Gap(5.h),
                        InkWell(
                          onTap: () {
                            showSearch(context: context, delegate: search());
                          },
                          child: CircleAvatar(
                            radius: 20.r,
                            backgroundColor: Colors.black45,
                            child: Icon(
                              Icons.search,
                              color: Styles.defualtColorWhite,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
          FutureBuilder<List<SliderModel?>>(
            future: getData2(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<SliderModel?>? item = snapshot.data;
                return Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(vertical: 17.h, horizontal: 15.h),
                  child: CarouselSlider(
                      options: CarouselOptions(
                        onPageChanged: (index, reason) {
                          setState(() {
                            counter1 = index;
                          });
                        },
                        height: 120.h,
                        autoPlay: true,
                        viewportFraction: .95.h,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9.h,
                        autoPlayCurve: Curves.fastLinearToSlowEaseIn,
                        pauseAutoPlayOnTouch: true,
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 900),
                      ),
                      items: item!
                          .map((e) => Container(
                                margin: EdgeInsets.symmetric(horizontal: 10.h),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.h),
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: NetworkImage(
                                          'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e!.photoName}')),
                                ),
                              ))
                          .toList()),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
          FutureBuilder<List<ServicsModel>>(
              future: getData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<ServicsModel?>? item = snapshot.data;
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: SizedBox(
                      height: 325.h,
                      width: double.infinity,
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.Our_services.tr(),
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                fontFamily: 'Tajawal7',
                              ),
                            ),
                            Gap(10.h),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: item!
                                    .map((e) => Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                userData.write(
                                                    'serviceId', e.id);

                                                Get.to(
                                                    const FillApplications());
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors
                                                            .grey.shade200,
                                                        spreadRadius: 5,
                                                        blurRadius: 7,
                                                        offset: const Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                    color: Styles
                                                        .defualtColorWhite,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.h)),
                                                child: Column(
                                                  children: [
                                                    Container(
                                                      width: double.infinity,
                                                      height: 140.h,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                                  topLeft: Radius
                                                                      .circular(
                                                                          10.r),
                                                                  topRight: Radius
                                                                      .circular(10
                                                                          .h)),
                                                          image: DecorationImage(
                                                              fit: BoxFit.fill,
                                                              image: NetworkImage(
                                                                  'http://eibtek2-001-site20.atempurl.com/Files/Imgs/${e!.photoName}'))),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 15.h),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: [
                                                          Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Gap(10.h),
                                                              Text(
                                                                e.name,
                                                                style: TextStyle(
                                                                    fontFamily:
                                                                        'Tajawal7',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    fontSize:
                                                                        16.h),
                                                              ),
                                                              Gap(10.h),
                                                              SizedBox(
                                                                width: 190.h,
                                                                child: Text(
                                                                  e.description,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontFamily:
                                                                        'Tajawal7',
                                                                  ),
                                                                ),
                                                              ),
                                                              Gap(10.h),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Gap(10.h),
                                          ],
                                        ))
                                    .toList(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Gap(100),
                      Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                              Styles.defualtColor),
                        ),
                      ),
                    ],
                  );
                }
              })
        ],
      ),
    );
  }
}
