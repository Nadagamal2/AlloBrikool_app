// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
//
//
// class SendFile extends GetxController{
//   PlatformFile? pickedFile;
//   UploadTask? uploadTask;
//   Future sendFile() async {
//     final result = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf'],type: FileType.custom);
//     if(result == null) return;
//     pickedFile = result.files.first;
//     update();
//   }
//
//   Future uploadFile({required String collectionName,required String userID}) async {
//     final fcmToken = await FirebaseMessaging.instance.getToken();
//     final path = 'files/${pickedFile!.name}';
//     final file = File(pickedFile!.path!);
//     final ref = FirebaseStorage.instance.ref().child(path);
//     uploadTask = ref.putFile(file);
//     final snapshot = await uploadTask!.whenComplete(() {});
//     final urlDownload = await snapshot.ref.getDownloadURL();
//     FirebaseFirestore.instance.collection(collectionName).add({
//       'senderID': userID,
//       'fcmToken' : fcmToken,
//       'senderName': 'senderName',
//       'time': DateTime.now(),
//       'type': 'file',
//       'messageText': urlDownload,
//       'lat': 0.0,
//       'long': 0.0,
//     });
//   }
// }