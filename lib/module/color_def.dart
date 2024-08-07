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
const Color color12 = Colors.white ;
const Color color13 = Colors.black ;
const Color color14 = color2 ;
const Color color15 = color3 ;
const Color color16 = Color(0xffffffff);


const Color color1Dark = Color(0xFF201A19);
const Color color2Dark = Colors.grey;
const Color color3Dark = Colors.white;
const Color color4Dark = Colors.white;
const Color color5Dark = Colors.grey;
Color color8Dark = Colors.grey[700] ?? Colors.grey ;
const Color color9Dark = Colors.black54;

const Color color10Dark = Color(0xFF201A19);
const Color color11Dark = color4;
const Color color12Dark = color4;
const Color color13Dark = Colors.white ;
Color color14Dark = Colors.grey[300] ?? Colors.grey ;
const Color color15Dark = Colors.grey;
Color color16Dark = Colors.grey[300] ?? Colors.grey ;



Color getColorFinal(context, colorLight, colorBlack){
  final ThemeData theme = Theme.of(context);

  Color colorFianl =  theme.brightness == Brightness.dark
      ? colorBlack // 다크 모드에서의 색상
      : colorLight; // 라이트 모드에서의 색상
  return colorFianl;
}
