import 'package:flutter/material.dart';
import 'package:word_cloud/word_cloud.dart';
import 'package:word_cloud/word_cloud_data.dart';
import 'package:word_cloud/word_cloud_shape.dart';
import 'package:word_cloud/word_cloud_tap.dart';
import 'package:word_cloud/word_cloud_tap_view.dart';
import 'package:word_cloud/word_cloud_view.dart';


class WordCloud extends StatefulWidget {
  WordCloud({super.key});

  @override
  State<WordCloud> createState() => _WordCloudState();
}

class _WordCloudState extends State<WordCloud> {
  //example data list
  List<Map> word_list = [
    {'word': 'Apple', 'value': 100},
    {'word': 'Samsung', 'value': 60},
    {'word': 'Intel', 'value': 55},
    {'word': 'Tesla', 'value': 50},
    {'word': 'AMD', 'value': 40},
    {'word': 'Google', 'value': 35},
    {'word': 'Qualcom', 'value': 31},
    {'word': 'Netflix', 'value': 27},
    {'word': 'Meta', 'value': 27},
    {'word': 'Amazon', 'value': 26},
    {'word': 'Nvidia', 'value': 25},
    {'word': 'Microsoft', 'value': 25},
    {'word': 'TSMC', 'value': 24},
    {'word': 'PayPal', 'value': 24},
    {'word': 'AT&T', 'value': 24},
    {'word': 'Oracle', 'value': 23},
    {'word': 'Unity', 'value': 23},
    {'word': 'Roblox', 'value': 23},
    {'word': 'Lucid', 'value': 22},
    {'word': 'Naver', 'value': 20},
    {'word': 'Kakao', 'value': 18},
    {'word': 'NC Soft', 'value': 18},
    {'word': 'LG', 'value': 16},
    {'word': 'Hyundai', 'value': 16},
    {'word': 'KIA', 'value': 16},
    {'word': 'twitter', 'value': 16},
    {'word': 'Tencent', 'value': 15},
    {'word': 'Alibaba', 'value': 15},
    {'word': 'LG', 'value': 16},
    {'word': 'Hyundai', 'value': 16},
    {'word': 'KIA', 'value': 16},
    {'word': 'twitter', 'value': 16},
    {'word': 'Tencent', 'value': 15},
    {'word': 'Alibaba', 'value': 15},
    {'word': 'Disney', 'value': 14},
    {'word': 'Spotify', 'value': 14},
    {'word': 'Udemy', 'value': 13},
    {'word': 'Quizlet', 'value': 13},
    {'word': 'Visa', 'value': 12},
    {'word': 'Lucid', 'value': 22},
    {'word': 'Naver', 'value': 20},
    {'word': 'Hyundai', 'value': 16},
    {'word': 'KIA', 'value': 16},
    {'word': 'twitter', 'value': 16},
    {'word': 'Tencent', 'value': 15},
    {'word': 'Alibaba', 'value': 15},
    {'word': 'Disney', 'value': 14},
    {'word': 'Spotify', 'value': 14},
    {'word': 'Visa', 'value': 12},
    {'word': 'Microsoft', 'value': 10},
    {'word': 'TSMC', 'value': 10},
    {'word': 'PayPal', 'value': 24},
    {'word': 'AT&T', 'value': 10},
    {'word': 'Oracle', 'value': 10},
    {'word': 'Unity', 'value': 10},
    {'word': 'Roblox', 'value': 10},
    {'word': 'Lucid', 'value': 10},
    {'word': 'Naver', 'value': 10},
    {'word': 'Kakao', 'value': 18},
    {'word': 'NC Soft', 'value': 18},
    {'word': 'LG', 'value': 16},
    {'word': 'Hyundai', 'value': 16},
    {'word': 'KIA', 'value': 16},
    {'word': 'twitter', 'value': 16},
    {'word': 'Tencent', 'value': 10},
    {'word': 'Alibaba', 'value': 10},
    {'word': 'Disney', 'value': 14},
    {'word': 'Spotify', 'value': 14},
    {'word': 'Udemy', 'value': 13},
    {'word': 'NC Soft', 'value': 12},
    {'word': 'LG', 'value': 16},
    {'word': 'Hyundai', 'value': 10},
    {'word': 'KIA', 'value': 16},
  ];



  int count = 0;
  String wordstring = '';

  List<Map> data_list= [
    {'word': 'Apple','value': 100},
    {'word': 'Samsung','value': 60},
  ];

  @override
  Widget build(BuildContext context) {

    List<Map> hurt_word_cloud_test = [
      {'word': '사랑이', 'value': 100},
      {'word': '고마워', 'value': 60},
      {'word': '사랑해', 'value': 55},
      {'word': '아기야', 'value': 50},
      {'word': '엄마', 'value': 40},
      {'word': '아빠', 'value': 35},
      {'word': '많이', 'value': 31},
      {'word': '사랑해', 'value': 27},
      {'word': '23/08/04', 'value': 40},
      {'word': '23/08/05', 'value': 26},
      {'word': '23/08/07', 'value': 25},
      {'word': '23/08/09', 'value': 30},
      {'word': '23/08/10', 'value': 24},
      {'word': '진통 횟수 6회', 'value': 35},
      {'word': '평균 주기 5.5분', 'value': 20},
      {'word': '23/08/09 14:00', 'value': 63},
      {'word': '사랑해', 'value': 16},
    ];

    List<Map> grList = List.filled(30, hurt_word_cloud_test[16], growable :
    true);
    print(hurt_word_cloud_test+grList);

    List<Map> hwct = hurt_word_cloud_test+grList;

    WordCloudData wcdata = WordCloudData(data: word_list);
    WordCloudTap wordtaps = WordCloudTap();

    WordCloudData mydata = WordCloudData(data: data_list);

    WordCloudData h_test = WordCloudData(data: hwct);

    return Scaffold(
      // backgroundColor: Color(0xFFE2BCB7),
      appBar: AppBar(title: Text('word cloud test'),),
      body:Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                  SizedBox(
                    height: 15,
                    width:30,
                  ),
                  WordCloudView(
                    data: h_test,
                    // mapcolor: Color.fromARGB(255, 174, 183, 235),
                    mapwidth: 350,
                    mapheight: 500,
                    mintextsize: 10,
                    maxtextsize: 70,
                    // fontWeight: FontWeight.bold,
                    // colorlist: [Colors.black87],
                    colorlist: [Colors.black, Colors.redAccent, Colors.indigoAccent],
                    // shape: WordCloudEllipse(majoraxis: 250, minoraxis: 200),
                  ),
                ],
              ),
            ),
        );
  }
}