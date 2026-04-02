import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  final String _key = "theme_mode";

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadFromPrefs();
  }

  void toggleTheme(bool isDark) async {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_key, isDark ? 1 : 0);
  }

  void _loadFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    int? savedTheme = prefs.getInt(_key);
    
    if (savedTheme != null) {
      _themeMode = (savedTheme == 1) ? ThemeMode.dark : ThemeMode.light;
      notifyListeners();
    }
  }
}