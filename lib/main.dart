import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../pages/splashPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import '../module/color_def.dart';
import 'package:provider/provider.dart';
import 'module/darkThemeProvider.dart'; // ThemeProvider 파일 import
import '../module/timerModul.dart';

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
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TimerModule()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final themeProvider = Provider.of<ThemeProvider>(context);

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      builder: (context, child) => MaterialApp(
        title: 'easy Delivery Watch',
        debugShowCheckedModeBanner: false,
        // theme: ThemeData(
        //   // primarySwatch:color1,
        //   colorScheme: ColorScheme.fromSeed(
        //       seedColor: color1,
        //       brightness: Brightness.light,
        //       // primaryContainer:color1,
        //       primary: Colors.amber,
        //
        //   ),
        //   useMaterial3: true,
        //   // brightness: Brightness.light),
        // ),
        // darkTheme: ThemeData(
        //   colorScheme: ColorScheme.fromSeed(
        //       seedColor: color1,
        //       brightness: Brightness.dark,
        //       // primaryContainer:Colors.white,
        //       // primary:Colors.red,
        //   ),
        //   useMaterial3: true,
        //   // brightness: Brightness.dark),
        // ),
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: color1,
            brightness: Brightness.light,
          ),
          useMaterial3: true,
        ),
        darkTheme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFFF6E6E4),
            brightness: Brightness.dark,
          ),
          useMaterial3: true,
        ),
        themeMode: themeProvider.themeMode,
        // 시스템 설정에 따라 자동 전환
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
