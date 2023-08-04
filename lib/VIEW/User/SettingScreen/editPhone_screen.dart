import 'package:easy_localization/easy_localization.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'dart:convert';

import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../OtherScreen/done_screen.dart';
import '../../components/app_style.dart';

class EditProfilePhoneScreen extends StatefulWidget {
  const EditProfilePhoneScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilePhoneScreen> createState() => _EditProfilePhoneScreenState();
}

class _EditProfilePhoneScreenState extends State<EditProfilePhoneScreen> {
  var formKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController AddressController = TextEditingController();
  bool isChange = false;
  final userData = GetStorage();
  void Edit(
    String PhoneNumber,
  ) async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'http://eibtek2-001-site20.atempurl.com/api/Auth/EditAccount/${userData.read('token')}'));
    request.fields.addAll({
      'id': '${userData.read('token')}',
      'Email': '${userData.read('Email')}',
      'Title': '${userData.read('Title')}',
      'Name': '${userData.read('Name')}',
      'PhoneNumber': PhoneNumber,
      'NationalId': '${userData.read('NationalId')}',
      'Specialty': '${userData.read('Specialty')}',
    });

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    final result = jsonDecode(response.body) as Map<String, dynamic>;

    if (response.statusCode == 200) {
      print(result);
      print(result['token']);
      Map<String, dynamic> payload = Jwt.parseJwt(result['token']);
      userData.write('Email', payload['Email']);
      userData.write('PhoneNumber', payload['PhoneNumber']);
      userData.write('Name', payload['Name']);
      userData.write('token', payload['Id']);
      userData.write('Title', payload['Title']);
      userData.write('NationalId', payload['NationalId']);
      userData.write('Specialty', payload['Specialty']);
      setState(() {
        isChange = false;
      });
      Get.offAll(const DoneScreen());
    } else {}
  }

  @override
  void dispose() {
    userNameController.dispose();
    PhoneController.dispose();
    EmailController.dispose();
    AddressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          backgroundColor: Styles.defualtColorWhite,
          body: SingleChildScrollView(
            child: Center(
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 15.h, vertical: 28.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            LocaleKeys.Change_phone.tr(),
                            style: TextStyle(
                              fontFamily: 'Tajawal7',
                              color: Styles.defualtColor2,
                              fontSize: 17.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.h),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Gap(20.h),
                          TextFormField(
                            style: const TextStyle(
                              fontFamily: 'Tajawal7',
                            ),
                            cursorColor: Colors.grey.shade400,
                            keyboardType: TextInputType.number,
                            validator: (String? val) {
                              if (val!.isEmpty) {
                                ' return LocaleKeys.Please_Enter_Your_Updated_Name.tr()';
                              }
                              return null;
                            },
                            controller: PhoneController,
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
                                labelText: LocaleKeys.new_phone_number.tr(),
                                hintText: LocaleKeys.new_phone_number.tr(),
                                labelStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400),
                                hintStyle: TextStyle(
                                    fontSize: 15.sp,
                                    color: Colors.grey.shade400)),
                          ),
                          Gap(50.h),
                          SizedBox(
                            width: double.infinity,
                            height: 34.h,
                            child: ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isChange = true;
                                });
                                Edit(
                                  PhoneController.text.toString(),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Styles.defualtColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.r),
                                ),
                              ),
                              child: Text(
                                LocaleKeys.Change_phone.tr(),
                                style: TextStyle(
                                  color: Styles.defualtColorWhite,
                                  fontFamily: 'Tajawal7',
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                          Gap(20.h),
                          Center(
                            child: TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text(
                                  LocaleKeys.Back.tr(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'Tajawal7',
                                    color: Colors.grey.shade400,
                                    fontSize: 18.h,
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        if (isChange == true)
          AbsorbPointer(
            child: Center(
                child: CircularProgressIndicator(
              color: Styles.defualtColor,
            )),
          ),
      ],
    );
  }
}
