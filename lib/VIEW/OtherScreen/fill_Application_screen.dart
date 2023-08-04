import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../User/SettingScreen/setting_screen.dart';
import '../components/app_style.dart';
import 'fill_done _screen.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

class FillApplications extends StatefulWidget {
  const FillApplications({Key? key}) : super(key: key);

  @override
  State<FillApplications> createState() => _FillApplicationsState();
}

class _FillApplicationsState extends State<FillApplications> {
  String? imag;
  ImagePicker image = ImagePicker();
  List<XFile>? imageFileList = [];
  List<String>? path = [];
  void selectImages() async {
    List<XFile>? selectedImages = await image.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList!.addAll(selectedImages);
    }

    setState(() {});
  }

  final double height = 120.h;
  void fillRequest(
    String Name,
    String Address,
    String details,
    String Phone,
  ) async {
    try {
      var request = http.MultipartRequest(
          'POST',
          Uri.parse(
              'http://eibtek2-001-site20.atempurl.com/api/ClientOrderApi'));
      request.fields.addAll({
        'Name': Name,
        'Title': Address,
        'Desc': details,
        'PhoneNumber': Phone,
        'ServiceId': '${userData.read('serviceId')}',
        'ApplicationUserId': '${userData.read('token')}',
      });
      for (int i = 0; i < path!.length; i++) {
        request.files.add(await http.MultipartFile.fromPath('Photo', path![i]));
      }
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        Get.to(const FillDoneScreen());
        setState(() {
          isDone = false;
        });
      } else {
        setState(() {
          isDone = false;
          Fluttertoast.showToast(
              msg: 'اختر صور',
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              textColor: Colors.white,
              fontSize: 16.0);
        });
      }
    } catch (e) {}
  }

  TextEditingController NameController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  TextEditingController DetailsController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  @override
  void dispose() {
    NameController.dispose();
    AddressController.dispose();
    DetailsController.dispose();
    PhoneController.dispose();

    super.dispose();
  }

  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65.h,
        elevation: 0,
        backgroundColor: Styles.defualtColor,
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 30.sp,
            )),
        centerTitle: true,
        title: Text(
          LocaleKeys.Fill_out_the_application_here.tr(),
          style: TextStyle(
            fontFamily: 'Tajawal7',
            fontSize: 15.sp,
          ),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Gap(20.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Gap(10.h),
                      Text(
                        (LocaleKeys.Fill_out_the_application_here.tr()),
                        style: TextStyle(
                          fontFamily: 'Tajawal7',
                          fontWeight: FontWeight.w600,
                          fontSize: 20.sp,
                        ),
                      ),
                      Gap(20.h),
                      TextFormField(
                        validator: (String? val) {
                          if (val!.isEmpty) {}
                          return null;
                        },
                        style: const TextStyle(
                          fontFamily: 'Tajawal7',
                        ),
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.emailAddress,
                        controller: NameController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.h),
                          filled: true,
                          fillColor: const Color(0xffF6F5F5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelText: LocaleKeys
                              .The_name_is_accompanied_by_the_surname.tr(),
                          hintText: LocaleKeys
                              .The_name_is_accompanied_by_the_surname.tr(),
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
                        keyboardType: TextInputType.emailAddress,
                        controller: AddressController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.h),
                          filled: true,
                          fillColor: const Color(0xffF6F5F5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelText: LocaleKeys.Detailed_address.tr(),
                          hintText: LocaleKeys.Detailed_address.tr(),
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
                      Gap(10.h),
                      SizedBox(
                        height: height,
                        child: TextFormField(
                          style: const TextStyle(
                            fontFamily: 'Tajawal7',
                          ),
                          cursorColor: Colors.grey.shade400,
                          maxLines: height ~/ 20.h,
                          keyboardType: TextInputType.text,
                          controller: DetailsController,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.h, horizontal: 10.h),
                            filled: true,
                            fillColor: const Color(0xffF6F5F5),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            border: const OutlineInputBorder(),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  width: .1.r, color: Colors.transparent),
                              borderRadius: BorderRadius.circular(10.r),
                            ),
                            labelText: LocaleKeys.Service_details.tr(),
                            hintText: LocaleKeys.Service_details.tr(),
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
                      TextFormField(
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            // return LocaleKeys.please_enter_your_email.tr();
                          }
                          return null;
                        },
                        style: const TextStyle(
                          fontFamily: 'Tajawal7',
                        ),
                        cursorColor: Colors.grey.shade400,
                        keyboardType: TextInputType.number,
                        controller: PhoneController,
                        decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.h),
                          filled: true,
                          fillColor: const Color(0xffF6F5F5),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: const OutlineInputBorder(),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                width: .1.r, color: Colors.transparent),
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          labelText: LocaleKeys.Phone_number.tr(),
                          hintText: LocaleKeys.Phone_number.tr(),
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
                      Gap(10.h),
                      Column(
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              selectImages();
                            },
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(double.infinity, 45.h),
                              maximumSize: Size(double.infinity, 45.h),
                              minimumSize: Size(double.infinity, 45.h),
                              backgroundColor: const Color(0xffF6F5F5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Select_Images.tr(),
                              style: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.h),
                            child: Row(
                              children: imageFileList!.map((e) {
                                userData.write('images', e.path);
                                path!.add(userData.read('images'));
                                return Container(
                                  margin:
                                      EdgeInsets.only(right: 10.w, left: 10.w),
                                  child: Image.file(
                                    File(e.path),
                                    fit: BoxFit.fill,
                                    height: 100.h,
                                    width: 100.h,
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                      Gap(20.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {
                            if (NameController.text.isEmpty ||
                                NameController.text == null) {
                              Fluttertoast.showToast(
                                  msg: 'ادخل الاسم',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (AddressController.text.isEmpty ||
                                AddressController.text == null) {
                              Fluttertoast.showToast(
                                  msg: 'ادخل العنوان',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (DetailsController.text.isEmpty ||
                                DetailsController.text == null) {
                              Fluttertoast.showToast(
                                  msg: 'ادخل التفاصيل',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else if (PhoneController.text.isEmpty ||
                                PhoneController.text == null) {
                              Fluttertoast.showToast(
                                  msg: 'ادخل رقم الجوال',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            } else {
                              setState(() {
                                isDone = true;
                              });
                              fillRequest(
                                NameController.text.toString(),
                                AddressController.text.toString(),
                                DetailsController.text.toString(),
                                PhoneController.text.toString(),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Styles.defualtColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                          ),
                          child: Text(
                            LocaleKeys.Reservation_request.tr(),
                            textAlign: TextAlign.center,
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
                Gap(20.h),
              ],
            ),
          ),
          if (isDone == true)
            AbsorbPointer(
              child: Center(
                child: CircularProgressIndicator(color: Styles.defualtColor),
              ),
            ),
        ],
      ),
    );
  }
}
