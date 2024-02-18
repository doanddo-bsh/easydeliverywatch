import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../module/udf.dart';
import '../module/color_def.dart';

// 아직 테스트 중

Widget logFormat_2_9m(
    logCountAll
    ,index
    ,contractionsTimeInfo
    ,restTimeInfo
    ,paddingNum
    ,context
    ){
  return Container(
    height: 70.0.h,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          // height: 50,
          width: (MediaQuery.of(context).size.width/3)*2,
          color: Colors.amber,
        ),
        Container(
          width: MediaQuery.of(context).size.width/3,
          color: Colors.black12,
          // alignment: Alignment.bottomCenter,
          // child: CircleAvatar(
          //   child: Text(
          //     (logCountAll - (index)).toString(), // Displaying index starting
          //     // from 1
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   backgroundColor: Colors.blue, // Change circle color as desired
          // ),
        ),
      ],
    ),
  );
}




// Container(
// height: 70.0.h,
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// children: [
// Container(
// height: 50,
// width: MediaQuery.of(context).size.width/3,
// alignment: Alignment.bottomCenter,
// child: Padding(
// padding: EdgeInsets.fromLTRB(paddingNum, 0.0, 0.0, 0.0),
// child: AutoSizeText(
// secToText(contractionsTimeInfo),
// style: const TextStyle(
// fontSize: 19,
// color: color4
// ),
// maxLines: 1,
// ),
// ),
// ),
// Container(
// height: 50,
// width: MediaQuery.of(context).size.width/3,
// alignment: Alignment.bottomCenter,
// child: CircleAvatar(
// child: Text(
// (logCountAll - (index)).toString(), // Displaying index starting
// // from 1
// style: TextStyle(color: Colors.white),
// ),
// backgroundColor: Colors.blue, // Change circle color as desired
// ),
// ),
// Container(
// height: 50,
// width: MediaQuery.of(context).size.width/3,
// alignment: Alignment.topCenter,
// child: Padding(
// padding: EdgeInsets.fromLTRB(0.0, 0.0, paddingNum, 0.0),
// child: AutoSizeText(
// secToText(contractionsTimeInfo + restTimeInfo),
// style: const TextStyle(
// fontSize: 19,
// color: color4
// ),
// maxLines: 1,
// ),
// ),
// ),
// ],
// ),
// );