import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/splashPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../module/color_def.dart';

Future<void> main() async {
  await initializeDateFormatting(); // 달력 한국어 활용 목적
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // 가로모드 막기
  MobileAds.instance.initialize();
  // test 를 위한 코드
  // MobileAds.instance.updateRequestConfiguration(
  //     RequestConfiguration(testDeviceIds: ['09b182c1097886c9f957eae5ec353c6b'])
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        title: 'easy Delivery Watch',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: color1),
          useMaterial3: true,
        ),
        builder: (context, child) {
          return MediaQuery(
              data: MediaQuery.of(context)
                  .copyWith(textScaler: TextScaler.linear(1.0)),
              child: child!);
        },
        home: child,
      ),
      child: SplashScreen(),
    );
  }
}
