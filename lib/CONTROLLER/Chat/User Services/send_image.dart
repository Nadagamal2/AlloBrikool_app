// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart' as path;
//
// class SendImage extends GetxController{
//
//    File? _photo;
//    final ImagePicker _picker = ImagePicker();
//    Future imgFromGallery({required String collectionName,required String userID}) async {
//      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
//
//        if (pickedFile != null) {
//          _photo = File(pickedFile.path);
//          uploadFile(collectionName: collectionName,userID: userID);
//        } else {
//          print('No image selected.');
//        }
//      update();
//    }
//    Future uploadFile({required String collectionName,required String userID}) async {
//      try {
//        send(collectionName: collectionName,userID: userID);
//      } catch (e) {
//        print('error occured');
//      }
//    }
//    Future send({required String collectionName,required String userID}) async {
//       final fcmToken = await FirebaseMessaging.instance.getToken();
//        final fileName = path.basename(_photo!.path);
//        final destination = '${collectionName}$fileName';
//        final ref = FirebaseStorage.instance.ref(destination);
//        final uploadTask = ref.putFile(_photo!);
//        final taskSnapshot = await uploadTask;
//        final _fileURL = await taskSnapshot.ref.getDownloadURL();
//        FirebaseFirestore.instance.collection(collectionName).add({
//       'senderID': userID,
//       'fcmToken' : fcmToken,
//       'senderName': 'senderName',
//       'time': DateTime.now(),
//       'type': 'image',
//       'messageText': _fileURL,
//       'lat': 0.0,
//       'long': 0.0,
//     });
//        await ref.putFile(_photo!);
//    }
// }