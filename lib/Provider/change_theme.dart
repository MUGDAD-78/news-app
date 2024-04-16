import 'package:flutter/material.dart';
import 'package:news_app/constant/themes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTheme with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData get themeData => _themeData;

ChangeTheme(bool isDark)
{
  if (isDark) {
    _themeData = darkTheme;
  }
  else { 
    _themeData = lightTheme;
  }
}
  void changeTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_themeData == lightTheme) {
      _themeData = darkTheme;
      prefs.setBool("is_dark", true);
    } else {
      _themeData = lightTheme;
      prefs.setBool("is_dark", false);
    }
    notifyListeners();
  }
}
//    changeTheme(ThemeData value) {
//     ThemeData currentTheme = value;
//     if (currentTheme == lightTheme) {
//       currentTheme = darkTheme;
//     } else {
//       currentTheme = darkTheme;
//     }
//   }
// notifyListeners();