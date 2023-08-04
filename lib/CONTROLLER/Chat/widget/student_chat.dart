import 'dart:async';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../../VIEW/components/app_style.dart';
import '../../translations/locale_keys.g.dart';
import '../const.dart';
import '../expanded_image.dart';
import '../../../VIEW/OtherScreen/LocationPage.dart';

class StudentChat extends StatelessWidget {
  StudentChat(
      {Key? key,
      required this.text,
      required this.underText,
      required this.isMe,
      required this.map,
      required this.map2,
      required this.lat,
      required this.long})
      : super(key: key);
  String text;
  String underText;
  bool isMe = true;
  String map;
  String map2;
  double lat;
  double long;
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      crossAxisAlignment:
          isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment:
              isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
          children: [
            if (map == 'text')
              IntrinsicWidth(
                child: Container(
                  padding: EdgeInsets.all(20.h),
                  constraints: BoxConstraints(maxWidth: 250.w, minWidth: 80.w),
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: isMe ? Styles.defualtColor : Colors.grey.shade400,
                      borderRadius: isMe
                          ? BorderRadius.only(
                              topLeft: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r))
                          : BorderRadius.only(
                              topRight: Radius.circular(8.r),
                              bottomRight: Radius.circular(8.r),
                              bottomLeft: Radius.circular(8.r))),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: isMe
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: 'Tajawal7'),
                      ),
                    ],
                  ),
                ),
              ),
            if (map == 'image')
              GestureDetector(
                onTap: () {
                  Get.to(() => ExpandedImage(
                        image: map2,
                      ));
                },
                child: Container(
                  height: 170.h,
                  width: 170.w,
                  padding: const EdgeInsets.all(3),
                  alignment:
                      isMe ? Alignment.centerRight : Alignment.centerLeft,
                  decoration: BoxDecoration(
                      color: isMe ? Styles.defualtColor : Colors.grey.shade400,
                      borderRadius: isMe
                          ? const BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))
                          : const BorderRadius.only(
                              topRight: Radius.circular(8),
                              bottomRight: Radius.circular(8),
                              bottomLeft: Radius.circular(8))),
                  child: Container(
                    height: 170.h,
                    width: 170.w,
                    alignment: map2 != "" ? null : Alignment.center,
                    child: map2 != ""
                        ? Image.network(
                            map2,
                            fit: BoxFit.cover,
                          )
                        : const CircularProgressIndicator(),
                  ),
                ),
              ),
            if (map == 'file')
              text.split('?').first.split('.').last == 'pdf'
                  ? GestureDetector(
                      onTap: () async {
                        Dio dio = Dio();
                        final pdfUrl = text;
                        final directory = await getExternalStorageDirectory();
                        String pdfPath = directory!.path + '/contract.pdf';
                        try {
                          await dio.download(pdfUrl, pdfPath,
                              onReceiveProgress: (received, total) {
                            print("$received $total");
                          });
                          print("Download completed");
                        } catch (e) {
                          print(e);
                        }
                        // Get.to(()=> PdfViewerPage(
                        //   pdfPath: pdfPath,
                        // ));
                      },
                      child: Container(
                        height: 78.h,
                        width: 295.w,
                        margin: EdgeInsets.only(
                            top: 10.h, bottom: 10.h, right: 10.w),
                        padding: EdgeInsets.only(right: 10.w),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: 66.h,
                              width: 66.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: ColorsApp.blue,
                              ),
                              child: Image.asset(
                                'assets/images/pdf.png',
                                fit: BoxFit.scaleDown,
                                color: Colors.white,
                                height: 30,
                              ),
                            ),
                            SizedBox(
                              width: 16.w,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isMe
                                    ? const Text(
                                        'مرفق',
                                        style: TextStyle(
                                            color: ColorsApp.grey,
                                            fontSize: 13,
                                            fontFamily: 'Almarai'),
                                      )
                                    : const Text(
                                        'نص العقد الخاص بالمشروع',
                                        style: TextStyle(
                                            color: ColorsApp.grey,
                                            fontSize: 13,
                                            fontFamily: 'Tajawal7'),
                                      ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                const Text(
                                  'انقر لفتح الملف',
                                  style: TextStyle(
                                      color: ColorsApp.grey,
                                      fontSize: 12,
                                      fontFamily: 'Tajawal7'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        Get.to(() => ExpandedImage(
                              image: map2,
                            ));
                      },
                      child: Container(
                        height: 170.h,
                        width: 170.w,
                        padding: const EdgeInsets.all(3),
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        decoration: BoxDecoration(
                            color: isMe ? ColorsApp.blue : Colors.grey.shade400,
                            borderRadius: isMe
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))
                                : const BorderRadius.only(
                                    topRight: Radius.circular(8),
                                    bottomRight: Radius.circular(8),
                                    bottomLeft: Radius.circular(8))),
                        child: Container(
                          height: 170.h,
                          width: 170.w,
                          alignment: map2 != "" ? null : Alignment.center,
                          child: map2 != ""
                              ? Image.network(
                                  map2,
                                  fit: BoxFit.cover,
                                )
                              : const CircularProgressIndicator(),
                        ),
                      ),
                    ),
            if (map == 'map')
              Container(
                height: 130.h,
                width: 280.w,
                padding: const EdgeInsets.all(3),
                margin: const EdgeInsets.all(10),
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                decoration: BoxDecoration(
                    color: isMe ? ColorsApp.blue : Colors.grey.shade400,
                    borderRadius: isMe
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8))
                        : const BorderRadius.only(
                            topRight: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                            bottomLeft: Radius.circular(8))),
                child: Column(
                  children: [
                    SizedBox(
                      height: 100.h,
                      width: 280.w,
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: LatLng(lat, long),
                          zoom: 18.4746,
                        ),
                        markers: {
                          Marker(
                            markerId: MarkerId("red-flag"),
                            position: LatLng(lat, long),
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed,
                            ),
                          ),
                        },
                        mapType: MapType.satellite,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.to(LocationPage(
                          lat: lat,
                          long: long,
                        ));
                      },
                      child: Container(
                          height: 20.h,
                          alignment: Alignment.bottomCenter,
                          child: Text(
                            LocaleKeys.Open_in_map.tr(),
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                                fontFamily: 'Tajawal7'),
                          )),
                    ),
                  ],
                ),
              ),
            Container(
                padding: EdgeInsets.only(
                    left: 10.h, top: 10.h, right: 10.w, bottom: 10.h),
                child: Text(
                  '$underText ',
                  style: const TextStyle(
                      color: Colors.black45,
                      fontSize: 12,
                      fontFamily: 'Tajawal7'),
                )),
          ],
        ),
      ],
    );
  }
}
