import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '../module/udf.dart';
import '../module/color_def.dart';

Widget logFormat_1_basic(
    contractionsTimeInfo
    ,restTimeInfo
    ,paddingNum){
  return
    Container(
      height: 100.0,
      color: Colors.white70,
      child:
      Row(
        children: [
          Container(
            height: 100,
            width: 130,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(paddingNum, 0.0, 0.0, 0.0),
              child: AutoSizeText(
                secToText(contractionsTimeInfo),
                style: const TextStyle(
                    fontSize: 19,
                    color: color4
                ),
                maxLines: 1,
              ),
            ),
          ),
          Expanded(child:
          Container(
            height: 100,
            alignment: Alignment.center,
            child: AutoSizeText(
              secToText(contractionsTimeInfo + restTimeInfo),
              style: const TextStyle(
                fontSize: 26
                ,color: color5,
              ),
              maxLines: 1,
            ),
          ),
          ),
          Container(
            height: 100,
            width: 130,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, paddingNum, 0.0),
              child: AutoSizeText(
                secToText(restTimeInfo),
                style: const TextStyle(
                    fontSize: 19,
                    color: color4
                ),
                maxLines: 1,
              ),
            ),
          ),
        ],
      ),
    );
}