// import 'package:allo_prikool/screens/payment_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';
// import '../components/app_style.dart';
//
// class AllOfferScreen extends StatelessWidget {
//   const AllOfferScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return   Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'All Offers',style: TextStyle(
//             color: Styles.defualtColorBlack,
//             fontWeight: FontWeight.w600
//         ),
//         ),
//         centerTitle: true,
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//       ),
//       body: Padding(
//         padding:   EdgeInsets.symmetric(horizontal: 20.h),
//         child: Column(
//           children: [
//             Container(
//               height: 180.h,
//               width: double.infinity,
//               padding: EdgeInsets.all(10.h),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black,width: 1),
//                 borderRadius: BorderRadius.circular(15.h),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage('assets/Rectangle 6887.png'),
//                             radius: 30.r,
//                           ),
//                           Gap(10.h),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('mohamed ahmed'),
//                               Text('1.9 km'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.star,color: Colors.grey.shade300,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                   Gap(10.h),
//                   Container(
//                     height: 40.h,
//                     padding: EdgeInsets.symmetric(horizontal: 20.h),
//
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black,width: 1),
//                       borderRadius: BorderRadius.circular(10.h),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('price',style: TextStyle(
//                           color: Colors.grey.shade400
//                         ),),
//                         Text('50 LE',style: TextStyle(
//                           fontWeight: FontWeight.w600,
//
//                         ),)
//                       ],
//                     ),
//
//                   ),
//                   Gap(10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                     children: [
//                       SizedBox(
//                         width: 120.h,
//                         height: 34.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(PaymentScreen());
//
//                           },
//                           child: Text(
//                             "Accept Offer",
//                             style: TextStyle(
//                               color: Styles.defualtColorWhite,
//                               fontFamily: 'Tajawal7',
//                               fontSize: 15.sp,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.r),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 120.h,
//                         height: 34.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//
//                           },
//                           child: Text(
//                             "Refuse Offer",
//                             style: TextStyle(
//                               color: Styles.defualtColorWhite,
//                               fontFamily: 'Tajawal7',
//                               fontSize: 15.sp,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.r),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//             Gap(15.h),
//             Container(
//               height: 180.h,
//               width: double.infinity,
//               padding: EdgeInsets.all(10.h),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.black,width: 1),
//                 borderRadius: BorderRadius.circular(15.h),
//               ),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           CircleAvatar(
//                             backgroundImage: AssetImage('assets/Rectangle 6887.png'),
//                             radius: 30.r,
//                           ),
//                           Gap(10.h),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text('mohamed ahmed'),
//                               Text('1.9 km'),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: [
//                           Icon(Icons.star,color: Colors.grey.shade300,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//                           Icon(Icons.star,color: Styles.defualtColor,size: 15.sp,),
//
//                         ],
//                       ),
//                     ],
//                   ),
//                   Gap(10.h),
//                   Container(
//                     height: 40.h,
//                     padding: EdgeInsets.symmetric(horizontal: 20.h),
//
//                     width: double.infinity,
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black,width: 1),
//                       borderRadius: BorderRadius.circular(10.h),
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text('price',style: TextStyle(
//                             color: Colors.grey.shade400
//                         ),),
//                         Text('50 LE',style: TextStyle(
//                           fontWeight: FontWeight.w600,
//
//                         ),)
//                       ],
//                     ),
//
//                   ),
//                   Gap(10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//
//                     children: [
//                       SizedBox(
//                         width: 120.h,
//                         height: 34.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             Get.to(PaymentScreen());
//
//                           },
//                           child: Text(
//                             "Accept Offer",
//                             style: TextStyle(
//                               color: Styles.defualtColorWhite,
//                               fontFamily: 'Tajawal7',
//                               fontSize: 15.sp,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.green,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.r),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         width: 120.h,
//                         height: 34.h,
//                         child: ElevatedButton(
//                           onPressed: () {
//
//                           },
//                           child: Text(
//                             "Refuse Offer",
//                             style: TextStyle(
//                               color: Styles.defualtColorWhite,
//                               fontFamily: 'Tajawal7',
//                               fontSize: 15.sp,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.red,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(5.r),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//
//     );
//   }
// }
