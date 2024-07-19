import 'package:app_tracking_transparency/app_tracking_transparency.dart';
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
import '../pageOption_1_basic/basic_myMainPage_body.dart';
import '../pageOption_2_connecting/connecting_myMainPage_body.dart';

class MyMainPage extends StatelessWidget {

  const MyMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TimerModule>(
        // provider 활용을 위해 설정함
        create: (BuildContext context) => TimerModule(),
        child: MyMainPageBody());
  }
}

class MyMainPageBody extends StatefulWidget {
  const MyMainPageBody({Key? key}) : super(key:
  key);

  @override
  State<MyMainPageBody> createState() => _MyMainPageBodyState();
}

class _MyMainPageBodyState extends State<MyMainPageBody>
    with WidgetsBindingObserver {
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
  int secondsAtPause = 0;

  String _authStatus = 'Unknown';

  @override
  void initState() {
    super.initState();

    // IDFA 대응
    WidgetsBinding.instance.addPostFrameCallback((_) => initPlugin());

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
    switch (state) {
      case AppLifecycleState.resumed:
        print('resumed');
        break;
      case AppLifecycleState.inactive:
        print('inactive');
        break;
      case AppLifecycleState.hidden: // <-- This is the new state.
        print('hidden');
        break;
      case AppLifecycleState.detached:
        print('detached');
        if (timer.lapTime.length > 0) {
          timer.resetTimer();
        }
        break;
      case AppLifecycleState.paused:
        break;
    }
  }

  Future<void> initPlugin() async {
    // 앱추적
    try {
      final TrackingStatus status =
          await AppTrackingTransparency.trackingAuthorizationStatus;
      setState(() => _authStatus = '$status');
      // If the system can show an authorization request dialog
      if (status == TrackingStatus.notDetermined) {
        await Future.delayed(const Duration(milliseconds: 200));
        final TrackingStatus status =
            await AppTrackingTransparency.requestTrackingAuthorization();
        setState(() => _authStatus = '$status');
      }
    } on PlatformException {
      setState(() => _authStatus = 'PlatformException was thrown');
    }

    final uuid = await AppTrackingTransparency.getAdvertisingIdentifier();
    print("UUID: $uuid");
  }

  void _createBannerAd() {
    _banner = BannerAd(
      size: AdSize.banner,
      adUnitId: AdMobService.bannerAdUnitId!,
      listener: AdMobService.bannerAdListener,
      request: const AdRequest(),
    )..load();
  }

  static String? get fullScreenAdid {
    if (kReleaseMode) {
      if (Platform.isAndroid) {
        return 'ca-app-pub-7191096510845066/2310219248';
      } else if (Platform.isIOS) {
        return 'ca-app-pub-7191096510845066/9263420651';
      }
    } else {
      if (Platform.isAndroid) {
        return 'ca-app-pub-3940256099942544/1033173712';
      } else if (Platform.isIOS) {
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
                onAdShowedFullScreenContent: (ad) {
              print('ad showed the full screen');
            },
                // Called when an impression occurs on the ad.
                onAdImpression: (ad) {
              print('impression occurs');
            },
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

  final _initializationHelper = InitializationHelper();
  late final Future<bool> _future;

  Future<bool> _isUnderGdpr() async {
    final preferences = AsyncPreferences();
    return await preferences.getInt('IABTCF_gdprApplies') == 1;
  }

  String logFormat = 'basic';

  // laptime1 to 2 flatten
  List<int> flatten(List<List<int>> lapTimeOrg) {
    List<int> lapTimeType2 = [];

    for (List<int> sublist in lapTimeOrg) {
      lapTimeType2.add(sublist[2]);
      lapTimeType2.add(sublist[0]);
    }

    return lapTimeType2;
  }

  @override
  Widget build(BuildContext context) {
    TimerModule timer = Provider.of<TimerModule>(context);
    final List<List<int>> lapTime = timer.lapTime;
    final List<int> lapTimeType2 = flatten(lapTime);

    print('lapTime $lapTime');
    print('lapTimeType2 $lapTimeType2');

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          elevation: 0,
          automaticallyImplyLeading: false,
          leading: GestureDetector(
            onTap: () async {
              LinkedHashMap<DateTime, List<Event>> events =
                  await getData(SqliteDayTime());
              print(events);
              if (!context.mounted) return;
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SecondCalendar(events: events)));
            },
            child: const Icon(
              Icons.calendar_month_rounded,
              color: Colors.black,
            ),
          ),
          actions: [
            // 이건 이제 설정 탭으로
            //   IconButton(
            //       onPressed: (){
            //         if (logFormat == 'basic'){
            //           setState(() {
            //             logFormat = 'new';
            //           });
            //         } else {
            //           setState(() {
            //             logFormat = 'basic';
            //           });
            //         }
            //       }
            //       , icon: Icon(Icons.emoji_emotions_outlined)
            //   ),
            //   FutureBuilder<bool>(
            //     future: _future,
            //     builder: (context, snapshot) {
            //       if (snapshot.hasData && snapshot.data == true) {
            //         return IconButton(
            //             onPressed: () {
            //               Navigator.push(
            //                   context,
            //                   MaterialPageRoute(
            //                       builder: (context) => const PrivacySettingPage()));
            //             },
            //             icon: const Icon(Icons.privacy_tip_rounded));
            //       } else {
            //         return const SizedBox();
            //       }
            //     },
            //   ),
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingPage()));
                },
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black,
                )),
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.black,
              ),
              onPressed: () {
                // show dialog no log
                if (timer.lapTime.length == 0) {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: const Text(
                        '진통 기록 초기화',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      content: const Text('진통 기록을 모두 삭제하시겠습니까?',
                          style: TextStyle(
                              fontSize: 13.5, color: Color(0xFF7C7A7A))),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          style: TextButton.styleFrom(foregroundColor: color4),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            timer.resetTimerVoid();
                            timer.check_y(0);
                            Navigator.pop(context, 'OK');
                          },
                          style: TextButton.styleFrom(foregroundColor: color4),
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
                      surfaceTintColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      title: const Text(
                        '진통 기록 초기화',
                        style: TextStyle(fontSize: 17),
                      ),
                      content: const Text('진통 기록을 모두 삭제하시겠습니까?',
                          style: TextStyle(
                              fontSize: 13.5, color: Color(0xFF7C7A7A))),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, 'Cancel');
                          },
                          style: TextButton.styleFrom(foregroundColor: color4),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            timer.resetTimer();
                            timer.check_y(0);
                            Navigator.pop(context, 'OK');
                          },
                          style: TextButton.styleFrom(foregroundColor: color4),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
          backgroundColor: color1,
        ),
        body: (logFormat == 'basic')
            ?
            // 기본 화면
            basicMyMainPageBody(
                timer,
                lapTime,
                _scrollController,
                _banner,
              )
            :
            // 신규 화면
            connectingMyMainPageBody(
                timer,
                lapTimeType2,
                _scrollController,
                context,
                _banner,
              ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment(
                  Alignment.bottomCenter.x, Alignment.bottomCenter.y - 0.16),
              child: Container(
                height: 65,
                width: 250,
                child: FloatingActionButton.extended(
                  heroTag: "btn1",
                  label: Text(
                    timer.hurt ? '진통 멈춤' : '진통 시작',
                    style: const TextStyle(fontSize: 23, color: color5),
                  ),
                  elevation: 0,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  backgroundColor: timer.hurt ? color2 : color3,
                  hoverColor: Colors.orange,
                  hoverElevation: 50,
                  onPressed: () {
                    // print(timer.minWarning);
                    if (timer.hurt) {
                      timer.gonehurt();
                    } else {
                      // service.startService();
                      timer.starthurt();

                      // 잠시 중지 for new page test
                      // if (logFormat=='basic'){
                      _scrollToTop();
                      // }
                      // 최근 3회 평균 진통 주기가 5분 미만 일 경우 알람
                      if ((timer.lapTime.length >= 3) &&
                          (timer.lapTime
                                  .sublist(0, 3)
                                  .map((m) => m[2])
                                  .average
                                  .floor() <
                              60 * timer.minWarning)) {
                        // String minWarning_tmp = timer.minWarning.toString();
                        timer.check_y(1);
                        showDialog<String>(
                            context: context,
                            builder: (BuildContext context) {
                              return CustomAlertDialog(
                                title: Container(
                                  height: 100.0,
                                  width: 100.0,
                                  child: const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Image(
                                        image: AssetImage(
                                            'assets/appIcon/easydeliveryAppicon6'
                                            '.png')),
                                  ),
                                ),
                                description: Container(
                                  height: 80,
                                  child: Column(
                                    children: [
                                      const Text(
                                        '엄마 저를 만나러 오세요!',
                                        style: TextStyle(
                                            fontSize: 17.5, height: 0.7),
                                      ),
                                      const SizedBox(
                                        height: 3.0,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0.0, 10.0, 0.0, 0.0),
                                            child: Text(
                                              timer.isFirst
                                                  ? '평균 주기가 10분 미만이니'
                                                  : '평균 주기가 5분 미만이니',
                                              style: const TextStyle(
                                                  fontSize: 12.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            '병원으로 출발하세요',
                                            style: TextStyle(fontSize: 12.0),
                                          ),
                                          SizedBox(
                                              height: 11.0,
                                              width: 17,
                                              child: Image(
                                                  image: AssetImage(
                                                      'assets/icons8-siren-100.png'))),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                      }
                    }
                  },
                ),
              ),
            ),
            Align(
              alignment: Alignment(Alignment.bottomRight.x - 0.11,
                  Alignment.bottomRight.y - 0.18),
              child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {
                    showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          if (timer.isFirst) {
                            return AlertDialog(
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text(
                                '초산으로 바꾸시겠습니까?',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              content: const Text('초산은 5분 미만입니다',
                                  style: TextStyle(
                                      fontSize: 13.5,
                                      color: Color(0xFF7C7A7A))),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: color4),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    timer.firstOrNot();
                                    Navigator.pop(context, 'OK');
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: color4),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          } else {
                            return AlertDialog(
                              // backgroundColor:Colors.white,
                              surfaceTintColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              title: const Text(
                                '경산으로 바꾸시겠습니까?',
                                style: TextStyle(
                                    fontSize: 17, color: Colors.black),
                              ),
                              content: const Text(
                                '경산은 10분 미만입니다',
                                style: TextStyle(
                                    fontSize: 13.5, color: Color(0xFF7C7A7A)),
                              ),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, 'Cancel');
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: color4),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    timer.firstOrNot();
                                    Navigator.pop(context, 'OK');
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: color4),
                                  child: const Text('OK'),
                                ),
                              ],
                            );
                          }
                        });
                  },
                  backgroundColor: color1,
                  foregroundColor: color4,
                  mini: true,
                  tooltip: '초산 경산 여부',
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Text(
                    timer.isFirst ? '경산' : '초산',
                    style: const TextStyle(fontSize: 13),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
