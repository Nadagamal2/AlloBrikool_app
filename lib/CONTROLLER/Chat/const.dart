import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class ColorsApp {
  static const Color blue = Color(0xff1D2042);
  static const Color grey = Color(0xffA2A2A2);
  static const Color blueWhite = Color.fromARGB(255, 174, 238, 243);
}

class HandleError {
  static const checkInternetConnection = Center(
    child: Text(
      'تأكد من اتصال الانترنت لديك',
      style: TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Colors.black,
          fontFamily: 'AlmaraiBold'),
    ),
  );
  static const circleIndicator = Center(
    child: SpinKitFadingCircle(
      color: ColorsApp.blue,
      size: 30.0,
    ),
  );
}
