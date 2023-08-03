import 'package:flutter/material.dart';
import 'package:easydeliverywatch/module/color_def.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'myMainPage.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Timer(
      Duration(microseconds: 1500),
          () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MyMainPage()),
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
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 270),
            // Container(
            //   height: 100.0,
            //   width: 100.0,
            //   child: const Image(image: AssetImage
            //     ('assets/appIcon/easydeliveryAppicon7_space'
            //       '.png')
            //   ),
            // ),
            SizedBox(height: 20.0,),
            Text('진통워치',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 33.0,
                    letterSpacing: 13.0,
                    color: color4
                )
            ),
            SizedBox(height: 30),
            SpinKitPumpingHeart(
              color: color2,
              size: 60,
            ),
            Expanded(child: SizedBox()),
            Align(
              child: Text("© Copyright 2023, 진통워치(Hwatch)",
                  style: TextStyle(
                   // fontWeight: FontWeight.bold,
                    fontSize: 12.0,
                    color: color4
                  )
              ),
            ),
            SizedBox(height: 50),
          ],
        ),

      ),
    );
  }
}