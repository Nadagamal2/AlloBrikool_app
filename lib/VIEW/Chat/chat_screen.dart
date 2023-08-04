import 'dart:developer';
import 'package:allo_prikool/CONTROLLER/Chat/widget/noti.dart';
import 'package:allo_prikool/CONTROLLER/Chat/widget/sendMessageBar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart' hide Trans;
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../../../../../../main.dart';
import '../../CONTROLLER/Chat/User Services/get_location.dart';
import '../../CONTROLLER/Chat/User Services/send_message.dart';
import '../../CONTROLLER/Chat/const.dart';
import '../../CONTROLLER/Chat/widget/student_chat.dart';
import '../../CONTROLLER/translations/locale_keys.g.dart';
import '../../VIEW/components/app_style.dart';

class Chat2Screen extends StatefulWidget {
  Chat2Screen({
    Key? key,
    required this.serviceID,
    required this.fcmToken,
  }) : super(key: key);
  String serviceID;
  String fcmToken;

  @override
  State<Chat2Screen> createState() => _Chat2ScreenState();
}

class _Chat2ScreenState extends State<Chat2Screen> {
  GetLocation location = Get.put(GetLocation());
  SendMessages sendMessage = Get.put(SendMessages());
  final userData = GetStorage();
  final _firestore = FirebaseFirestore.instance;
  TextEditingController controller = TextEditingController();
  String? fcmToken;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    height: 80.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Styles.defualtColor,
                    ),
                  ),
                  Positioned(
                      height: 130.h,
                      right: 110.h,
                      top: -5,
                      child: SvgPicture.asset('assets/Group 88666.svg')),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: 20.h,
                  left: 20.h,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Styles.defualtColorWhite,
                            )),
                        Text(
                          '',
                          style: TextStyle(
                              color: Styles.defualtColorWhite,
                              fontWeight: FontWeight.w600,
                              fontSize: 20.sp),
                        ),
                        const Icon(
                          FluentSystemIcons.ic_fluent_edit_regular,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firestore
                  .collection(widget.serviceID)
                  .orderBy('time')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<StudentChat> messageWidgets = [];
                  final messages = snapshot.data!.docs.reversed;
                  for (var message in messages) {
                    final messageSender = message.get('senderID');
                    final messageText = message.get('messageText');
                    final messageType = message.get('type');
                    fcmToken = message.get('fcmToken');
                    final lat = message.get('lat');
                    final long = message.get('long');
                    final messageTime = message.get('time').toDate();
                    final messageWidget = StudentChat(
                      text: messageText,
                      map: messageType,
                      map2: messageText,
                      lat: lat,
                      long: long,
                      underText: DateFormat.yMd().add_jm().format(messageTime),
                      isMe: userData.read('token') == messageSender,
                    );
                    messageWidgets.add(messageWidget);
                  }
                  return ListView(
                      reverse: true,
                      padding: EdgeInsets.all(20.h),
                      children: messageWidgets);
                } else if (snapshot.hasError) {
                  HandleError.checkInternetConnection;
                }
                return HandleError.circleIndicator;
              },
            ),
          ),
          customSenderBar(
            messageController: controller,
            sendMessage: () {
              if (controller.text.isNotEmpty) {
                sendMessage
                    .sendMessage(
                  collectionName: widget.serviceID,
                  userID: userData.read('token')!,
                  senderName: 'Sender Name',
                  messageText: controller.text.trim(),
                )
                    .then((val) {
                  APIs.sendPushNotification(
                    channelID: '1',
                    fcmToken: widget.fcmToken,
                    title: 'رسالة جديدة',
                    msg: controller.text.trim(),
                  );
                  controller.clear();
                });
              } else {}
            },
            sendLocation: () {
              Get.defaultDialog(
                title: LocaleKeys.Alert.tr(),
                titleStyle: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontFamily: 'Tajawal7',
                    fontWeight: FontWeight.bold),
                backgroundColor: Styles.defualtColor,
                content: Column(
                  children: [
                    Text(
                      LocaleKeys.Your_current_location_will_be_sent.tr(),
                      style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontFamily: 'Tajawal7',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            location
                                .getCurrentPositions(
                                    userData.read('token'), widget.serviceID)
                                .then((val) {
                              APIs.sendPushNotification(
                                channelID: '1',
                                fcmToken: widget.fcmToken,
                                title: 'رسالة جديدة',
                                msg: 'الموقع الحالي',
                              );
                            });
                            Get.back();
                          },
                          child: Container(
                            height: 40.h,
                            width: 80.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Accept.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal7',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            height: 40.h,
                            width: 80.w,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Colors.white,
                              ),
                            ),
                            child: Text(
                              LocaleKeys.Reject.tr(),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontFamily: 'Tajawal7',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
