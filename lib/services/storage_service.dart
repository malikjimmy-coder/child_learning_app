// lib/services/storage_service.dart
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class StorageService {
  static SharedPreferences? _prefs;

  /// Initialize storage
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  /// Get SharedPreferences instance
  static SharedPreferences get instance {
    if (_prefs == null) {
      throw Exception('StorageService not initialized. Call init() first.');
    }
    return _prefs!;
  }

  // ============ String Operations ============

  /// Save string
  static Future<bool> saveString(String key, String value) async {
    return await instance.setString(key, value);
  }

  /// Get string
  static String? getString(String key) {
    return instance.getString(key);
  }

  // ============ Integer Operations ============

  /// Save integer
  static Future<bool> saveInt(String key, int value) async {
    return await instance.setInt(key, value);
  }

  /// Get integer
  static int? getInt(String key) {
    return instance.getInt(key);
  }

  // ============ Boolean Operations ============

  /// Save boolean
  static Future<bool> saveBool(String key, bool value) async {
    return await instance.setBool(key, value);
  }

  /// Get boolean
  static bool? getBool(String key) {
    return instance.getBool(key);
  }

  // ============ Double Operations ============

  /// Save double
  static Future<bool> saveDouble(String key, double value) async {
    return await instance.setDouble(key, value);
  }

  /// Get double
  static double? getDouble(String key) {
    return instance.getDouble(key);
  }

  // ============ List Operations ============

  /// Save string list
  static Future<bool> saveStringList(String key, List<String> value) async {
    return await instance.setStringList(key, value);
  }

  /// Get string list
  static List<String>? getStringList(String key) {
    return instance.getStringList(key);
  }

  // ============ JSON Operations ============

  /// Save JSON object
  static Future<bool> saveJson(String key, Map<String, dynamic> json) async {
    final jsonString = jsonEncode(json);
    return await saveString(key, jsonString);
  }

  /// Get JSON object
  static Map<String, dynamic>? getJson(String key) {
    final jsonString = getString(key);
    if (jsonString == null) return null;

    try {
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (e) {
      print('Error decoding JSON: $e');
      return null;
    }
  }

  // ============ Remove & Clear Operations ============

  /// Remove specific key
  static Future<bool> remove(String key) async {
    return await instance.remove(key);
  }

  /// Clear all data
  static Future<bool> clearAll() async {
    return await instance.clear();
  }

  /// Check if key exists
  static bool containsKey(String key) {
    return instance.containsKey(key);
  }

  /// Get all keys
  static Set<String> getAllKeys() {
    return instance.getKeys();
  }

  // ============ Specialized Methods ============

  /// Save user progress
  static Future<bool> saveUserProgress(Map<String, dynamic> progress) async {
    return await saveJson('user_progress', progress);
  }

  /// Get user progress
  static Map<String, dynamic>? getUserProgress() {
    return getJson('user_progress');
  }

  /// Save lesson progress
  static Future<bool> saveLessonProgress(Map<String, dynamic> progress) async {
    return await saveJson('lesson_progress', progress);
  }

  /// Get lesson progress
  static Map<String, dynamic>? getLessonProgress() {
    return getJson('lesson_progress');
  }

  /// Save app settings
  static Future<bool> saveSettings(Map<String, dynamic> settings) async {
    return await saveJson('app_settings', settings);
  }

  /// Get app settings
  static Map<String, dynamic>? getSettings() {
    return getJson('app_settings');
  }
}