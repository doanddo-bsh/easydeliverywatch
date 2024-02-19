import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../module/color_def.dart';
import '../module/udf.dart';
import '../pages/logFormat_1_basic.dart';


Widget connectingMyMainPageBody(
      lapTimeType2,
      timer,
      _scrollController,
      context,
    )
  {
  return
      SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                    controller: _scrollController,
                    itemCount: lapTimeType2.length + 1,
                    itemBuilder: (BuildContext ctx, int idx){
                      if ((idx == 0)&(lapTimeType2.length % 2 == idx % 2)){
                        return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  alignment:Alignment.centerRight,
                                  width: (MediaQuery.of(context).size.width/3),
                                  child: AutoSizeText(
                                    secToText(timer.seconds),
                                    style: const TextStyle(
                                      fontSize: 26
                                      ,color: color5,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  alignment:Alignment.center,
                                  width: (MediaQuery.of(context).size.width/3),
                                  child: CircleAvatar(
                                    child: Text(
                                        '${((lapTimeType2.length - idx)/2
                                            + 1).toInt()}'),
                                  ),
                                )
                              ],
                            )
                        );
                      } else if (lapTimeType2.length % 2 == idx % 2) {
                        return Container(
                            height: 50,
                            alignment: Alignment.center,
                            child: Row(
                              children: [
                                Container(
                                  alignment:Alignment.centerRight,
                                  width: (MediaQuery.of(context).size.width/3),
                                  child: AutoSizeText(
                                    secToText(lapTimeType2[idx-1]),
                                    style: const TextStyle(
                                      fontSize: 26
                                      ,color: color5,
                                    ),
                                    maxLines: 1,
                                  ),
                                ),
                                Container(
                                  alignment:Alignment.center,
                                  width: (MediaQuery.of(context).size.width/3),
                                  child: CircleAvatar(
                                    child: Text(
                                        '${((lapTimeType2.length - idx)/2
                                            + 1).toInt()}'),
                                  ),
                                )
                              ],
                            )
                        );
                      } else if ((idx == 0)
                                  &(lapTimeType2.length % 2 != idx % 2)){
                        return Container(
                          // color: Colors.amber,
                          height: 50,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width/3)*1,
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width/3)*1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color:Colors.amber,
                                      width: 30.0.w,
                                      height: 50.h,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment:Alignment.centerLeft,
                                width: (MediaQuery.of(context).size.width/3),
                                child: AutoSizeText(
                                  secToText(timer.seconds),
                                  style: const TextStyle(
                                    fontSize: 26
                                    ,color: color5,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      else {
                        return Container(
                          // color: Colors.amber,
                          height: 50,
                          alignment: Alignment.center,
                          child: Row(
                            children: [
                              SizedBox(
                                width: (MediaQuery.of(context).size.width/3)*1,
                              ),
                              Container(
                                width: (MediaQuery.of(context).size.width/3)*1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      color:Colors.amber,
                                      width: 30.0.w,
                                      height: 50.h,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                alignment:Alignment.centerLeft,
                                width: (MediaQuery.of(context).size.width/3),
                                child: AutoSizeText(
                                  secToText(lapTimeType2[idx-1]),
                                  style: const TextStyle(
                                    fontSize: 26
                                    ,color: color5,
                                  ),
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                ),
              )
            ),
          ],
        )
      );

}