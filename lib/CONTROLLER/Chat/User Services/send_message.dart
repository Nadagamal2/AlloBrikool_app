import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class SendMessages extends GetxController{

  final _firestore = FirebaseFirestore.instance;
  sendMessage({required String senderName,required String messageText,required String collectionName,required String userID}) async {
      final fcmToken = await FirebaseMessaging.instance.getToken();
     _firestore.collection(collectionName).add({
      'senderID' : userID,
      'senderName' : senderName,
      'time' : DateTime.now(),
      'type' : 'text',
      'messageText' : messageText,
      'lat': 0.0,
      'long': 0.0,
      'fcmToken' : fcmToken,
     });
  }
}