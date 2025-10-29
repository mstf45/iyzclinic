import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefsHelper {
  // --- Save / Get (JSON map)
  static Future<void> saveData(String key, Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(data));
  }

  static Future<Map<String, dynamic>?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(key);
    if (jsonString == null) return null;
    try {
      final decoded = jsonDecode(jsonString);
      if (decoded is Map<String, dynamic>) return decoded;
      return null;
    } catch (_) {
      return null;
    }
  }

  // --- Primitive setters/getters
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  static Future<void> setString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  static Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // --- Remove single key
  static Future<void> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  // --- Clear all (kök temizleme)
  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // --- Kullanıcıya özel temizleme: sadece ilgili kullanıcı verilerini siler
  //     (isLoggedIn, userType, patient, doctor)
  static Future<void> clearUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userType = prefs.getString('userType');

    await prefs.remove('isLoggedIn');
    await prefs.remove('userType');

    if (userType == 'doctor') {
      await prefs.remove('doctor');
    } else if (userType == 'patient') {
      await prefs.remove('patient');
    } else {
      // Eğer userType belli değilse hem patient hem doctor'ı temizle (güvenlik)
      await prefs.remove('patient');
      await prefs.remove('doctor');
    }
  }
}
