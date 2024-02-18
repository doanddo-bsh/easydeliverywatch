import 'package:flutter/material.dart';

Widget connectingMyMainPageBody(
      lapTimeType2,
    ){
  return
      ListView.builder(
        itemCount: lapTimeType2.length + 1,
        itemBuilder: (BuildContext ctx, int idx){
          return Text('test $idx');
        }
      );
}