import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/myMainPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp]); // 가로모드 막기
  MobileAds.instance.initialize();
  MobileAds.instance.updateRequestConfiguration(
      RequestConfiguration(testDeviceIds: ['02C9012E-2668-44F4-AEB6-89E2C7CF4FBD']));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // 변경 전
    // return MaterialApp(
    //   title: 'easy Delivery Watch',
    //   theme: ThemeData(
    //     colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    //     useMaterial3: true,
    //   ),
    //   home: const MyHomePage(),
    // );
    return ScreenUtilInit(
        designSize: Size(390, 844),
        builder: (context, child) => MaterialApp(
          title: 'easy Delivery Watch',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          builder: (context, child){
            return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: child!);
          },
          home: child,
        ),
      child: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return MyMainPage();
  }
}
