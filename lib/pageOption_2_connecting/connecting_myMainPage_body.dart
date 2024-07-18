import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import '../module/udf.dart';

Widget baseCircleTree(context, int cnt, int secondes2, int secondes1) {
  return SizedBox(
    height: 80.h,
    child: Stack(
      children: [
        Positioned(
          top: 40.h,
          child: Container(
            // color: Colors.amber,
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.amber,
                        width: 20.0.w,
                        height: 40.h,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: (MediaQuery.of(context).size.width / 3),
                  child: AutoSizeText(
                    secToText(secondes2),
                    style: const TextStyle(
                      fontSize: 26,
                      color: color5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 0.h,
          child: Container(
            // color: Colors.black,
              height: 60.h,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: (MediaQuery.of(context).size.width / 3),
                    child: AutoSizeText(
                      secToText(secondes1),
                      style: const TextStyle(
                        fontSize: 26,
                        color: color5,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: (MediaQuery.of(context).size.width / 3),
                    child: CircleAvatar(
                      child: Text('${cnt}'),
                    ),
                  )
                ],
              )),
        ),
      ],
    ),
  );
}

Widget baseCircleOnly(context, int cnt, int secondes) {
  return Column(
    children: [
      Container(
          height: 50.h,
          alignment: Alignment.center,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerRight,
                width: (MediaQuery.of(context).size.width / 3),
                child: AutoSizeText(
                  secToText(secondes),
                  style: const TextStyle(
                    fontSize: 26,
                    color: color5,
                  ),
                  maxLines: 1,
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: (MediaQuery.of(context).size.width / 3),
                child: CircleAvatar(
                  child: Text('${cnt}'),
                ),
              )
            ],
          ))
    ],
  );
}

