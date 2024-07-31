import 'package:flutter/material.dart';

// color define
// color1
// 시간초 화면 윗부분
// 시간초 화면 listtile 왼쪽 숫자 동그라미 배경
// 초산 경산 버튼
// 진통 기록 페이지 앱바 백그라운드
// 디테일 기록 보기 페이지 윗부분 앱바 및 기록 배경
// 디테일 기록 보기 페이지 아래 listtile 왼쪽 숫자 동그라미 배경
const Color color1 = Color(0xFFF6E6E4);
const Color color2 = Color(0xFFE2BCB7);
const Color color3 = Color(0xFFCA8A8B);
const Color color4 = Color(0xFF7C7A7A);
const Color color5 = Color(0xFF692929);
const Color color6 = Color(0xFFFFc98b);
const Color color7 = Color(0xFFFFb284);
const Color color8 = Color(0xFFE3E0E0);
const Color color9 = Color(0xFFEEEDED);
const Color color10 = Colors.white70 ;
Color color11 = Colors.grey[400] ?? Colors.grey;

const Color color1Dark = Color(0xFF201A19);





Color getColorFinal(context, colorLight, colorBlack){
  final ThemeData theme = Theme.of(context);

  Color colorFianl =  theme.brightness == Brightness.dark
      ? colorBlack // 다크 모드에서의 화살표 색상
      : colorLight; // 라이트 모드에서의 화살표 색상
  return colorFianl;
}
