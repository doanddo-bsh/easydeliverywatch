import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';
import '../module/sqliteDayTime.dart';
import 'dart:convert';
// import 'thirdDetail.dart';
import 'package:intl/intl.dart';
import '../module/udf.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../module/color_def.dart';
import 'thirdDetail.dart';


class SecondCalendar extends StatefulWidget {

  final LinkedHashMap<DateTime,List<Event>> events;
  const SecondCalendar({required this.events, Key? key}) : super(key: key);

  @override
  State<SecondCalendar> createState() => _SecondCalendarState();
}

class _SecondCalendarState extends State<SecondCalendar> {

  final CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  final DateTime _todayDay = DateTime.now();
  DateTime? _selectedDay;
  final _model = SqliteDayTime();

  late final ValueNotifier<List<Event>> _selectedEvents =
  ValueNotifier(
      widget.events[DateTime.utc(_focusedDay.year, _focusedDay
          .month, _focusedDay.day)] ?? []
  );


  @override
  void initState(){
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return widget.events[day] ?? [];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        // print(_selectedDay);
        // print(_focusedDay);
      });
      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  String timeStringToDatetime(String stringTime){
    var parsedDate = DateTime.parse(stringTime);
    // 24h to ampm
    var ampmDate = DateFormat('hh:mm a').format(parsedDate);
    return ampmDate;
  }

  String secToMinSec(String secAll){
    var secInt = json.decode(secAll).cast<int>().toList().fold(0, (a, b)
    => a + b);
    var secMS = secToText(secInt);
    return secMS;
  }

  List<List<int>> StringToLLI(String laptimeString){
    List<int> laptimeListAll = json.decode(laptimeString).cast<int>().toList();
    int intforeach = (laptimeListAll.length/2).toInt();
    final tmpList = List<int>.generate(intforeach, (int index) => index * 2);

    List<List<int>> laptime = [];

    for (var value in tmpList){
      laptime.add([laptimeListAll[value],laptimeListAll[value+1]]);
    }

    return laptime;
  }

  String hurtCount(String secAll){
    var secInt = json.decode(secAll).cast<int>().toList();
    var hurtCnt = (secInt.length/2).toInt();
    return hurtCnt.toString();
  }

  // static const IconData trash = IconData(0xf4c4, fontFamily: iconFont, fontPackage: iconFontPackage);

  @override
  Widget build(BuildContext context) {

    // Admob admob = Admob(context: context);
    // BannerAd banner = admob.getBanner(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('진통 기록'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.home_rounded,  // add custom icons also
            ),
          ),
          // title: Text('second page'),
          elevation: 0,
          backgroundColor : color1,
          foregroundColor : Theme.of(context).colorScheme.onBackground,
        ),
        body: SafeArea(
            child: Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 1, 1),
                  lastDay: DateTime.utc(2100, 12, 31),
                  locale: 'ko_KR', // 추가
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  headerStyle:const HeaderStyle(formatButtonVisible: false), // 2weeks invisable
                  calendarStyle:CalendarStyle(
                    markerSize: 5.5,
                    markersMaxCount: 3,
                    selectedDecoration: BoxDecoration(
                      color: isSameDay(_selectedDay, _todayDay)? color3:color8,
                      shape: BoxShape.circle,
                    ),
                    todayDecoration: const BoxDecoration(
                      color: color3,
                      shape: BoxShape.circle,
                    ),
                  ),
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: _getEventsForDay,
                  onDaySelected: _onDaySelected,
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
                const SizedBox(height: 6.0),
                Expanded(
                  child: ValueListenableBuilder<List<Event>>(
                    valueListenable: _selectedEvents,
                    builder: (context, value, _) {
                      return ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, idx) {
                          return InkWell(
                            onTap: (){
                              // print('test');
                              Navigator.push(context, MaterialPageRoute(builder:
                                  (context) => ThirdDetail(
                                theDate:value[idx].startDateTime,
                                startTime:timeStringToDatetime(value[idx].startDateTime),
                                wholeHurtTime:secToMinSec(value[idx].sec_all),
                                hurtCount:hurtCount(value[idx].sec_all),
                                hurtInterval:hurtAvgFncCalendar(StringToLLI(value[idx].sec_all)),
                                hurtRecodeAll:StringToLLI(value[idx].sec_all),
                              )));
                            },
                            child: Container(
                              alignment: Alignment.centerLeft,
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 5.0,
                              ),
                              decoration: BoxDecoration(
                                color: color9,
                                // border: Border.all(),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(10.0,3.0,3.0,3.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children : [
                                    Row(
                                        children:[
                                          Expanded(
                                            child:
                                            Padding(
                                              padding: const EdgeInsets.fromLTRB(4.0,1.0,4.0,4.0),
                                              child: Column(
                                                children: [
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: (value[idx].checkYn == 1)?
                                                    Row(children: [
                                                      Text(timeStringToDatetime(value[idx].startDateTime)
                                                          ,textAlign: TextAlign.start
                                                          ,style: const TextStyle(color: color4
                                                              ,height:1.6
                                                              ,fontSize:14.0
                                                              ,fontWeight: FontWeight.bold
                                                          )
                                                      ),
                                                      Container(
                                                          height: 15,
                                                          width: 15,
                                                          child: const Padding(
                                                            padding: EdgeInsets
                                                                .fromLTRB(4.0, 0, 0,
                                                                1.5),
                                                            child: Image(image:
                                                            AssetImage('assets/icons8-siren-100.png')),
                                                          )
                                                      )
                                                    ]
                                                    )
                                                        :
                                                    Text(timeStringToDatetime(value[idx].startDateTime)
                                                        ,textAlign: TextAlign.start
                                                        ,style: const TextStyle(color: color4
                                                            ,height:1.6
                                                            ,fontSize:14.0
                                                            ,fontWeight: FontWeight.bold
                                                        )
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('총 진통시간 ${secToMinSec(value[idx].sec_all)}'
                                                      ,style: const TextStyle(color: color4
                                                          ,height:1.4),
                                                    ),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text(hurtAvgFncCalendar(StringToLLI(value[idx].sec_all))
                                                      ,style: const TextStyle(color: color4),),
                                                  ),
                                                  Align(
                                                    alignment: Alignment.centerLeft,
                                                    child: Text('진통 횟수 : '
                                                        '${hurtCount
                                                      (value[idx].sec_all)}회'
                                                      ,style: const TextStyle(color: color4
                                                          ,height:1.4),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon:const Icon(Icons.cancel_outlined
                                              ,size: 18
                                              ,color: color4,),
                                            onPressed: (){

                                              showDialog<String>(
                                                context: context,
                                                builder: (BuildContext context) => AlertDialog(
                                                  title: const Text('진통 기록 삭제'),
                                                  content: const Text('해당 진통 기록을 '
                                                      '삭제하시겠습니까?'),
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
                                                        // print(value[idx].iteration);
                                                        _model.timeDelete(
                                                            value[idx].iteration
                                                        );
                                                        setState(() {
                                                          widget.events[DateTime.utc(_focusedDay.year, _focusedDay
                                                              .month, _focusedDay.day)]?.removeWhere(
                                                                  (item) => item.iteration == value[idx].iteration
                                                          )
                                                          ;
                                                        });
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
                                          ),
                                        ]
                                    ),

                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
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


