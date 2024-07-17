import 'package:flutter/material.dart';
import 'dart:async';
import '../module/sqliteDayTime.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

final _model = SqliteDayTime();

class TimerModule with ChangeNotifier {
  String _theDayTime = '';
  bool _isRunning = false;
  bool _hurt = false;

  int _secs = 0;
  int _secsHurt = 0;
  int _cnt = 0;
  Timer? _timer;
  final List<List<int>> _lapTime = [];
  final List<int> _lapTime_type2 = [];
  int _check5MinYn = 0;

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

  int get check5MinYn => _check5MinYn;

  bool get isFirst => _isFirst;

  int get minWarning => _minWarning;

  DateTime get startTime => _startTime;

  set secondsSet(int secondsinput) {
    int secsTemp = _secs;
    _secs = secsTemp + secondsinput;
    notifyListeners();
  }

  // 진통 시작
  void starthurt() async {
    if (_cnt != 0) {
      _lapTime.insert(0,
          [_secsHurt, _secs - _secsHurt, _secs] // _secs_hurt 진통 시간, 휴식 시간, 총 시간
          );

      lapTime_type2.insert(0, _secs);

      // print(_lapTime);
      // print('lapTime_type2 $lapTime_type2');
    }

    _secs = 0;
    _isRunning = true;
    _hurt = true;

    _startTime = DateTime.now();

    if (_cnt == 0) {

      // key로 활용할 theday
      _theDayTime = DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now());

      // 이하 코드는 1초에 1번씩 돌아감
      // cnt가 0일때 해당 코드를 실행시킴
      _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        DateTime _targetTime = DateTime.now();
        final datetimediff = _targetTime.difference(_startTime);
        // 여기서 _secs seconds 를 정해놓음
        // _startTime이 변경되며 datetimediff이 변경됨
        _secs = datetimediff.inSeconds;
        notifyListeners();
      });

    }

    _cnt++;
  }

  void gonehurt() {
    _hurt = false;
    // _secs = 25*60*2+35;
    _secsHurt = _secs;

    lapTime_type2.insert(0, _secsHurt);
    // print('lapTime $lapTime');
    // print('lapTime_type2 $lapTime_type2');
  }

  void resetTimer() async {
    // save log to db
    if (_theDayTime != '') {
      // print('resetTimer ${lapTime}');

      // 저장하기 위해 변경
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
    // test
    lapTime_type2.clear();
    notifyListeners();

    _cnt = 0;
    _hurt = false;
  }

  void resetTimerVoid() async {

    _theDayTime = '';
    _timer?.cancel();
    _secs = 0;
    _isRunning = false;
    _lapTime.clear();
    // test
    lapTime_type2.clear();
    notifyListeners();

    _cnt = 0;
    _hurt = false;
  }

  void check_y(int n_0_1) {
    _check5MinYn = n_0_1;
  }

  String listToString(List<List<int>> laptime) {
    var step1 = laptime.map((e) {
      return e.sublist(0, 2);
    });
    var step2 = step1.expand((i) => i).toList();
    String step3Sv = jsonEncode(step2);
    return step3Sv;
  }

  List stringToList(String step3Sv) {
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
