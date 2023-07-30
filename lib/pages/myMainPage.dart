import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:collection/collection.dart';
import 'dart:collection';
import '../module/udf.dart';
import '../module/color_def.dart';
import '../module/admob_class.dart';
import '../module/timerModul.dart';
import '../module/customAlertDialog.dart';
import '../module/sqliteDayTime.dart';
import 'secondCalendar.dart';

class MyMainPage extends StatelessWidget {
  const MyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider<TimerModule>(  // provider 활용을 위해 설정함
        create: (BuildContext context) => TimerModule(),
        child: const MyMainPageBody()
    );
  }
}

class MyMainPageBody extends StatefulWidget {
  const MyMainPageBody({Key? key}) : super(key: key);

  @override
  State<MyMainPageBody> createState() => _MyMainPageBodyState();
}

class _MyMainPageBodyState extends State<MyMainPageBody>
    with WidgetsBindingObserver
{

  BannerAd? _banner;
  DateTime datetimePause = DateTime.now();
  DateTime datetimeResume = DateTime.now();
  int timeDiff = 0;
  bool pauseYn = false;
  int secondsAtPause = 0 ;

  @override
  void initState(){
    super.initState();

    _createBannerAd();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    TimerModule timer = Provider.of<TimerModule>(context, listen: false);

    super.didChangeAppLifecycleState(state);
    switch(state){
      case AppLifecycleState.resumed:

        // print('resumed');
        // datetimeResume = DateTime.now();
        // print('datetimeResume $datetimeResume');
        // final datetimediff = datetimeResume!.difference(datetimePause!);
        // print(datetimediff!.inSeconds);
        // timeDiff = datetimediff!.inSeconds - (timer.seconds - secondsAtPause);
        // print('timeDiff $timeDiff');
        // if (pauseYn == true) {
        //   pauseYn = false;
        //   timer.secondsSet = timeDiff;
        // }
        break;

      case AppLifecycleState.inactive:
        // print('inactive');
        break;
      case AppLifecycleState.hidden:  // <-- This is the new state.
        // print('hidden');
        break;
      case AppLifecycleState.detached:
        // print('detached');
        // 강제 종료 시점
        if (timer.lapTime.length > 0){
          timer.resetTimer();
        }
        break;
      case AppLifecycleState.paused:
        // print('paused');
        // secondsAtPause = timer.seconds ;
        // datetimePause = DateTime.now();
        // print('datetimePause $datetimePause');
        // pauseYn = true;
        break;
    }
  }

  void _createBannerAd(){
    _banner = BannerAd(
        size: AdSize.banner
        , adUnitId: AdMobService.bannerAdUnitId!
        , listener: AdMobService.bannerAdListener
        , request: const AdRequest(),
    )..load();
  }

  @override
  Widget build(BuildContext context) {

    TimerModule timer = Provider.of<TimerModule>(context);
    final List<List<int>> lapTime = timer.lapTime;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: GestureDetector(
          onTap: () async {
            LinkedHashMap<DateTime,List<Event>> events = await getData(SqliteDayTime());
            if (!context.mounted) return;
            Navigator.push(context, MaterialPageRoute(builder: (context) => SecondCalendar(
                events:events
                )
              )
            );
          },
          child: const Icon(
            Icons.calendar_month_rounded,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.refresh
              ,color: Colors.black,
            )
            ,onPressed: () {
            // show dialog
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: const Text('진통 기록 초기화'),
                content: const Text('진통 기록을 모두 삭제하시겠습니까?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, 'Cancel');
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: color4
                    ),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      timer.resetTimer();
                      timer.check_y(0);
                      Navigator.pop(context, 'OK');
                    },
                    style: TextButton.styleFrom(
                        foregroundColor: color4
                    ),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
            // timer.resetTimer();
          },
          )
        ],
        backgroundColor : color1,
      )
      ,
      body:Container(
          width: MediaQuery.of(context).size.width * 1,
          height: MediaQuery.of(context).size.height * 1,
          child: Stack(
            children: [
              SafeArea(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 23,
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
                      Container(
                        height: 60,
                        decoration: const BoxDecoration(color: color1),
                        width: double.infinity,
                        child: Center(
                            child:Text(
                              secToText(timer.seconds)
                              ,style: TextStyle(
                              fontSize: 55,
                              color: timer.hurt? color3 : color2,
                            ),
                            )
                        ),
                      ),
                      Container(
                        height: 15,
                        color: color1,
                      ),
                      Container(
                        decoration: const BoxDecoration(color: color1),
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
                        color: color1,
                      ),
                      Container(
                          decoration: const BoxDecoration(color: color1),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                width: 185,
                                alignment: Alignment.center,
                                child: Text('진통',
                                  style: TextStyle(
                                    fontSize:20
                                    ,color: timer.hurt? color4 : color4,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              Container(
                                width: 190,
                                alignment: Alignment.center,
                                child: Text('휴식',
                                  style: TextStyle(
                                    fontSize:20
                                    ,color: timer.hurt? color4 : color4,
                                    // fontWeight: FontWeight.bold
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
                      Expanded(child:
                      ListView.separated(
                        itemCount: lapTime.length + 1,
                        itemBuilder: (context, index){
                          if (index == lapTime.length) {
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
                                      const SizedBox(height: 12.0,),
                                      const Text("진통이 시작되면 [진통 시작] 버튼"
                                          "\n진통이 멈추면 [진통 멈춤] 버튼을 눌러주세요"
                                        ,textAlign: TextAlign.center
                                        ,style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 30.0,),
                                      Text("‘진진통’은 ’진통간격이 점차 짧아져 평균 주기가"
                                          "5분간격으로\n좁혀지고 일정한 규칙성을 보입니다."
                                        ,textAlign: TextAlign.center
                                        ,style: TextStyle(
                                          color: Colors.grey[400],
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(height: 10.0,),
                                      Text("*통상적으로 경산이 초산보다 자궁경부가 열리는 속도가"
                                          "\n더 빠르기 때문에 초산은  5분이하, 경산은 "
                                          "10분이하의\n진통 간격을 갖으면 병원에 가야합니다*"
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
                                      const SizedBox(height: 30.0,),
                                      const Text("이 앱은 의료 기기가 아닙니다. 수축의 빈도와 간격은"
                                          "\n표준 지표를 기반으로 한 것이며 "
                                          "절대적인 "
                                          "기준이 아니니\n자세한 내용은 "
                                          "의사와 상담할 것을 권합니다."
                                        ,textAlign: TextAlign.center
                                        ,style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      // SizedBox(height: 7.0,),
                                      const Text("견디기 힘든 통증이거나 "
                                          "양수가 터지거나 피가 비치는 경우\n즉시 병원으로 가는 것을"
                                          " 권합니다."
                                        ,textAlign: TextAlign.center
                                        ,style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 90.0,
                                      )
                                    ],
                                  ),
                                ),
                                )
                            );
                          } else {
                            return Container(
                              height: 100.0,
                              color: Colors.white70,
                              // duration: Duration(seconds: 5),
                              // Provide an optional curve to make the animation feel smoother.
                              // curve: Curves.fastOutSlowIn,
                              child:
                              Row(
                                children: [
                                  Container(
                                    height: 100,
                                    width: 130,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(60.0, 0.0, 0.0, 0.0),
                                      child: Text(
                                        secToText(lapTime[index][0]),
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: color4
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(child:
                                  Container(
                                    height: 100,
                                    alignment: Alignment.center,
                                    child: Text(
                                      secToText(lapTime[index][2]),
                                      style: const TextStyle(
                                        fontSize: 26
                                        ,color: color5,
                                      ),
                                    ),
                                  ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 130,
                                    alignment: Alignment.center,
                                    child: Padding(
                                      padding: const EdgeInsets.fromLTRB(0.0, 0.0, 60.0, 0.0),
                                      child: Text(
                                        secToText(lapTime[index][1]),
                                        style: const TextStyle(
                                            fontSize: 19,
                                            color: color4
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index)
                        => Divider(
                          color: Colors.grey[400],
                          indent: 20,
                          endIndent: 20,
                          height: 0.0,),
                        ),
                      ),
                    ],
                  )
              ),
              Positioned.fill(
                  bottom: 25,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child:
                      Container(
                        alignment: Alignment.center,
                        width: _banner!.size.width.toDouble(),
                        height: _banner!.size.height.toDouble(),
                        child: AdWidget(
                          ad: _banner!,
                        ),
                      ),
                  ),
              ),
            ]
          ),
      ),
      // bottomNavigationBar: _banner == null ?
      //                     Container() :
      //                     Container(
      //                         padding: EdgeInsets.only(bottom: 10.0),
      //                         alignment: Alignment.center,
      //                         width: _banner!.size.width.toDouble(),
      //                         height: _banner!.size.height.toDouble(),
      //                         child: AdWidget(
      //                           ad: _banner!,
      //                         ),
      //                     ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        children: [
          Align(
            alignment: Alignment(
                Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.1
            ),
            child: Container(
              height: 65,
              width: 250,
              child: FloatingActionButton.extended(
                heroTag: "btn1",
                label:Text(timer.hurt ? '진통 멈춤' : '진통 시작'
                  ,style: const TextStyle(fontSize: 25),),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(50)
                  ),
                ),
                backgroundColor: timer.hurt ? color2 : color3,
                hoverColor: Colors.orange,
                hoverElevation: 50,
                onPressed: (){
                  // print(timer.minWarning);
                  if (timer.hurt){
                    timer.gonehurt();
                  }else{
                    // service.startService();
                    timer.starthurt();
                    // 최근 3회 평균 진통 주기가 5분 미만 일 경우 알람
                    if ((timer.lapTime.length >=3)
                        &&
                        (timer.lapTime.sublist(0,3).map((m) => m[2]).average.floor() < 60*timer.minWarning)
                    ){
                      // String minWarning_tmp = timer.minWarning.toString();
                      timer.check_y(1);
                      showDialog<String>(
                          context: context,
                          builder: (BuildContext context) {
                            return CustomAlertDialog(
                              title: Container(
                                height: 100.0,
                                width: 100.0,
                                child:
                                const Image(image: AssetImage('assets/easydelivery_app_main_icon_re2.png')),
                              ),
                              description: Container(
                                height: 80,
                                child: Column(
                                  children: [
                                    const Text('엄마 저를 만나러 오세요!',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                      ),
                                    ),
                                    const SizedBox(height: 3.0,),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Padding(padding: const EdgeInsets
                                            .fromLTRB(0.0, 2.5,
                                            0.0, 0.0),
                                          child: Text(timer.isFirst?
                                          '평균 주기가 10분 미만이니'
                                              :'평균 주기가 5분 미만이니'
                                            ,
                                            style: const TextStyle(
                                                fontSize: 13.0
                                            ),
                                          ),
                                        ),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        const Text('병원으로 출발하세요',
                                          style: TextStyle(
                                              fontSize: 13.0
                                          ),
                                        ),
                                        Container(
                                            height: 11.0,
                                            width: 16,
                                            child: const Image(
                                                image: AssetImage
                                                  ('assets/icons8-siren-100.png'))
                                        ),
                                      ],
                                    ),

                                  ],
                                ),
                              ),
                            );
                          }
                      );
                    }
                  }},
              ),
            ),
          ),
          Align(
            alignment: Alignment(
                Alignment.bottomRight.x - 0.07, Alignment.bottomRight.y -
                0.12
            ),
            child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: (){
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      backgroundColor:Colors.white,
                      title: const Text('타이머 알림 시간 변경'),
                      content: const Text('경산은 10분 초산은 5분입니다.'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: color4
                          ),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            timer.firstOrNot();
                            Navigator.pop(context, 'OK');
                          },
                          style: TextButton.styleFrom(
                              foregroundColor: color4
                          ),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                backgroundColor: color1,
                foregroundColor: color4,
                focusColor: Colors.green,
                mini: true,
                tooltip: '초산 경산 여부',
                child: Text(timer.isFirst? '경산':'초산')
            ),
          )
        ],
      ),
    );
  }
}