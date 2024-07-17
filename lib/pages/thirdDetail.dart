import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../module/udf.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import '../module/admob_class.dart';
import 'logFormat_1_basic.dart';

class ThirdDetail extends StatefulWidget {

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
  State<ThirdDetail> createState() => _ThirdDetailState();
}

class _ThirdDetailState extends State<ThirdDetail> {

  BannerAd? _banner;

  @override
  void initState(){
    super.initState();
    _createBannerAd();
  }

  void _createBannerAd(){
    _banner = BannerAd(
      size: AdSize.banner
      , adUnitId: AdMobService.bannerAdUnitId!
      , listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {

    // Admob admob = Admob(context: context);
    // BannerAd banner = admob.getBanner(context);
    // print(widget.hurtRecodeAll[0][0]+widget.hurtRecodeAll[0][1]);
    // print(widget.hurtRecodeAll);

    return Scaffold(
        appBar: AppBar(
          // title: Text('진통 기록'),
          scrolledUnderElevation:0.0,
          elevation: 0,
          backgroundColor : color1,
          foregroundColor : Theme.of(context).colorScheme.onBackground,
          // automaticallyImplyLeading: false,
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
                            widget.theDate.substring(0,10).replaceAll('-', '. '),
                            style: const TextStyle(
                                fontSize: 19.5
                                ,height: 2.5
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
                            Text('시작시간 ${widget.startTime}',
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
                              AutoSizeText('총진통시간 ${widget.wholeHurtTime}',
                                style: const TextStyle(
                                    fontSize: 14.5
                                    ,color: color4
                                    ,height: 1.3
                                ),
                                textAlign: TextAlign.start,
                                maxLines: 1,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child:
                            Text('진통횟수 ${widget.hurtCount}회',
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
                            AutoSizeText("3회 ${widget.hurtInterval}",
                              style: const TextStyle(
                                  fontSize: 14.5
                                  ,color: color4
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                            ),
                            ),
                          ],
                        ),
                        Container(
                          height: 20,
                        ),
                        Container(
                            height: 27,
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
                      itemCount: widget.hurtRecodeAll.length,
                      itemBuilder: (context, index){
                        return
                          logFormat_1_basic(
                            widget.hurtRecodeAll.length,
                            index,
                            widget.hurtRecodeAll[index][0],
                            widget.hurtRecodeAll[index][1],
                            30.0,
                          );
                        // Container(
                        //   height: 100.0,
                        //   color: Colors.white70,
                        //   child:
                        //   Row(
                        //     children: [
                        //       Container(
                        //         height : 100,
                        //         width: 130,
                        //         alignment : Alignment.center,
                        //         child: Padding(
                        //           padding: const EdgeInsets.fromLTRB(30.0, 0.0,
                        //               0.0, 0.0),
                        //           child: AutoSizeText(
                        //             secToText(widget.hurtRecodeAll[index][0]),
                        //             style: const TextStyle(
                        //                 fontSize: 19
                        //                 ,color: color4
                        //             ),
                        //             maxLines: 1,
                        //           ),
                        //         ),
                        //       ),
                        //       Expanded(child:
                        //         Container(
                        //           height : 100,
                        //           alignment : Alignment.center,
                        //           child: AutoSizeText(
                        //             secToText
                        //               (widget.hurtRecodeAll[index][0]+widget.hurtRecodeAll[index][1]),
                        //             style: const TextStyle(
                        //                 fontSize: 26
                        //                 ,color: color5
                        //             ),
                        //             maxLines: 1,
                        //           ),
                        //         ),
                        //       ),
                        //       Container(
                        //         height : 100,
                        //         width: 130,
                        //         alignment : Alignment.center,
                        //         child: Padding(
                        //           padding: const EdgeInsets.fromLTRB(0.0, 0.0, 30.0, 0.0),
                        //           child: AutoSizeText(
                        //             secToText(widget.hurtRecodeAll[index][1]),
                        //             style: const TextStyle(
                        //                 fontSize: 19
                        //                 ,color: color4
                        //             ),
                        //             maxLines: 1,
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // );
                      }
                  )
                ),
                Container(
                  alignment: Alignment.center,
                  width: _banner!.size.width.toDouble(),
                  height: _banner!.size.height.toDouble(),
                  child: AdWidget(
                    ad: _banner!,
                  ),
                ),
              ],
            )
        )
    );
  }
}
