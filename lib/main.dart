import 'package:allo_prikool/VIEW/Worker/HomeNavWorker/bottomNavWorker.dart';
import 'package:allo_prikool/VIEW/User/HomeNavScreen/bottomNav_screen.dart';
import 'package:allo_prikool/VIEW/OnBoarding/onboarding_screen.dart';
import 'package:allo_prikool/CONTROLLER/translations/codegen_loader.g.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';

import 'VIEW/components/app_style.dart';

Future<void> onBackgroundNoti(RemoteMessage message) async {
  String? title = message.notification!.title;
  String? body = message.notification!.body;
  if (message.data['channelId'] == '1') {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: 1,
        channelKey: '1',
        color: Colors.redAccent,
        title: '',
        summary: message.notification!.title,
        body: message.notification!.body,
        category: NotificationCategory.Message,
        wakeUpScreen: true,
        fullScreenIntent: true,
        autoDismissible: false,
        backgroundColor: Styles.defualtColor,
      ),
    );
  } else {}
}

void main() async {
  await GetStorage.init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(onBackgroundNoti);
  await Firebase.initializeApp();
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelKey: '1',
        channelName: 'chats',
        channelDescription: 'chat app noti',
        defaultColor: Colors.red,
        ledColor: Colors.blue,
        importance: NotificationImportance.Max,
        locked: false,
        channelShowBadge: true,
        defaultRingtoneType: DefaultRingtoneType.Notification),
  ]);
  runApp(EasyLocalization(
      child: const MyApp(),
      supportedLocales: [
        Locale('ar'),
        Locale('en'),
        Locale('fr'),
      ],
      assetLoader: CodegenLoader(),
      saveLocale: true,
      path: "assets/translations"));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => GetMaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'AlloBrikool',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.light,
            ),
          ),
        ),
        home: child,
      ),
      child: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final userData = GetStorage();

  @override
  void initState() {
    super.initState();
    userData.writeIfNull('isLogged', false);

    Future.delayed(Duration.zero, () async {
      checkIfLoged();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Styles.defualtColor),
        ),
      ),
    ));
  }

  void checkIfLoged() {
    userData.read('isLogged')
        ? userData.read('role')
            ? Get.offAll(BottomNavScreen())
            : Get.offAll(BottomNavWokerScreen())
        : Get.offAll(OnBoardingScreen());
  }
}
