import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/order_member_screen.dart';
import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/profile_worker.dart';
import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/request_worker.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:molten_navigationbar_flutter/molten_navigationbar_flutter.dart';

import '../../../CONTROLLER/translations/locale_keys.g.dart';
import '../../components/app_style.dart';

class BottomNavWokerScreen extends StatefulWidget {
  const BottomNavWokerScreen({Key? key}) : super(key: key);
  @override
  State<BottomNavWokerScreen> createState() => _BottomNavWokerScreenState();
}

class _BottomNavWokerScreenState extends State<BottomNavWokerScreen> {
  final userData = GetStorage();
  var currentIndex = 0;
  bool isColor = true;
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
                color: Colors.grey,
                fontSize: 12.sp,
                fontFamily: 'Tajawal7',
              ),
            ),
          ),
          MoltenTab(
            icon: SvgPicture.asset(
              'assets/Group 89094.svg',
              fit: BoxFit.none,
            ),
            selectedColor: Styles.defualtColorWhite,
            title: Text(
              LocaleKeys.My_Orders.tr(),
              style: TextStyle(
                color: Colors.grey,
                fontSize: 11.sp,
                fontFamily: 'Tajawal7',
              ),
            ),
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
                color: Colors.grey,
                fontSize: 12.sp,
                fontFamily: 'Tajawal7',
              ),
            ),
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
    const OrderMemberScreen(),
    const RequestWorkerScreen(),
    const ProfileWorkerScreen(),
  ];
  static final List<PreferredSizeWidget> appBar = <PreferredSizeWidget>[];
}
