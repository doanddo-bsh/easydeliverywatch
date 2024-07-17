import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../module/color_def.dart';
import '../module/udf.dart';

Widget baseCircleTree(context,int cnt, int secondes2, int secondes1){
  return SizedBox(
    height: 85,
    child: Stack(
      children: [
        Container(
          // color: Colors.amber,
          height: 50,
          alignment: Alignment.center,
          child: Row(
            children: [
              SizedBox(
                width: (MediaQuery.of(context).size.width/3)*1,
              ),
              SizedBox(
                width: (MediaQuery.of(context).size.width/3)*1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      color:Colors.amber,
                      width: 20.0.w,
                      height: 50.h,
                    )
                  ],
                ),
              ),
              Container(
                alignment:Alignment.centerLeft,
                width: (MediaQuery.of(context).size.width/3),
                child: AutoSizeText(
                  secToText(secondes2),
                  style: const TextStyle(
                    fontSize: 26
                    ,color: color5,
                  ),
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 40.h,
          child: Container(
              height: 50,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment:Alignment.centerRight,
                    width: (MediaQuery.of(context).size.width/3),
                    child: AutoSizeText(
                      secToText(secondes1),
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
                          '${cnt}'),
                    ),
                  )
                ],
              )
          ),
        )
      ],
    ),
  );
}

Widget baseCircleOnly(context,int cnt, int secondes){
  return Column(
    children: [
      Container(
          height: 50,
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                alignment:Alignment.centerRight,
                width: (MediaQuery.of(context).size.width/3),
                child: AutoSizeText(
                  secToText(secondes),
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
                      '${cnt}'),
                ),
              )
            ],
          )
      )
    ],
  );
}


Widget connectingMyMainPageBody(
      timer,
      lapTimeType2,
      _scrollController,
      context,
    )
  {

    int cicleCount;
    if (timer.cnt ==0){
      cicleCount = 0;
    } else {
      cicleCount = timer.cnt - 1;
    }

    print(timer.cnt);
    print(timer.secondsHurt);

  return
      SafeArea(
        child: Column(
          children: [
            Container(
              height: 150.h,
              child: Text('여기 평균 등 넣자'),
            ),
            (timer.cnt!=0)?
            timer.hurt?baseCircleOnly(context,cicleCount+1, timer.seconds)
            :baseCircleTree(
                context,cicleCount+1, timer.seconds, timer.secondsHurt
            ):baseCircleOnly(context,0, 0)
            ,

            Expanded(
              child: Scrollbar(
                controller: _scrollController,
                child: ListView.builder(
                    reverse: true,
                    controller: _scrollController,
                    itemCount: cicleCount,
                    itemBuilder: (BuildContext ctx, int idx){

                      return
                      Align(
                        heightFactor: 0.8,
                        child: (
                          Column(
                            children: [
                              baseCircleTree(
                                  context
                                  ,cicleCount - idx
                                  ,lapTimeType2[(idx+1)*2-2]
                                  ,lapTimeType2[(idx+1)*2-1]
                              )
                            ],
                          )
                        
                        ),
                      );

                      // if ((idx == 0)&(lapTimeType2.length % 2 == idx % 2)){
                      //   return Container(
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //             alignment:Alignment.centerRight,
                      //             width: (MediaQuery.of(context).size.width/3),
                      //             child: AutoSizeText(
                      //               secToText(timer.seconds),
                      //               style: const TextStyle(
                      //                 fontSize: 26
                      //                 ,color: color5,
                      //               ),
                      //               maxLines: 1,
                      //             ),
                      //           ),
                      //           Container(
                      //             alignment:Alignment.center,
                      //             width: (MediaQuery.of(context).size.width/3),
                      //             child: CircleAvatar(
                      //               child: Text(
                      //                   '${((lapTimeType2.length - idx)/2
                      //                       + 1).toInt()}'),
                      //             ),
                      //           )
                      //         ],
                      //       )
                      //   );
                      // } else if (lapTimeType2.length % 2 == idx % 2) {
                      //   return Container(
                      //       height: 50,
                      //       alignment: Alignment.center,
                      //       child: Row(
                      //         children: [
                      //           Container(
                      //             alignment:Alignment.centerRight,
                      //             width: (MediaQuery.of(context).size.width/3),
                      //             child: AutoSizeText(
                      //               secToText(lapTimeType2[idx-1]),
                      //               style: const TextStyle(
                      //                 fontSize: 26
                      //                 ,color: color5,
                      //               ),
                      //               maxLines: 1,
                      //             ),
                      //           ),
                      //           Container(
                      //             alignment:Alignment.center,
                      //             width: (MediaQuery.of(context).size.width/3),
                      //             child: CircleAvatar(
                      //               child: Text(
                      //                   '${((lapTimeType2.length - idx)/2
                      //                       + 1).toInt()}'),
                      //             ),
                      //           )
                      //         ],
                      //       )
                      //   );
                      // } else if ((idx == 0)
                      //             &(lapTimeType2.length % 2 != idx % 2)){
                      //   return Container(
                      //     // color: Colors.amber,
                      //     height: 50,
                      //     alignment: Alignment.center,
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           width: (MediaQuery.of(context).size.width/3)*1,
                      //         ),
                      //         SizedBox(
                      //           width: (MediaQuery.of(context).size.width/3)*1,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 color:Colors.amber,
                      //                 width: 10.0.w,
                      //                 height: 50.h,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Container(
                      //           alignment:Alignment.centerLeft,
                      //           width: (MediaQuery.of(context).size.width/3),
                      //           child: AutoSizeText(
                      //             secToText(timer.seconds),
                      //             style: const TextStyle(
                      //               fontSize: 26
                      //               ,color: color5,
                      //             ),
                      //             maxLines: 1,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      // }
                      // else {
                      //   return Container(
                      //     // color: Colors.amber,
                      //     height: 50,
                      //     alignment: Alignment.center,
                      //     child: Row(
                      //       children: [
                      //         SizedBox(
                      //           width: (MediaQuery.of(context).size.width/3)*1,
                      //         ),
                      //         Container(
                      //           width: (MediaQuery.of(context).size.width/3)*1,
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Container(
                      //                 color:Colors.amber,
                      //                 width: 30.0.w,
                      //                 height: 50.h,
                      //               )
                      //             ],
                      //           ),
                      //         ),
                      //         Container(
                      //           alignment:Alignment.centerLeft,
                      //           width: (MediaQuery.of(context).size.width/3),
                      //           child: AutoSizeText(
                      //             secToText(lapTimeType2[idx-1]),
                      //             style: const TextStyle(
                      //               fontSize: 26
                      //               ,color: color5,
                      //             ),
                      //             maxLines: 1,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   );
                      }

                ),
              )
            ),
          ],
        )
      );

}