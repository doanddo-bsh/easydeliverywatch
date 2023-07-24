import 'package:flutter/material.dart';
import '../module/udf.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import '../module/admob_class.dart';

class ThirdDetail extends StatelessWidget {

  final String theDate;
  final String startTime;
  final String wholeHurtTime;
  final String hurtCount;
  final String hurtInterval;
  final List<List<int>> hurtRecodeAll;

  const ThirdDetail({
    required this.theDate,
    required this.startTime,
    required this.wholeHurtTime,
    required this.hurtCount,
    required this.hurtInterval,
    required this.hurtRecodeAll,
    Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    // Admob admob = Admob(context: context);
    // BannerAd banner = admob.getBanner(context);

    return Scaffold(
        appBar: AppBar(
          // title: Text('진통 기록'),
          elevation: 0,
          backgroundColor : color1,
          foregroundColor : Theme.of(context).colorScheme.onBackground,
        )
        ,
        body:
        SafeArea(
            child: Column(
              children: [
                Container(
                  color: color1,
                  width: double.infinity,
                  height: 185.0,
                  alignment: Alignment.center,
                  child: Container(
                    width: 360.0,
                    height: 160.0,
                    decoration: BoxDecoration(color: Colors.white70,
                        border: Border.all(
                            color: Colors.white70,
                            width: 0.0,
                            style: BorderStyle.solid
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child:
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            theDate.substring(0,10).replaceAll('-', '. '),
                            style: const TextStyle(
                                fontSize: 19.5
                                ,height: 2.0
                                ,color: color4
                            ),
                          ),
                        ),
                        Container(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(child:
                            Text('시작시간 $startTime',
                              style: const TextStyle(
                                  fontSize: 14.5
                                  ,color: color4
                                  ,height: 1.3
                              ),
                              textAlign: TextAlign.end,
                            ),
                            ),
                            const SizedBox(
                              height: 13.0,
                              width: 40.0,
                              child: VerticalDivider(
                                width: 10.0,
                                thickness: 1.0,
                                color: color4,
                              ),
                            ),
                            Expanded(child:
                            Text('총진통시간 $wholeHurtTime',
                              style: const TextStyle(
                                  fontSize: 14.5
                                  ,color: color4
                                  ,height: 1.3
                              ),
                              textAlign: TextAlign.start,
                            ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child:
                            Text('진통횟수 $hurtCount회',
                              style: const TextStyle(
                                  fontSize: 14.5
                                  ,color: color4
                              ),
                              textAlign: TextAlign.end,
                            ),
                            ),
                            const SizedBox(
                              height: 13.0,
                              width: 40.0,
                              child: VerticalDivider(
                                width: 10.0,
                                thickness: 1.0,
                                color: color4,
                              ),
                            ),
                            Expanded(child:
                            Text(hurtInterval,
                              style: const TextStyle(
                                  fontSize: 14.5
                                  ,color: color4
                              ),
                              textAlign: TextAlign.start,
                            ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                            height: 23,
                            width: double.infinity,
                            child: Row(
                              children: [
                                Container(
                                  width: 140,
                                  alignment: Alignment.center,
                                  child: const Text('진통',
                                    style: TextStyle(
                                        fontSize:19.5
                                        ,color: color4
                                      // ,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ),
                                const Expanded(child: SizedBox()),
                                Container(
                                  width: 140,
                                  alignment: Alignment.center,
                                  child: const Text('휴식',
                                    style: TextStyle(
                                        fontSize:19.5
                                        ,color: color4
                                      // ,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                )
                              ],
                            )
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(child:
                ListView.separated(
                    separatorBuilder: (BuildContext context, int index)
                    => Divider(
                      color: Colors.grey[400],
                      indent: 20,
                      endIndent: 20,
                      height: 0.0,),
                    itemCount: hurtRecodeAll.length,
                    itemBuilder: (context, index){
                      return Container(
                        height: 100.0,
                        color: Colors.white70,
                        child:
                        Row(
                          children: [
                            Container(
                              height : 100,
                              width: 130,
                              alignment : Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  secToText(hurtRecodeAll[index][0]),
                                  style: const TextStyle(
                                      fontSize: 19
                                      ,color: color4
                                  ),
                                ),
                              ),
                            ),
                            Expanded(child:
                            Container(
                              height : 100,
                              alignment : Alignment.center,
                              child: Text(
                                secToText
                                  (hurtRecodeAll[index][0]+hurtRecodeAll[index][1]),
                                style: const TextStyle(
                                    fontSize: 26
                                    ,color: color5
                                ),
                              ),
                            ),
                            ),
                            Container(
                              height : 100,
                              width: 130,
                              alignment : Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                                child: Text(
                                  secToText(hurtRecodeAll[index][1]),
                                  style: const TextStyle(
                                      fontSize: 19
                                      ,color: color4
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                )
                ),
                // Container(
                //   alignment: Alignment.center,
                //   width: banner.size.width.toDouble(),
                //   height: banner.size.height.toDouble(),
                //   child: AdWidget(
                //     ad: banner,
                //   ),
                // ),
              ],
            )
        )
    );
  }
}
