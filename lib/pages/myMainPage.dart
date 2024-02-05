import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'privacySettingPage.dart';
import 'package:async_preferences/async_preferences.dart';
import 'package:easydeliverywatch/regulation/initialization_helper.dart';

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

  final ScrollController _scrollController = ScrollController();

  // 스크롤 위치를 맨위로 이동시킵니다.
  void _scrollToTop() {
    setState(() {
      _scrollController.jumpTo(0);
    });
  }

  BannerAd? _banner;
  DateTime datetimePause = DateTime.now();
  DateTime datetimeResume = DateTime.now();
  int timeDiff = 0;
  bool pauseYn = false;
  int secondsAtPause = 0 ;

  String _authStatus = 'Unknown';
  @override
  void initState(){
    super.initState();

    // IDFA 대응
    WidgetsBinding.instance.addPostFrameCallback((_) =>initPlugin());

    _createBannerAd();
    loadAd();
    WidgetsBinding.instance.addObserver(this);

    _future = _isUnderGdpr();
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
        break;
      case AppLifecycleState.inactive:
        // print('inactive');
        break;
      case AppLifecycleState.hidden:  // <-- This is the new state.
        // print('hidden');
        break;
      case AppLifecycleState.detached:
        // print('detached');
        if (timer.lapTime.length > 0){
          timer.resetTimer();
        }
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  Future<void> initPlugin() async { // 앱추적
    try{
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined){
        await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException{
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  void _createBannerAd(){
    _banner = BannerAd(
        size: AdSize.banner
        , adUnitId: AdMobService.bannerAdUnitId!
        , listener: AdMobService.bannerAdListener
        , request: const AdRequest(),
    )..load();
  }

  static String? get fullScreenAdid{
    if (kReleaseMode){
      if (Platform.isAndroid) {
        return 'ca-app-pub-7191096510845066/2310219248';
      } else if (Platform.isIOS){
        return 'ca-app-pub-7191096510845066/9263420651';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else if (Platform.isIOS){
        return 'ca-app-pub-3940256099942544/4411468910';
      }
    }
  }

  InterstitialAd? _interstitialAd;

  /// Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
        adUnitId: fullScreenAdid!,
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          // Called when an ad is successfully received.
          onAdLoaded: (ad) {
            ad.fullScreenContentCallback = FullScreenContentCallback(
              // Called when the ad showed the full screen content.
                onAdShowedFullScreenContent: (ad) {print('ad showed the full screen');},
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {print('impression occurs');},
                // Called when the ad failed to show full screen content.
                onAdFailedToShowFullScreenContent: (ad, err) {
                  // Dispose the ad here to free resources.
                  print('Dispose the ad here to free resources.');
                  ad.dispose();
                },
                // Called when the ad dismissed full screen content.
                onAdDismissedFullScreenContent: (ad) {
                  // Dispose the ad here to free resources.
                  ad.dispose();
                },
                // Called when a click is recorded for an ad.
                onAdClicked: (ad) {
                  print('Called when a click is recorded for an ad.');
                });

            debugPrint('$ad loaded.');
            // Keep a reference to the ad so you can show it later.
            _interstitialAd = ad;
          },
          // Called when an ad request failed.
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error');
          },
        ));
  }

  Future<bool> _onWillPop() async {
    return false; //<-- SEE HERE
  }

  final _initializationHelper = InitializationHelper();
  late final Future<bool> _future ;

  Future<bool> _isUnderGdpr() async {
    final preferences = AsyncPreferences();
    return await preferences.getInt('IABTCF_gdprApplies') == 1;
  }
  
  @override
  Widget build(BuildContext context) {

    TimerModule timer = Provider.of<TimerModule>(context);
    final List<List<int>> lapTime = timer.lapTime;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation:0.0,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () async {
              LinkedHashMap<DateTime,List<Event>> events = await getData(SqliteDayTime());
              print(events);
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
            FutureBuilder<bool>(
              future:_future,
              builder: (context,snapshot){
                if (snapshot.hasData && snapshot.data == true) {
                  return IconButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(
                            builder: (context) => PrivacySettingPage()
                        )
                        );
                      },
                      icon: Icon(Icons.privacy_tip_rounded)
                  );
                } else {
                  return SizedBox();
                }
              },
            ),
            IconButton(
              icon:const Icon(Icons.refresh
                ,color: Colors.black,
              )
              ,onPressed: () {
                // show dialog no log
              if (timer.lapTime.length == 0){
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    surfaceTintColor:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: const Text('진통 기록 초기화',
                      style: TextStyle(fontSize: 17,
                         ),),
                    content: const Text('진통 기록을 모두 삭제하시겠습니까?',
                        style:TextStyle(fontSize: 13.5
                        ,color: Color(0xFF7C7A7A))),
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
                          timer.resetTimerVoid();
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
              } else {
                // show dialog refresh
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    surfaceTintColor:Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    title: const Text('진통 기록 초기화',
                      style: TextStyle(fontSize: 17),),
                    content: const Text('진통 기록을 모두 삭제하시겠습니까?',
                        style:TextStyle(fontSize: 13.5
                        ,color: Color(0xFF7C7A7A))),
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
              }
              // timer.resetTimer();
            },
            ),
          ],
          backgroundColor : color1,
        )
        ,
        body:
        // Container(
        //     width: MediaQuery.of(context).size.width * 1,
        //     height: MediaQuery.of(context).size.height * 1,
        //     child: Stack(
        //       children: [
                SafeArea(
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
                        Container(
                          height: 65,
                          decoration: const BoxDecoration(color: color1),
                          width: double.infinity,
                          child: Center(
                              child:AutoSizeText(
                                secToText(timer.seconds)
                                ,style: TextStyle(
                                fontSize: 55,
                                color: timer.hurt? color3 : color2,
                                ),
                                maxLines: 1,
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
                        Expanded(child:
                        Scrollbar(
                          controller: _scrollController,
                          child: ListView.separated(
                            controller: _scrollController,
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
                                          child: AutoSizeText(
                                            secToText(lapTime[index][0]),
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
                                          secToText(lapTime[index][2]),
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
                                          padding: const EdgeInsets.fromLTRB(0.0, 0.0, 60.0, 0.0),
                                          child: AutoSizeText(
                                            secToText(lapTime[index][1]),
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
                            },
                            separatorBuilder: (BuildContext context, int index)
                            => Divider(
                              color: Colors.grey[400],
                              indent: 20,
                              endIndent: 20,
                              height: 0.0,),
                            ),
                        ),
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
                ),
                // Positioned.fill(
                //     bottom: 25,
                //     child: Align(
                //       alignment: Alignment.bottomCenter,
                //       child:
                //         Container(
                //           alignment: Alignment.center,
                //           width: _banner!.size.width.toDouble(),
                //           height: _banner!.size.height.toDouble(),
                //           child: AdWidget(
                //             ad: _banner!,
                //           ),
                //         ),
                //     ),
                // ),
        //       ]
        //     ),
        // ),
        // bottomNavigationBar: _banner == null ?
        //                     Container() :
        //                     Container(
        //                         // padding: EdgeInsets.only(bottom: 10.0),
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
                  Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.16
              ),
              child: Container(
                height: 65,
                width: 250,
                child: FloatingActionButton.extended(
                  heroTag: "btn1",
                  label:Text(timer.hurt ? '진통 멈춤' : '진통 시작'
                    ,style: const TextStyle(fontSize: 23,color: color5),
                  ),
                  elevation: 0,
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
                      _scrollToTop();
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
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image(image: AssetImage
                                      ('assets/appIcon/easydeliveryAppicon6'
                                        '.png')),
                                  ),
                                ),
                                description: Container(
                                  height: 80,
                                  child: Column(
                                    children: [
                                      const Text('엄마 저를 만나러 오세요!',
                                        style: TextStyle(
                                          fontSize: 17.5,
                                          height: 0.7
                                        ),
                                      ),
                                      const SizedBox(height: 3.0,),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Padding(padding: const EdgeInsets
                                              .fromLTRB(0.0, 10.0,
                                              0.0, 0.0),
                                            child: Text(timer.isFirst?
                                            '평균 주기가 10분 미만이니'
                                                :'평균 주기가 5분 미만이니'
                                              ,
                                              style: const TextStyle(
                                                  fontSize: 12.0
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
                                                fontSize: 12.0
                                            ),
                                          ),
                                          Container(
                                              height: 11.0,
                                              width: 17,
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
                  Alignment.bottomRight.x - 0.11, Alignment.bottomRight.y -
                  0.18
              ),
              child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: (){
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) {
                        if (timer.isFirst) {
                          return AlertDialog(
                            surfaceTintColor:Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: const Text('초산으로 바꾸시겠습니까?'
                              ,style: TextStyle(
                                  fontSize: 17
                                  ,color: Colors.black
                              ),
                            ),
                            content: const Text('초산은 5분 미만입니다',style: TextStyle(
                              fontSize: 13.5,
                                color: Color(0xFF7C7A7A))),
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
                          );
                        } else {
                          return AlertDialog(
                            // backgroundColor:Colors.white,
                            surfaceTintColor:Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: const Text('경산으로 바꾸시겠습니까?'
                              ,style: TextStyle(
                                  fontSize: 17
                                  ,color: Colors.black
                              ),
                            ),
                            content: const Text('경산은 10분 미만입니다'
                              ,style: TextStyle(
                                fontSize: 13.5
                                ,color: Color(0xFF7C7A7A)
                            ),),
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
                          );
                        }
                      }
                    );
                  },
                  backgroundColor: color1,
                  foregroundColor: color4,
                  mini: true,
                  tooltip: '초산 경산 여부',
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),),
                  child: Text(timer.isFirst? '경산':'초산',
                    style: const TextStyle (fontSize: 13),)
              ),
            )
          ],
        ),
      ),
    );
  }
}