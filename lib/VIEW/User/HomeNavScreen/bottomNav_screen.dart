import 'dart:developer';
import 'package:allo_prikool/VIEW/User/HomeNavScreen/profile_screen.dart';
import 'package:allo_prikool/VIEW/User/HomeNavScreen/servieces_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:get_storage/get_storage.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';
import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../components/app_style.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class BottomNavScreen extends StatefulWidget {
  const BottomNavScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavScreen> createState() => _BottomNavScreenState();
}

class _BottomNavScreenState extends State<BottomNavScreen> {
  int count = 0;
  void initState() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Fluttertoast.showToast(
          msg: 'New message',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          textColor: Colors.white,
          fontSize: 16.0);
    });

    super.initState();
  }

  final userData = GetStorage();
  var currentIndex = 0;
  bool isColor = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _wigetOptions[currentIndex],
      bottomNavigationBar: MoltenBottomNavigationBar(
        barHeight: 50.h,
        domeCircleColor: Styles.defualtColor,
        selectedIndex: currentIndex,
        domeHeight: 20.h,
        domeWidth: 150,
        onTabChange: (clickedIndex) {
          setState(() {
            currentIndex = clickedIndex;
          });
        },
        tabs: [
          MoltenTab(
            icon: SvgPicture.asset(
              'assets/Path 37286.svg',
              fit: BoxFit.none,
            ),
            selectedColor: Styles.defualtColorWhite,
            title: Text(
              LocaleKeys.Home.tr(),
              style: TextStyle(
                  fontFamily: 'Tajawal7', color: Colors.grey, fontSize: 12.sp),
            ),
          ),
          MoltenTab(
            icon: SvgPicture.asset(
              'assets/Group 89094.svg',
              fit: BoxFit.none,
            ),
            selectedColor: Styles.defualtColorWhite,
            title: Text(
              LocaleKeys.My_requests.tr(),
              style: TextStyle(
                  fontFamily: 'Tajawal7', color: Colors.grey, fontSize: 11.sp),
            ),
          ),
          MoltenTab(
            icon: SvgPicture.asset(
              'assets/Group 89095.svg',
              fit: BoxFit.none,
            ),
            selectedColor: Styles.defualtColorWhite,
            title: Text(
              LocaleKeys.Building_services.tr(),
              style: TextStyle(
                  fontFamily: 'Tajawal7', color: Colors.grey, fontSize: 10.sp),
            ),
            // selectedColor: Colors.yellow,
          ),
          MoltenTab(
            icon: SvgPicture.asset(
              'assets/Group 89092.svg',
              fit: BoxFit.none,
            ),
            selectedColor: Styles.defualtColorWhite,
            title: Text(
              LocaleKeys.Profile.tr(),
              style: TextStyle(
                  fontFamily: 'Tajawal7', color: Colors.grey, fontSize: 12.sp),
            ),

            // selectedColor: Colors.yellow,
          ),
        ],
      ),
    );
  }

  List<IconData> listOfIcons = [
    FluentSystemIcons.ic_fluent_home_filled,
    FluentSystemIcons.ic_fluent_heart_filled,
    FluentSystemIcons.ic_fluent_add_circle_filled,
    FluentSystemIcons.ic_fluent_person_filled,
    FluentSystemIcons.ic_fluent_ticket_filled,
  ];
  static final List<Widget> _wigetOptions = <Widget>[
    const HomeScreen(),
    const OrderScreen(),
    const ServicesScreen(),
    const ProfileScreen(),
  ];
  static final List<PreferredSizeWidget> appBar = <PreferredSizeWidget>[];
}
