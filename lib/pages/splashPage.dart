import 'package:flutter/material.dart';
import 'package:easydeliverywatch/module/color_def.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'myMainPage.dart';
import 'dart:async';
import '../regulation/initialize_screen.dart';

class SplashScreen extends StatefulWidget {


  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
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
      backgroundColor: color1,
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
            const SpinKitPumpingHeart(
              color: color2,
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