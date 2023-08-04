import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../CONTROLLER/Chat/const.dart';

class LocationPage extends StatefulWidget {
  LocationPage({Key? key, required this.lat, required this.long})
      : super(key: key);
  double lat;
  double long;
  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 101.h,
                width: double.infinity,
                color: ColorsApp.blue,
              ),
              Positioned(
                left: -10,
                child: SvgPicture.asset('assets/chatBuble.svg'),
              ),
              Positioned(
                top: 25,
                left: 25,
                child: SvgPicture.asset('assets/chatLine.svg'),
              ),
              Positioned(
                bottom: 1,
                right: 25,
                child: SvgPicture.asset('assets/chatLine2.svg'),
              ),
              Positioned(
                top: 45.h,
                right: 20,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              ),
              Positioned(
                top: 60.h,
                left: 170.w,
                child: Text(
                  LocaleKeys.The_site.tr(),
                  style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Tajawal7'),
                ),
              ),
            ],
          ),
          Expanded(
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                  target: LatLng(widget.lat, widget.long),
                  zoom: 18.4746,
                  tilt: 0,
                  bearing: 0),
              mapType: MapType.satellite,
              myLocationEnabled: true,
              trafficEnabled: true,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
          ),
        ],
      ),
    );
  }
}
