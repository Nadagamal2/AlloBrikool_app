import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart' hide Trans;
import 'package:easy_localization/easy_localization.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import '../../../VIEW/components/app_style.dart';
import '../../translations/locale_keys.g.dart';
import '../const.dart';

class GetLocation extends GetxController {
  String? currentAddress;
  Position? currentPosition;
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      Get.snackbar(
        "",
        "",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorsApp.blue,
        borderRadius: 20,
        margin: EdgeInsets.all(15),
        colorText: Colors.white,
        titleText: Text(
          LocaleKeys.An_error_occurred.tr(),
          style: TextStyle(
              fontFamily: 'Almarai', color: Colors.white, fontSize: 15),
        ),
        messageText: Text(
          LocaleKeys.Please_activate_the_site.tr(),
          style: TextStyle(
              fontFamily: 'Almarai', color: Colors.white, fontSize: 12),
        ),
        duration: Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );

      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Get.snackbar(
          "",
          "",
          icon: const Icon(Icons.person, color: Colors.white),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Styles.defualtColor,
          borderRadius: 20,
          margin: EdgeInsets.all(15),
          colorText: Colors.white,
          titleText: Text(
            LocaleKeys.An_error_occurred.tr(),
            style: TextStyle(
                fontFamily: 'Almarai', color: Colors.white, fontSize: 15),
          ),
          messageText: Text(
            LocaleKeys.The_site_is_not_activated.tr(),
            style: TextStyle(
                fontFamily: 'Almarai', color: Colors.white, fontSize: 12),
          ),
          duration: Duration(seconds: 4),
          isDismissible: true,
          forwardAnimationCurve: Curves.easeOutBack,
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Get.snackbar(
        "",
        "",
        icon: const Icon(Icons.person, color: Colors.white),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: ColorsApp.blue,
        borderRadius: 20,
        margin: const EdgeInsets.all(15),
        colorText: Colors.white,
        titleText: Text(
          LocaleKeys.An_error_occurred.tr(),
          style: TextStyle(
              fontFamily: 'Almarai', color: Colors.white, fontSize: 15),
        ),
        messageText: Text(
          LocaleKeys.Make_sure_the_location_is_enabled_to_send_the_live_location
              .tr(),
          style: TextStyle(
              fontFamily: 'Almarai', color: Colors.white, fontSize: 12),
        ),
        duration: const Duration(seconds: 4),
        isDismissible: true,
        forwardAnimationCurve: Curves.easeOutBack,
      );
      return false;
    }
    return true;
  }

  Future<void> getCurrentPositions(String id, String collectionName) async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;
      update();
      _getAddressFromLatLng(currentPosition!, id, collectionName);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(
      Position position, String id, String collectionName) async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      update();
      FirebaseFirestore.instance.collection(collectionName).add({
        'lat': currentPosition!.latitude,
        'long': currentPosition!.longitude,
        'senderID': id,
        'fcmToken': fcmToken,
        'senderName': 'senderName',
        'time': DateTime.now(),
        'type': 'map',
        'messageText': '',
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
