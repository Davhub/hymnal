import 'package:shared_preferences/shared_preferences.dart';

class SettingsService {
  static const String _isDarkModeKey = 'isDarkMode';
  static const String _textSizeKey = 'textSize';
  static const String _showDailyHymnKey = 'showDailyHymn';
  static const String _enableNotificationsKey = 'enableNotifications';
  static const String _autoPlayKey = 'autoPlay';

  static SharedPreferences? _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // Dark Mode
  static bool get isDarkMode => _prefs?.getBool(_isDarkModeKey) ?? false;
  static Future<void> setDarkMode(bool value) async {
    await _prefs?.setBool(_isDarkModeKey, value);
  }

  // Text Size
  static double get textSize => _prefs?.getDouble(_textSizeKey) ?? 16.0;
  static Future<void> setTextSize(double value) async {
    await _prefs?.setDouble(_textSizeKey, value);
  }

  // Show Daily Hymn
  static bool get showDailyHymn => _prefs?.getBool(_showDailyHymnKey) ?? true;
  static Future<void> setShowDailyHymn(bool value) async {
    await _prefs?.setBool(_showDailyHymnKey, value);
  }

  // Enable Notifications
  static bool get enableNotifications => _prefs?.getBool(_enableNotificationsKey) ?? true;
  static Future<void> setEnableNotifications(bool value) async {
    await _prefs?.setBool(_enableNotificationsKey, value);
  }

  // Auto Play
  static bool get autoPlay => _prefs?.getBool(_autoPlayKey) ?? false;
  static Future<void> setAutoPlay(bool value) async {
    await _prefs?.setBool(_autoPlayKey, value);
  }
}