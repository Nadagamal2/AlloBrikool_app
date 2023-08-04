import 'dart:convert';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:http/http.dart' as http;
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../MODEL/services_model.dart';
import '../Auth/sign_in.dart';
import '../components/app_style.dart';
import 'HomeNavWorker/bottomNavWorker.dart';

class SignUpWorker extends StatefulWidget {
  const SignUpWorker({Key? key}) : super(key: key);

  @override
  State<SignUpWorker> createState() => _SignUpWorkerState();
}

class _SignUpWorkerState extends State<SignUpWorker> {
  final _kind = [
    LocaleKeys.Are__user_or_a_technical_worker.tr(),
    "User",
    "Worker"
  ];
  String? _selectvalue = LocaleKeys.Are__user_or_a_technical_worker.tr();
  BookDoctorScreen() {
    _selectvalue = _kind[0];
  }

  void ValidateEmail(String email) {
    bool isvalid = EmailValidator.validate(email);
    userData.write('isvalid', isvalid);
    if (isvalid == false) {
      Fluttertoast.showToast(
          msg: LocaleKeys.Enter_the_correct_email_address.tr(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          backgroundColor: Colors.red,
          fontSize: 16.0);
    }
  }

  final _kind2 = [
    LocaleKeys.Specialty.tr(),
    "مستخدم",
    "دهان",
    "لحام",
    "مساعد بناء",
    "بستاني",
    "عامل يومي",
    "عامل التنظيف",
    "عاملة التنظيف",
    "كهربائي بناء",
    "مصلح المكيفات الهوائية",
    "مصلح الاقمار الصناعية",
    "مصلح أجهزة الكبيوتر",
    "نجار",
    "نجار الالمنيوم",
    "بلاكوبلاتر",
    "تلحيم الحديد",
    "بناء الخرساني",
    "إصلاح السيارات",
    "مكانيكي متنقل",
    "مصلح الكنبات",
    "سباك",
    "بناء",
    "نقل بضائع"
  ];
  String? _selectvalue2 = LocaleKeys.Specialty.tr();
  BookDoctorScreen2() {
    _selectvalue2 = _kind2[0];
  }

  bool? isChecked = false;
  var formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController SpecialtyController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController PhoneNumberController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController nationalIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String url = 'http://eibtek2-001-site20.atempurl.com/api/ServiceApi/GetAll';
  var _country = [];
  String? country;
  final userData = GetStorage();
  Future<ServicsModel?> getData() async {
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body.toString());

      setState(() {
        _country = jsonResponse;
      });
    }
  }

  void re(
    String FullName,
    email,
    Country,
    PhoneNumber,
    Specialty,
    password,
    bool agree,
  ) async {
    try {
      var response = await http.post(
          Uri.parse('http://eibtek2-001-site20.atempurl.com/api/Auth/Register'),
          headers: {
            "Content-Type": "application/json",
          },
          body: jsonEncode({
            "name": FullName,
            "role": "Worker",
            "phoneNumber": PhoneNumber,
            "title": Country,
            "email": email,
            "password": password,
            "isAgree": agree,
            "Specialty": Specialty,
          }));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        Fluttertoast.showToast(
            msg: '${data['message']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
        var log = json.decode(response.body);
        Map<String, dynamic> payload = Jwt.parseJwt(log['token']);
        var tokenId = payload['Id'];
        var Email = payload['Email'];
        var PhoneNumbe = payload['PhoneNumbe'];
        userData.write('IsSubscriped', payload['IsSubscriped']);
        userData.write('role', false);
        userData.write('isLogged', true);
        userData.write('Email', payload['Email']);
        userData.write('PhoneNumber', payload['PhoneNumber']);
        userData.write('Name', payload['Name']);
        userData.write('token', payload['Id']);
        userData.write('Title', payload['Title']);
        userData.write('Specialty', payload['Specialty']);
        userData.write('email', email);
        userData.write('password', password);
        Get.offAll(const BottomNavWokerScreen());
      } else {
        Fluttertoast.showToast(
            msg: '${data['errors']}',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    } catch (e) {}
  }

  @override
  void dispose() {
    PhoneNumberController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    nationalIdController.dispose();
    SpecialtyController.dispose();
    typeController.dispose();
    countryController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: 20.h, right: 20.h, top: 35.h, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                      onTap: () {
                        Get.offAll(const SignIn());
                      },
                      child: const Icon(Icons.arrow_back)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.New_Worker.tr(),
                    style: TextStyle(
                      fontFamily: 'Tajawal7',
                      fontSize: 17.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Gap(5.h),
                  Text(
                    LocaleKeys.Register_as_a_new_worker.tr(),
                    style: TextStyle(
                        fontFamily: 'Tajawal7',
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                  Gap(20.h),
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.Please_enter_your_name.tr();
                            }
                            return null;
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.name,
                          controller: userNameController,
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
                            labelText: LocaleKeys.User_Name.tr(),
                            hintText: LocaleKeys.User_Name.tr(),
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
                          controller: emailController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.Please_enter_your_email.tr();
                            }
                            return null;
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
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
                            labelText: LocaleKeys.Email.tr(),
                            hintText: LocaleKeys.Email.tr(),
                            labelStyle: TextStyle(
                                fontFamily: 'Tajawal7',
                                fontSize: 13.sp,
                                color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Tajawal7',
                                color: Colors.grey.shade400),
                          ),
                        ),
                        Gap(10.h),
                        TextFormField(
                          controller: countryController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.Please_enter_your_country.tr();
                            }
                            return null;
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.emailAddress,
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
                            labelText: LocaleKeys.Country.tr(),
                            hintText: LocaleKeys.Country.tr(),
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
                          controller: PhoneNumberController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.Please_enter_your_phone.tr();
                            }
                            return null;
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
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
                                fontFamily: 'Tajawal7',
                                fontSize: 13.sp,
                                color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Tajawal7',
                                color: Colors.grey.shade400),
                          ),
                        ),
                        Gap(10.h),
                        InkWell(
                          onTap: () {
                            getData();
                          },
                          child: DropdownButtonFormField(
                            hint: Text(
                              LocaleKeys.Specialty.tr(),
                              style: TextStyle(
                                  fontFamily: 'Tajawal7',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade400),
                            ),
                            value: country,
                            items: _country.map((e) {
                              return DropdownMenuItem<String>(
                                  onTap: () {},
                                  value: e['name'],
                                  child: Text(
                                    e['name'],
                                    style: TextStyle(
                                        fontFamily: 'Tajawal7',
                                        fontSize: 13.sp,
                                        color: Colors.grey.shade400),
                                  ));
                            }).toList(),
                            onChanged: (val) {
                              setState(() {
                                country = val!;
                                userData.write('Specialty', country);
                              });
                            },
                            icon: const Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: Colors.transparent,
                              ),
                            ),
                            decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 3.h, horizontal: 10.h),
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
                              labelText: LocaleKeys.Specialty.tr(),
                              hintText: LocaleKeys.Specialty.tr(),
                              labelStyle: TextStyle(
                                  fontFamily: 'Tajawal7',
                                  fontSize: 13.sp,
                                  color: Colors.grey.shade400),
                              hintStyle: TextStyle(
                                  fontSize: 13.sp,
                                  fontFamily: 'Tajawal7',
                                  color: Colors.grey.shade400),
                            ),
                          ),
                        ),
                        Gap(10.h),
                        TextFormField(
                          controller: passwordController,
                          validator: (String? val) {
                            if (val!.isEmpty) {
                              return LocaleKeys.Please_enter_your_password.tr();
                            }
                            return null;
                          },
                          cursorColor: Colors.grey.shade400,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 3.h, horizontal: 10.h),
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
                            labelText: LocaleKeys.Password.tr(),
                            hintText: LocaleKeys.Password.tr(),
                            labelStyle: TextStyle(
                                fontFamily: 'Tajawal7',
                                fontSize: 13.sp,
                                color: Colors.grey.shade400),
                            hintStyle: TextStyle(
                                fontSize: 13.sp,
                                fontFamily: 'Tajawal7',
                                color: Colors.grey.shade400),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Gap(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                        activeColor: Styles.defualtColor,
                        side:
                            BorderSide(color: Colors.grey.shade500, width: 1.8),
                        value: isChecked,
                        onChanged: (bool? value) {
                          setState(() {
                            isChecked = value!;
                            userData.write('select', value);
                          });
                        },
                      ),
                      Text(
                        LocaleKeys.Accept_All.tr(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: 'Tajawal7',
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        LocaleKeys.Terms_and_Conditions.tr(),
                        style: TextStyle(
                          fontSize: 11.sp,
                          fontFamily: 'Tajawal7',
                        ),
                      ),
                    ],
                  ),
                  Gap(5.h),
                  ElevatedButton(
                    onPressed: () {
                      ValidateEmail(emailController.text.toString());
                      if (formKey.currentState!.validate() &&
                          userData.read('select') == true &&
                          userData.read('isvalid') == true) {
                        re(
                          userNameController.text.toString(),
                          emailController.text.toString(),
                          countryController.text.toString(),
                          PhoneNumberController.text.toString(),
                          userData.read('Specialty').toString(),
                          passwordController.text.toString(),
                          userData.read('select'),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      fixedSize: Size(double.infinity, 45.h),
                      maximumSize: Size(double.infinity, 45.h),
                      minimumSize: Size(double.infinity, 45.h),
                      backgroundColor: Styles.defualtColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    child: Text(
                      LocaleKeys.SIGN_UP.tr(),
                      style: TextStyle(
                        color: Styles.defualtColorWhite,
                        fontFamily: 'Tajawal7',
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