Widget treeCircleTree(
    context, int cnt, int secondes1, int secondes2, int secondes3) {
  return SizedBox(
    height: 110.h,
    child: Stack(
      children: [
        Positioned(
          top: 5.h,
          child: Container(
            // color: Colors.amber,
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.amber,
                        width: 10.0.w,
                        height: 40.h,
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  width: (MediaQuery.of(context).size.width / 3),
                  child: AutoSizeText(
                    secToText(secondes1),
                    style: const TextStyle(
                      fontSize: 26,
                      color: color5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 60.h,
          child: Container(
            // color: Colors.amber,
            height: 40.h,
            alignment: Alignment.center,
            child: Row(
              children: [
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                ),
                SizedBox(
                  width: (MediaQuery.of(context).size.width / 3) * 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        color: Colors.amber,
                        width: 20.0.w,
                        height: 50.h,
                      )
                    ],
                  ),
                ),
                Container(
                  height: 40.h,
                  alignment: Alignment.centerLeft,
                  width: (MediaQuery.of(context).size.width / 3),
                  child: AutoSizeText(
                    secToText(secondes3),
                    style: const TextStyle(
                      fontSize: 26,
                      color: color5,
                    ),
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 28.h,
          child: Container(
              height: 50.h,
              alignment: Alignment.center,
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: (MediaQuery.of(context).size.width / 3),
                    child: AutoSizeText(
                      secToText(secondes2),
                      style: const TextStyle(
                        fontSize: 26,
                        color: color5,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: (MediaQuery.of(context).size.width / 3),
                    child: CircleAvatar(
                      child: Text('${cnt}'),
                    ),
                  )
                ],
              )),
        ),
      ],
    ),
  );
}

Widget connectingMyMainPageBody(
  timer,
  lapTimeType2,
  _scrollController,
  context,
  _banner,
) {
  int cicleCount;
  if (timer.cnt == 0) {
    cicleCount = 0;
  } else {
    cicleCount = timer.cnt - 1;
  }

  print("timer.cnt ${timer.cnt}");
  print("timer.secondsHurt) ${timer.secondsHurt}");
  print('cicleCount $cicleCount');

  int itemCountVar;
  if (timer.hurt) {
    itemCountVar = timer.cnt;
  } else {
    itemCountVar = timer.cnt + 1;
  }

  return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 30,
            decoration: const BoxDecoration(color: color1),
            width: double.infinity,
            child: Center(
                child:Text(timer.hurt? '진통중' : '휴식중'
                  ,style: TextStyle(
                    fontSize: 20,
                    color: timer.hurt? color3 : color2,
                  ),
                )
            ),
          ),
          // Container(
          //   height: 65,
          //   decoration: const BoxDecoration(color: color1),
          //   width: double.infinity,
          //   child: Center(
          //       child:AutoSizeText(
          //         // seconds를 text로 변경해주는 코드
          //         secToText(timer.seconds)
          //         ,style: TextStyle(
          //         fontSize: 55,
          //         color: timer.hurt? color3 : color2,
          //       ),
          //         maxLines: 1,
          //       )
          //   ),
          // ),
          Container(
            height: 15,
            color: color1,
          ),
          Container(
            decoration: const BoxDecoration(color: color1),
            width: double.infinity,
            child: Center(
                child:Text(hurtAvgFnc(timer.lapTime)
                  ,style: const TextStyle(
                      fontSize:16
                      ,color: color4
                  ),)
            ),
          ),
          Container(
            height: 20,
            color: color1,
          ),
          Container(
              decoration: const BoxDecoration(color: color1),
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          50.0,0.0,0.0,0.0),
                      child: Text('진통',
                        style: TextStyle(
                          fontSize:20
                          ,color: timer.hurt? color4 : color4,
                          //fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  Container(
                    width: 140,
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0.0,0.0,55.0,0.0),
                      child: Text('휴식',
                        style: TextStyle(
                          fontSize:20
                          ,color: timer.hurt? color4 : color4,
                          // fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  )
                ],
              )
          ),
          Container(
            height: 18,
            color: color1,
          ),
          const Divider(
            height: 1.0,
            color: Colors.white,
            thickness:1.0,
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: SizedBox(height: 30.h,),
          ),
          (timer.cnt == 0)
          ? Expanded(child: baseCircleOnly(context, 1, 0))
          : Expanded(
              child: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                  controller: _scrollController,
                  itemCount: timer.cnt + 1,
                  itemBuilder: (BuildContext ctx, int idx) {
                    final reversedIdx = timer.cnt - idx; // 인덱스를 뒤집어서 계산합니다.

                    if (idx == timer.cnt){
                      return Container(
                        // height: 600.0,
                          decoration: const BoxDecoration(
                              color: Colors.white70
                          ),
                          child: Center(child:
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30.0,
                                18.0, 30.0, 10.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 20.0,),
                                const Text("진통이 시작되면 [진통 시작] 버튼"
                                    "\n진통이 멈추면 [진통 멈춤] 버튼을 눌러주세요"
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                const Text("초산모는 5분 미만의 진통주기가 되면"
                                    "\n알려주는 [초산]모드를 사용해주세요."
                                    "\n"
                                    "\n경산모는 10분 미만의 진통주기가 되면 "
                                    "\n알려주는 [경산]모드를 사용해주세요."
                                    "\n"
                                    " \n(초산 글자가 보이면 초산 모드입니다.)"
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                Text("‘진진통’은 ’진통간격이 점차 짧아져 평균 주기가"
                                    "\n5분간격으로 좁혀지고 일정한 규칙성을 보입니다."
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                Text("*통상적으로 경산이 초산보다 자궁경부가 열리는 속도가"
                                    "\n더 빠르기 때문에 초산은  5분이하, 경산은 "
                                    "10분이하의\n진통 간격을 가지면 병원에 가야합니다*"
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 10.0,),
                                Text("‘가진통’은 간격과 주기가 일정하지 않으며 10분 이상의"
                                    "\n불규칙한 간격을 갖습니다. 통증도 생리통정도의 강도로 "
                                    "\n자세를 바꾸면 통증이 점점 약해집니다."
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.grey[400],
                                    fontSize: 12.0,
                                  ),
                                ),
                                const SizedBox(height: 20.0,),
                                const Text("이 앱은 의료 기기가 아닙니다." "\n수축의 "
                                    "빈도와 간격은"
                                    "표준 지표를 기반으로 한 것이며 "
                                    "\n절대적인 "
                                    "기준이 아니니 자세한 내용은 "
                                    "의사와 상담할 것을 권합니다."
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10.0,
                                  ),
                                ),
                                // SizedBox(height: 7.0,),
                                const Text("견디기 힘든 통증이거나 "
                                    "양수가 터지거나 피가 비치는 경우\n즉시 병원으로 가는 것을"
                                    " 권합니다."
                                  ,textAlign: TextAlign.center
                                  ,style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 10.0,
                                  ),
                                ),
                                const SizedBox(
                                  height: 130.0,
                                )
                              ],
                            ),
                          ),
                          )
                      );
                    }

                    else if (reversedIdx == 1) {
                      if (timer.cnt == 1) {
                        return Align(
                          heightFactor: 0.8,
                          child: baseCircleOnly(
                              context, reversedIdx, timer.seconds),
                        );
                      } else {
                        return Align(
                          heightFactor: 0.8,
                          child: baseCircleOnly(
                              context, reversedIdx, lapTimeType2[idx * 2 - 1]),
                        );
                      }
                    } else if (idx == 0) {
                      if (timer.hurt) {
                        return Align(
                          heightFactor: 0.8,
                          child: baseCircleTree(context, reversedIdx,
                              lapTimeType2[(idx)], timer.seconds),
                        );
                      } else {
                        return Align(
                          heightFactor: 0.7,
                          child: treeCircleTree(
                              context,
                              reversedIdx,
                              timer.seconds,
                              timer.secondsHurt,
                              lapTimeType2[(idx) * 2]),
                        );
                      }
                    } else {
                      return Align(
                        heightFactor: 0.8,
                        child: baseCircleTree(
                            context,
                            reversedIdx,
                            lapTimeType2[(idx) * 2],
                            lapTimeType2[(idx) * 2 - 1]),
                      );
                    }
                  }),
            )),
          Container(
            alignment: Alignment.center,
            width: _banner!.size.width.toDouble(),
            height: _banner!.size.height.toDouble(),
            child: AdWidget(
              ad: _banner!,
            ),
          ),
    ],
  ));
}
