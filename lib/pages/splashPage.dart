import 'package:flutter/material.dart';
import 'package:easydeliverywatch/module/color_def.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'myMainPage.dart';
import 'dart:async';
import '../regulation/initialize_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import '../module/firebase_screen_view.dart';

class SplashScreen extends StatefulWidget {


  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    logScreenView('splash 화면', 'SplashScreen');

    Timer(
      const Duration(milliseconds: 1000),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) =>
            InitializeScreen(
                targetWidget: MyMainPage()
            )
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: getColorFinal(context, color1,
          color1Dark),
      body: Container(
        //height : MediaQuery.of(context).size.height,
        //color: kPrimaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 290.h),
            const Text('진통워치',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33.0,
                    letterSpacing: 13.0,
                    color: color4
                )
            ),
            SizedBox(height: 30.h),
            SpinKitPumpingHeart(
              color: getColorFinal(context, color2,
                  color2Dark),
              size: 60,
            ),
            const Expanded(child: SizedBox()),
            const Align(
              child: Text("© Copyright 2023, seohwa lee",
                  style: TextStyle(
                   // fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color4
                  )
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),

      ),
    );
  }
}