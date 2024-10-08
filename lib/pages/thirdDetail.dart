import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../module/udf.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import '../module/admob_class.dart';
import 'logFormat_1_basic.dart';
import '../module/firebase_screen_view.dart';

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

    logScreenView('기록 재 확인 화면', 'ThirdDetail');

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

    Color color1Final = getColorFinal(context, color1, color1Dark);

    return Scaffold(
        appBar: AppBar(
          // title: Text('진통 기록'),
          scrolledUnderElevation:0.0,
          elevation: 0,
          // backgroundColor : color1,
          foregroundColor : Theme.of(context).colorScheme.onBackground,
          backgroundColor: getColorFinal(context,color1,color1Dark),
          // automaticallyImplyLeading: false,
        )
        ,
        body:
        SafeArea(
            child: Column(
              children: [
                Container(
                  color: getColorFinal(context,color1,color1Dark),
                  width: double.infinity,
                  height: 185.0,
                  alignment: Alignment.center,
                  child: Container(
                    width: 360.0,
                    height: 160.0,
                    decoration: BoxDecoration(color:
                    getColorFinal(context,color10, color10Dark),
                        border: Border.all(
                            color: getColorFinal(context,color10, color10Dark),
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
                Divider(
                  height: 1.0,
                  // color: Colors.white,
                  color: getColorFinal(context, color12, color12Dark),
                  thickness:1.0,
                ),
                Expanded(child:
                  ListView.separated(
                      separatorBuilder: (BuildContext context, int index)
                      => Divider(
                        color: getColorFinal(context, color11, color11Dark),
                        indent: 10,
                        endIndent: 10,
                        height: 0.0,),
                      itemCount: widget.hurtRecodeAll.length + 1,
                      itemBuilder: (context, index){
                        if (index == widget.hurtRecodeAll.length) {
                          return SizedBox();
                        } else {
                          return
                            logFormat_1_basic(
                                widget.hurtRecodeAll.length,
                                index,
                                widget.hurtRecodeAll[index][0],
                                widget.hurtRecodeAll[index][1],
                                30.0,
                                context
                            );
                        }
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
