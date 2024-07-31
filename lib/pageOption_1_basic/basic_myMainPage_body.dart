import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import '../module/udf.dart';
import '../pages/logFormat_1_basic.dart';


Widget basicMyMainPageBody(
    timer,
    lapTime,
    _scrollController,
    _banner,
    context
    ){

  return
    SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(color: getColorFinal(context, color1, color1Dark)),
              width: double.infinity,
              child: Center(
                  child:Text(timer.hurt? '진통중' : '휴식중'
                    ,style: TextStyle(
                      fontSize: 20,
                      color: timer.hurt?
                      Theme.of(context).colorScheme.primaryContainer :
                      Theme.of(context).colorScheme.onPrimary,
                    ),
                  )
              ),
            ),
            Container(
              height: 65,
              decoration: BoxDecoration(color: getColorFinal(context, color1, color1Dark)),
              width: double.infinity,
              child: Center(
                  child:AutoSizeText(
                    // seconds를 text로 변경해주는 코드
                    secToText(timer.seconds)
                    ,style: TextStyle(
                    fontSize: 55,
                    color: timer.hurt?
                    Theme.of(context).colorScheme.primaryContainer :
                    Theme.of(context).colorScheme.onPrimary,
                  ),
                    maxLines: 1,
                  )
              ),
            ),
            Container(
              height: 15,
              color: getColorFinal(context, color1, color1Dark),
            ),
            Container(
              decoration: BoxDecoration(color: getColorFinal(context, color1, color1Dark)),
              width: double.infinity,
              child: Center(
                  child:Text(hurtAvgFnc(lapTime)
                    ,style: const TextStyle(
                        fontSize:16
                        ,color: color4
                    ),)
              ),
            ),
            Container(
              height: 20,
              color: getColorFinal(context, color1, color1Dark),
            ),
            Container(
                decoration: BoxDecoration(color: getColorFinal(context, color1, color1Dark)),
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
              color: getColorFinal(context, color1, color1Dark),
            ),
            Divider(
              height: 1.0,
              // color: Colors.white,
              color: Theme.of(context).colorScheme.onSecondary,
              thickness:1.0,
            ),
            Expanded(child:
              Container(
                color: Theme.of(context).colorScheme.onPrimaryContainer,
                child: Scrollbar(
                  controller: _scrollController,
                  child: ListView.separated(
                    controller: _scrollController,
                    itemCount: lapTime.length + 1,
                    itemBuilder: (context, index){
                      if (index == lapTime.length) {
                        return Container(
                          // height: 600.0,
                            decoration: BoxDecoration(
                                color: Theme.of(context).colorScheme.onPrimaryContainer
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
                                      // color: Colors.black87,
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
                                      // color: Colors.black87,
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
                                      // color: Colors.black87,
                                      fontSize: 10.0,
                                    ),
                                  ),
                                  // SizedBox(height: 7.0,),
                                  const Text("견디기 힘든 통증이거나 "
                                      "양수가 터지거나 피가 비치는 경우\n즉시 병원으로 가는 것을"
                                      " 권합니다."
                                    ,textAlign: TextAlign.center
                                    ,style: TextStyle(
                                      // color: Colors.black87,
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
                      } else {
                        return
                          logFormat_1_basic(
                            lapTime.length,
                            index,
                            lapTime[index][0],
                            lapTime[index][1],
                            60.0,
                            context
                          );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index)
                    => Divider(
                      color: Theme.of(context).colorScheme.secondary,
                      // color: Colors.white,
                      indent: 10,
                      endIndent: 10,
                      height: 0.0,),
                  ),
                ),
              ),
            ),
            Container(
              // color: Theme.of(context).colorScheme.primary,
              // decoration: BoxDecoration(
              //   color: getColorFinal(context, color1, color1Dark), // 원하는 배경 색상 지정
              //   // border: Border.all(color: Colors.black), // 테두리 추가 (선택 사항)
              // ),
              alignment: Alignment.center,
              width: _banner!.size.width.toDouble(),
              height: _banner!.size.height.toDouble(),
              child: AdWidget(
                ad: _banner!,
              ),
            ),
          ],
        )
    );
}