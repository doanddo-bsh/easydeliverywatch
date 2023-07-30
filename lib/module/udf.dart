import 'dart:collection';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';
import '../module/sqliteDayTime.dart';

// getData
Future<LinkedHashMap<DateTime,List<Event>>> getData(model) async {
  final events = LinkedHashMap<DateTime,List<Event>>(
    equals: isSameDay,
  );
  // events 에 db 값 입력
  var model_select_all = await model.timeSelect();
  for (var item in model_select_all) {
    // print('${item.No} - ${item.Thedaytime} / ${item.Timelist}');

    int y_int = int.parse(item.Thedaytime.substring(0, 4));
    int m_int = int.parse(item.Thedaytime.substring(5, 7));
    int d_int = int.parse(item.Thedaytime.substring(8, 10));

    DateTime temp_key = DateTime.utc(y_int, m_int, d_int);

    if (events.containsKey(temp_key)) {
      events[temp_key]!.add(Event(
          iteration: item.No,
          startDateTime: item.Thedaytime,
          sec_all:item.Timelist,
          checkYn: item.CheckYn
      ));
    } else {
      events[temp_key] = [Event(
        iteration: item.No,
        startDateTime: item.Thedaytime,
        sec_all:item.Timelist,
        checkYn: item.CheckYn,
      )];
    }
  }
  return events;
}


// 초를 시분초로 변경하는 함수
String secToText(int sec){

  late String secTextFormat ;

  int hour = ((sec ~/ 60) ~/ 60);
  int mint = (sec ~/ 60);
  int send = sec % 60;

  if ((send < 10)&(hour == 0)){
    secTextFormat = '$mint:0$send';
  } else if ((send >= 10)&(hour == 0)){
    secTextFormat = '$mint:$send';
  } else if ((send < 10)&(mint < 10)&(hour != 0)){
    secTextFormat = '$hour:0$mint:0$send';
  } else if ((send >= 10)&(mint < 10)&(hour != 0)){
    secTextFormat = '$hour:0$mint:$send';
  } else if ((send < 10)&(mint >= 10)&(hour != 0)){
    secTextFormat = '$hour:$mint:0$send';
  } else {
    secTextFormat = '$hour:$mint:$send';
  }

  return secTextFormat;
}

// 진통 회수, 진통 간격 display format 변경
String hurtAvgFnc(List<List<int>> laptime){

  late String hurtAvg ;

  String hurtAvg_basic = '3회 진통 간격';
  if (laptime.isEmpty){
    hurtAvg = '전체 진통 회수 0  |  $hurtAvg_basic 00:00';
  } else if (laptime.length <= 3) {
    hurtAvg = '전체 진통 회수 ${laptime.length.toString()}  |  '
        '$hurtAvg_basic '
        '${secToText(laptime.map(
            (m) => m[2]).toList().average.floor())
    }';
  } else {
    hurtAvg = '전체 진통 회수 ${laptime.length.toString()}  |  $hurtAvg_basic '
        '${secToText(laptime
        .sublist(0,3).map((m) => m[2]).average.floor())}';
  }
  return hurtAvg;
}

// 진통 회수, 진통 간격 display format 변경 한글 변경
String hurtAvgFncCalendar(List<List<int>> laptime){

  late String hurtAvg ;

  String hurtAvg_basic = '진통 간격';
  if (laptime.isEmpty){
    hurtAvg = '$hurtAvg_basic 00:00';
  } else if (laptime.length <= 3) {
    hurtAvg = '$hurtAvg_basic ${secToText(laptime.map(
            (m) => m[0]+m[1]).toList().average.floor())
    }';
  } else {
    hurtAvg = '$hurtAvg_basic ${secToText(laptime
        .sublist(0,3).map((m) => m[0]+m[1]).average.floor())
    }';
  }
  return hurtAvg;
}