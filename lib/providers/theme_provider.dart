import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  static const String _themeKey = 'isDarkMode';

  ThemeProvider() {
    _loadTheme();
  }

  bool get isDarkMode => _isDarkMode;

  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: const Color(0xFFF5F5F7),
        primaryColor: const Color(0xFF7C3AED),
        colorScheme: ColorScheme.light(
          primary: const Color(0xFF7C3AED),
          secondary: const Color(0xFF34D399),
          surface: Colors.white,
          background: const Color(0xFFF5F5F7),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Color(0xFF1F2937),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: Colors.white,
        ),
      );

  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF0F172A),
        primaryColor: const Color(0xFF8B5CF6),
        colorScheme: ColorScheme.dark(
          primary: const Color(0xFF8B5CF6),
          secondary: const Color(0xFF14B8A6),
          surface: const Color(0xFF1E293B),
          background: const Color(0xFF0F172A),
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: const Color(0xFF1E293B),
        ),
      );

  ThemeData get currentTheme => _isDarkMode ? darkTheme : lightTheme;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
    await _saveTheme();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveTheme() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
  }
}