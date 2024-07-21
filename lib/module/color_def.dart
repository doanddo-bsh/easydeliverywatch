import 'package:flutter/material.dart';

// color define
// color1
// 시간초 화면 윗부분
// 시간초 화면 listtile 왼쪽 숫자 동그라미 배경
// 초산 경산 버튼
// 진통 기록 페이지 앱바 백그라운드
// 디테일 기록 보기 페이지 윗부분 앱바 및 기록 배경
// 디테일 기록 보기 페이지 아래 listtile 왼쪽 숫자 동그라미 배경
const Color color1 = Color(0xFFF6E6E4);  // 3=>1
const Color color2 = Color(0xFFE2BCB7);
const Color color3 = Color(0xFFCA8A8B); // 5=>3
const Color color4 = Color(0xFF7C7A7A); //전반 적인 글씨색 (연한 회색) ( 6 => 4)
const Color color5 = Color(0xFF692929); //가장 큰 진통 시간 글씨색
const Color color6 = Color(0xFFFFc98b); // 1=>6안씀...
const Color color7 = Color(0xFFFFb284); // 2=> 7 안씀
const Color color8 = Color(0xFFE3E0E0); // 다 른 날을 표시하는 동그라미 색깔 4=>8
const Color color9 = Color(0xFFEEEDED); //아래칸 색깔 =>7=>9
const Color color10 = Colors.white70 ; // basic listtile container color
Color color11 = Colors.grey[400] ?? Colors.grey; // basic divider

const Color color1Dark = Color(0xFF201A19);  // 3=>1



Color getColorFinal(context, colorLight, colorBlack){
  final ThemeData theme = Theme.of(context);

  Color colorFianl =  theme.brightness == Brightness.dark
      ? colorBlack // 다크 모드에서의 화살표 색상
      : colorLight; // 라이트 모드에서의 화살표 색상
  return colorFianl;
}
