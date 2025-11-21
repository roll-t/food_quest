import 'dart:convert';

import 'package:food_quest/core/config/const/app_logger.dart';
import 'package:food_quest/core/config/theme/app_color_scheme.dart';
import 'package:food_quest/core/lang/translation_service.dart';
import 'package:food_quest/features/user/data/model/user_model.dart'; // import model
import 'package:get_storage/get_storage.dart';

class AppGetStorage {
  static final GetStorage _box = GetStorage();

  // ========== Init ========== //
  static Future<void> init() async {
    await GetStorage.init();
  }

  // ========== Keys ========== //
  static const String _themeKey = 'isDarkMode';
  static const String _tokenKey = 'accessToken';
  static const String _userKey = 'userData'; // ✅ thêm key user
  static const String _isLoggedIn = 'isLoggedIn';
  static const String _selectedLanguageKey = 'selected_language';
  static const String _primaryThemeKey = 'primary_theme';
  static const String _isNotificationEnabled = 'isNotificationEnabled';

  // ========== Theme ========== //
  static void saveTheme(bool isDark) => _box.write(_themeKey, isDark);
  static bool getTheme() => _box.read(_themeKey) ?? false;

  static void savePrimaryTheme(AppColorTheme theme) => _box.write(_primaryThemeKey, theme.toString());

  static AppColorTheme getPrimaryTheme(AppColorTheme fallback) {
    final themeString = _box.read<String>(_primaryThemeKey);
    if (themeString != null) {
      return AppColorTheme.values.firstWhere(
        (e) => e.toString() == themeString,
        orElse: () => fallback,
      );
    }
    return fallback;
  }

  static void setNotificationEnabled(bool value) => _box.write(_isNotificationEnabled, value);

  static bool isNotificationEnabled() => _box.read(_isNotificationEnabled) ?? true;

  // ========== Token ========== //
  static void saveToken(String token) => _box.write(_tokenKey, token);
  static String? getToken() => _box.read(_tokenKey);

  // ========== User ========== //
  static void saveUser(UserModel user) {
    final jsonString = jsonEncode(user.toJson());
    _box.write(_userKey, jsonString);
  }

  static UserModel? getUser() {
    final jsonString = _box.read<String>(_userKey);
    if (jsonString != null) {
      final Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return UserModel.fromJson(jsonMap);
    }
    return null;
  }

  // ========== Login ========== //
  static void setLoggedIn(bool value) => _box.write(_isLoggedIn, value);

  static bool isLoggedIn() {
    return _box.read(_tokenKey) != null;
  }

  static void clearAuth() {
    _box.remove(_tokenKey);
    _box.remove(_userKey);
  }

  // ========== Language ========== //
  static void setLanguage(String language) {
    _box.write(_selectedLanguageKey, language);
    LocalizationService.changeLocale(language == 'English' ? 'en' : 'vi');
  }

  static String getLanguage() {
    return _box.read(_selectedLanguageKey) ?? 'English';
  }

  // ========== Custom Data ========== //
  static void write<T>(String key, T value) => _box.write(key, value);
  static T? read<T>(String key) => _box.read<T>(key);
  static void remove(String key) => _box.remove(key);
  static void clear() => _box.erase();

  // ========== Control size ========== //
  static int estimateCacheSize() {
    List<String> keys = _box.getKeys().toList();
    int totalSize = 0;

    for (String key in keys) {
      var value = _box.read(key);
      if (value is String) {
        totalSize += utf8.encode(value).length;
      } else if (value is int) {
        totalSize += 4;
      } else if (value is double) {
        totalSize += 8;
      } else if (value is bool) {
        totalSize += 1;
      } else {
        totalSize += utf8.encode(value.toString()).length;
      }
    }
    return totalSize;
  }

  static void printCacheSize() {
    int cacheSizeInBytes = estimateCacheSize();
    double cacheSizeInMB = cacheSizeInBytes / (1024 * 1024);
    AppLogger.i("Kích thước bộ nhớ cache: ${cacheSizeInMB.toStringAsFixed(2)} MB");
  }
}
