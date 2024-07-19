import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  void toggleThemeMode() {
    print('현재 모드 $themeMode');
    print('함수가 되기는 하나?');
    if (_themeMode == ThemeMode.light) {
      print('현재 모드 $themeMode');
      print('light to dark');
      _themeMode = ThemeMode.dark;
    } else if (_themeMode == ThemeMode.dark) {
      print('현재 모드 $themeMode');
      print('dark to light');
      _themeMode = ThemeMode.light;
    } else {
      print('현재 모드 $themeMode');
      print('to light');
      _themeMode = ThemeMode.light;
    }
    notifyListeners();
  }
}
