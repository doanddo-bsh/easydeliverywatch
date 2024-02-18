import 'package:flutter/material.dart';
import 'dart:async';
import '../module/sqliteDayTime.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

final _model = SqliteDayTime();

class TimerModule with ChangeNotifier{

  String _theDayTime = '';
  bool _isRunning = false;
  bool _hurt = false ;
  int _secs = 0;
  int _secsHurt = 0;
  int _cnt = 0;
  Timer? _timer;
  final List<List<int>> _lapTime = [];
  final List<int> _lapTime_type2 = [];
  int _check5MinYn = 0 ;
  bool _isFirst = false;
  int _minWarning = 5;
  DateTime _startTime = DateTime.now();

  String get theDayTime => _theDayTime;
  bool get isRunning => _isRunning;
  bool get hurt => _hurt;
  int get seconds => _secs;
  int get secondsHurt => _secsHurt;
  int get cnt => _cnt;
  List<List<int>> get lapTime => _lapTime;
  List<int> get lapTime_type2 => _lapTime_type2;
  int get check5MinYn => _check5MinYn ;
  bool get isFirst => _isFirst;
  int get minWarning => _minWarning;
  DateTime get startTime => _startTime;

  set secondsSet(int secondsinput) {
    int secsTemp = _secs ;
    _secs = secsTemp + secondsinput;
    notifyListeners();
  }

  // 진통 시작
  void starthurt(
      // int secFromStream
      ) async {
    if (_cnt != 0){
      // print('starthurt _secsHurt $_secsHurt');
      // print('starthurt _secs $_secs');
      _lapTime.insert(
          0,
          [_secsHurt, _secs - _secsHurt, _secs] // _secs_hurt 진통 시간, 휴식 시간, 총 시간
      //     [25+21*60+3*60*60, (1+17*60+22*60*60),
      // 1+17*60+22*60*60 + (25+21*60+3*60*60)] //
        // _secs_hurt 진통 시간, 휴식
        // 시간,
        // 총 시간

      );

      lapTime_type2.insert(0, _secs);

      print(_lapTime);
      print('lapTime_type2 $lapTime_type2');
    }
    // print('starthurt _lapTime $_lapTime');
    _secs = 0;
    _isRunning = true;
    _hurt = true;

    _startTime = DateTime.now();

    if (_cnt == 0){
      _theDayTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());
      _timer = Timer.periodic(const Duration(seconds:1), (Timer t) {
        // _secs ++;
        DateTime _targetTime = DateTime.now();
        final datetimediff = _targetTime.difference(_startTime);
        // test
        _secs = datetimediff.inSeconds ;
        // print('이게 먼저 되나보지? $_secs');
        // _secs = 25*60+35;
        // print(_secs);
        // print(_startTime);
        // print(_targetTime);
        notifyListeners();
      });
    }


    _cnt ++;
  }

  void gonehurt(){
    _hurt = false;
    // _secs = 25*60*2+35;
    _secsHurt = _secs;

    lapTime_type2.insert(0, _secsHurt);
    print('lapTime_type2 $lapTime_type2');
  }

  void resetTimer() async {
    // save log to db
    if (_theDayTime != ''){

      print('resetTimer ${lapTime}');

      String step3Sv = listToString(lapTime);
      await _model.timeInsert(DaytimeModel(
        Thedaytime: _theDayTime,
        Timelist: step3Sv,
        CheckYn: _check5MinYn,
      ));
    }

    _theDayTime = '';
    _timer?.cancel();
    _secs = 0;
    _isRunning = false;
    _lapTime.clear();
    notifyListeners();

    _cnt = 0;
    _hurt = false;
  }

  void resetTimerVoid() async {
    // save log to db
    // if (_theDayTime != ''){
    //   String step3Sv = listToString(lapTime);
    //   await _model.timeInsert(DaytimeModel(
    //     Thedaytime: _theDayTime,
    //     Timelist: step3Sv,
    //     CheckYn: _check5MinYn,
    //   ));
    // }

    _theDayTime = '';
    _timer?.cancel();
    _secs = 0;
    _isRunning = false;
    _lapTime.clear();
    notifyListeners();

    _cnt = 0;
    _hurt = false;
  }

  void check_y(int n_0_1){
    _check5MinYn = n_0_1;
  }

  String listToString(List<List<int>> laptime){
    var step1 = laptime.map((e){
      return e.sublist(0,2);
    });
    var step2 = step1.expand((i) => i).toList();
    String step3Sv = jsonEncode(step2);
    return step3Sv;
  }

  List stringToList(String step3Sv){
    List step4Dc = json.decode(step3Sv).toList();
    return step4Dc;
  }

  void firstOrNot() {
    if (!_isFirst) {
      _minWarning = 10;
    } else {
      _minWarning = 5;
    }
    _isFirst = !_isFirst;
    notifyListeners();
  }

}