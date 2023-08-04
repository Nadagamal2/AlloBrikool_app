// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:http/http.dart' as http;
// import 'package:image_picker/image_picker.dart';
// import 'package:jwt_decode/jwt_decode.dart';
// import 'package:easy_localization/easy_localization.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// import '../../CONTROLLER/translations/locale_keys.g.dart';
// import '../components/app_style.dart';

// class EditProfileScreen extends StatefulWidget {
//   const EditProfileScreen({Key? key}) : super(key: key);

//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }

// class _EditProfileScreenState extends State<EditProfileScreen> {
//   final userData = GetStorage();
//   final userNameController = new TextEditingController();
//   final PhoneNumberController = new TextEditingController();
//   final emailController = new TextEditingController();
//   final countryController = new TextEditingController();
//   final nationalIdController = new TextEditingController();
//   bool isChange = false;

//   void editNameProfile(
//     String FullName,
//   ) async {
//     var headers = {
//       'Content-Encoding': 'application/ecmascript',
//       'Accept': 'image/jpeg'
//     };
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'http://eibtek2-001-site3.atempurl.com/api/auth/EditeAccount/${userData.read('token')}'));
//     request.fields.addAll({
//       'name': FullName,
//     });

//     request.headers.addAll(headers);

//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     final result = jsonDecode(response.body) as Map<String, dynamic>;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> payload = Jwt.parseJwt(result['Token']);
//       userData.write('FullName', payload['FullName']);
//       setState(() {
//         isChange = false;
//       });
//     } else {}
//   }

//   void editEmailProfile(
//     String email,
//   ) async {
//     var headers = {
//       'Content-Encoding': 'application/ecmascript',
//       'Accept': 'image/jpeg'
//     };
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'http://eibtek2-001-site3.atempurl.com/api/auth/EditeAccount/${userData.read('token')}'));
//     request.fields.addAll({
//       'email': email,
//       'phone': '${userData.read('PhoneNumber')}',
//     });

//     request.headers.addAll(headers);
//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     final result = jsonDecode(response.body) as Map<String, dynamic>;
//     if (response.statusCode == 200) {
//       Map<String, dynamic> payload = Jwt.parseJwt(result['Token']);
//       userData.write('Email', payload['Email']);
//       setState(() {
//         isChange = false;
//       });
//     } else {}
//   }

//   void editPhoneProfile(
//     String PhoneNumber,
//   ) async {
//     var headers = {
//       'Content-Encoding': 'application/ecmascript',
//       'Accept': 'image/jpeg'
//     };
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'http://eibtek2-001-site3.atempurl.com/api/auth/EditeAccount/${userData.read('token')}'));
//     request.fields.addAll({'phone': PhoneNumber});

//     request.headers.addAll(headers);

//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     final result = jsonDecode(response.body) as Map<String, dynamic>;

//     if (response.statusCode == 200) {
//       Map<String, dynamic> payload = Jwt.parseJwt(result['Token']);
//       userData.write('PhoneNumber', payload['PhoneNumber']);
//       setState(() {
//         isChange = false;
//       });
//     } else {}
//   }

//   void editImageProfile(
//     String img,
//   ) async {
//     var headers = {
//       'Content-Encoding': 'application/ecmascript',
//       'Accept': 'image/jpeg'
//     };
//     var request = http.MultipartRequest(
//         'POST',
//         Uri.parse(
//             'http://eibtek2-001-site3.atempurl.com/api/auth/EditeAccount/${userData.read('token')}'));

//     request.fields.addAll({
//       'phone': '${userData.read('PhoneNumber')}',
//     });

//     request.files.add(await http.MultipartFile.fromPath('photo', img));
//     request.headers.addAll(headers);

//     var streamedResponse = await request.send();
//     var response = await http.Response.fromStream(streamedResponse);
//     final result = jsonDecode(response.body) as Map<String, dynamic>;

//     if (response.statusCode == 200) {
//       Map<String, dynamic> payload = Jwt.parseJwt(result['Token']);
//       userData.write('Img', payload['Img']);
//       setState(() {
//         isChange = false;
//       });
//     } else {
//       print(response.reasonPhrase);
//     }
//   }

