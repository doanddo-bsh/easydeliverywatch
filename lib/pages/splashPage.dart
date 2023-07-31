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
      Duration(seconds: 2),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 270),
            Container(
              height: 100.0,
              width: 100.0,
              child: Image(image: AssetImage
                ('assets/appIcon/easydeliveryAppicon7_space'
                  '.png')
              ),
            ),
            SizedBox(height: 20.0,),
            Text('진통워치',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30.0,
                    letterSpacing: 4.0,
                    color: color4
                )
            ),
            SpinKitPumpingHeart(
              color: color2,
            ),
            Expanded(child: SizedBox()),
            Align(
              child: Text("© Copyright 2023, 진통워치(Hwatch)",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0,
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