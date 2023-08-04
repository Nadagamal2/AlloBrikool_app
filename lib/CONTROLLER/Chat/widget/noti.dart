import 'dart:convert';

import 'package:http/http.dart' as http;

class APIs {
  static Future<void> sendPushNotification({
    required var fcmToken,
    required String msg,
    required String title,
    required String channelID,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization':
              'key=AAAALoOYBfo:APA91bHrAeQdxDFgqMSpafXBQpGlgdtHyaLpj6yzcSVRCNjP8t1T-JtGK6Vlcl_n2llki-6GPlUd3NWisAgslX05-NKRBfhy3ZrEoX1lbJctJyHqlP5fg2_QmTFPW0PHB4AO6G_WIt2a',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': msg,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              "channelId": channelID,
            },
            'to': fcmToken,
          },
        ),
      );
      response;
    } catch (e) {
      e;
    }
  }
}