//   var formKey1 = GlobalKey<FormState>();
//   var formKey2 = GlobalKey<FormState>();
//   var formKey3 = GlobalKey<FormState>();
//   var formKey4 = GlobalKey<FormState>();

//   @override
//   void dispose() {
//     PhoneNumberController.dispose();
//     userNameController.dispose();
//     emailController.dispose();
//     countryController.dispose();
//     nationalIdController.dispose();

//     super.dispose();
//   }

//   static File? file;
//   String? imag;
//   ImagePicker image = ImagePicker();
//   getGallery() async {
//     var img = await image.pickImage(source: ImageSource.gallery);
//     setState(() {
//       file = File(img!.path);
//       imag = img.path;
//       userData.write('path', file);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Gap(70.h),
//               Text(
//                 LocaleKeys.Modify_your_Account.tr(),
//                 style: TextStyle(
//                   fontSize: 18.sp,
//                   fontFamily: 'Tajawal7',
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Gap(30.h),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.h),
//                 child: Column(
//                   children: [
//                     TextFormField(
//                       cursorColor: Colors.grey.shade400,
//                       keyboardType: TextInputType.text,
//                       validator: (String? val) {
//                         if (val!.isEmpty) {
//                           ' return LocaleKeys.Please_Enter_Your_Updated_Name.tr()';
//                         }
//                         return null;
//                       },
//                       controller: userNameController,
//                       decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 3.h, horizontal: 10.h),
//                           filled: true,
//                           fillColor: const Color(0xffF6F5F5),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: const OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           labelText: LocaleKeys.new_user_name.tr(),
//                           hintText: LocaleKeys.new_user_name.tr(),
//                           labelStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400),
//                           hintStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400)),
//                     ),
//                     Gap(15.h),
//                     TextFormField(
//                       cursorColor: Colors.grey.shade400,
//                       keyboardType: TextInputType.number,
//                       validator: (String? val) {
//                         if (val!.isEmpty) {
//                           ' return LocaleKeys.Please_Enter_Your_Updated_Number.tr()';
//                         }
//                         return null;
//                       },
//                       controller: PhoneNumberController,
//                       decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 3.h, horizontal: 10.h),
//                           filled: true,
//                           fillColor: const Color(0xffF6F5F5),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: const OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           labelText: LocaleKeys.new_phone_number.tr(),
//                           hintText: LocaleKeys.new_phone_number.tr(),
//                           labelStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400),
//                           hintStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400)),
//                     ),
//                     Gap(15.h),
//                     TextFormField(
//                       cursorColor: Colors.grey.shade400,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? val) {
//                         if (val!.isEmpty) {
//                           ' return LocaleKeys.Please_Enter_Your_Updated_Email.tr()';
//                         }
//                         return null;
//                       },
//                       controller: emailController,
//                       decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 3.h, horizontal: 10.h),
//                           filled: true,
//                           fillColor: const Color(0xffF6F5F5),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: const OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           labelText: LocaleKeys.new_email.tr(),
//                           hintText: LocaleKeys.new_email.tr(),
//                           labelStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400),
//                           hintStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400)),
//                     ),
//                     Gap(15.h),
//                     TextFormField(
//                       cursorColor: Colors.grey.shade400,
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (String? val) {
//                         if (val!.isEmpty) {
//                           ' return LocaleKeys.Please_Enter_Your_Updated_Email.tr()';
//                         }
//                         return null;
//                       },
//                       controller: countryController,
//                       decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 3.h, horizontal: 10.h),
//                           filled: true,
//                           fillColor: const Color(0xffF6F5F5),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: const OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           labelText: LocaleKeys.new_country.tr(),
//                           hintText: LocaleKeys.new_country.tr(),
//                           labelStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400),
//                           hintStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400)),
//                     ),
//                     Gap(15.h),
//                     TextFormField(
//                       cursorColor: Colors.grey.shade400,
//                       keyboardType: TextInputType.number,
//                       validator: (String? val) {
//                         if (val!.isEmpty) {
//                           ' return LocaleKeys.Please_Enter_Your_Updated_Email.tr()';
//                         }
//                         return null;
//                       },
//                       controller: nationalIdController,
//                       decoration: InputDecoration(
//                           floatingLabelBehavior: FloatingLabelBehavior.never,
//                           contentPadding: EdgeInsets.symmetric(
//                               vertical: 3.h, horizontal: 10.h),
//                           filled: true,
//                           fillColor: const Color(0xffF6F5F5),
//                           focusedBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           border: const OutlineInputBorder(),
//                           enabledBorder: OutlineInputBorder(
//                             borderSide: BorderSide(
//                                 width: .1.r, color: Colors.transparent),
//                             borderRadius: BorderRadius.circular(10.r),
//                           ),
//                           labelText: LocaleKeys.new_national_id.tr(),
//                           hintText: LocaleKeys.new_national_id.tr(),
//                           labelStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400),
//                           hintStyle: TextStyle(
//                               fontSize: 15.sp, color: Colors.grey.shade400)),
//                     ),
//                     Gap(50.h),
//                     SizedBox(
//                       width: 240.h,
//                       height: 34.h,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Styles.defualtColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                           ),
//                         ),
//                         child: Text(
//                           LocaleKeys.Change_Name.tr(),
//                           style: TextStyle(
//                             color: Styles.defualtColorWhite,
//                             fontFamily: 'Tajawal7',
//                             fontSize: 15.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Gap(10.h),
//                     SizedBox(
//                       width: 240.h,
//                       height: 34.h,
//                       child: ElevatedButton(
//                         onPressed: () {},
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Styles.defualtColor,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(5.r),
//                           ),
//                         ),
//                         child: Text(
//                           LocaleKeys.Change_Name.tr(),
//                           style: TextStyle(
//                             color: Styles.defualtColorWhite,
//                             fontFamily: 'Tajawal7',
//                             fontSize: 15.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     Gap(10.h),
//                     buildBottum(
//                       height: 52,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       width: double.infinity,
//                       text: Text(
//                         ' LocaleKeys.Change_phone.tr()',
//                         style: TextStyle(
//                             fontFamily: 'Tajawal7',
//                             color: Styles.defualtColor2,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.center,
//                       ),
//                       onTap: () {
//                         if (formKey2.currentState!.validate()) {
//                           editPhoneProfile(
//                             PhoneNumberController.text.toString(),
//                           );
//                         }
//                       },
//                     ),
//                     Gap(10.h),
//                     buildBottum(
//                       height: 52,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(25),
//                       ),
//                       width: double.infinity,
//                       text: Text(
//                         '  LocaleKeys.Change_Email.tr()',
//                         style: TextStyle(
//                             fontFamily: 'Tajawal7',
//                             color: Styles.defualtColor2,
//                             fontSize: 16.sp,
//                             fontWeight: FontWeight.w600),
//                         textAlign: TextAlign.center,
//                       ),
//                       onTap: () {
//                         if (formKey3.currentState!.validate()) {
//                           editEmailProfile(
//                             emailController.text.toString(),
//                           );
//                         }
//                       },
//                     ),
//                     Gap(10.h),
//                   ],
//                 ),
//               ),
//               Gap(20.h),
//               TextButton(
//                   onPressed: () {
//                     Get.back();
//                   },
//                   child: Text(LocaleKeys.Back.tr(),
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 16.sp,
//                           fontFamily: 'Tajawal7'))),
//               Gap(20.h),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget buildBottum({
//     required double height,
//     required double width,
//     required Text text,
//     required Function() onTap,
//     EdgeInsetsGeometry? margin,
//     required BoxDecoration? decoration,
//   }) =>
//       Container(
//         height: height,
//         margin: margin,
//         width: width,
//         decoration: decoration,
//         child: InkWell(
//           onTap: onTap,
//           child: Center(
//             child: text,
//           ),
//         ),
//       );
// }
