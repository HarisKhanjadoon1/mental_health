import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  late SharedPreferences _preferences;
  late Locale _locale;
  Map<String, String>? _localizedStrings;

  LanguageProvider() {
    _initPreferences();
  }
  String getSelectedLanguageCode() {
    return _preferences.getString('language_code') ?? 'en'; // Default to 'en' if not found
  }

  Locale get locale => _locale;
  set locale(Locale value) {
    if (_locale != value) {
      _locale = value;
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString('language_code', value.languageCode);
      }).then((value) {
        _loadTranslations();
      }).then((value) {
        notifyListeners();
      });
    }
  }

  Locale get currentLocale => _locale; // New getter to return the current locale

  Future<void> _initPreferences() async {
    _preferences = await SharedPreferences.getInstance();
    String? savedLocale = _preferences.getString('language_code');
    _locale = Locale(savedLocale ?? 'en'); // Initialize with a default value if not present
    _loadTranslations();
    notifyListeners();
  }

  // Define a callback function
  VoidCallback? _onLanguageChangeCallback;

  // Set the callback function
  void setLanguageChangeCallback(VoidCallback callback) {
    _onLanguageChangeCallback = callback;
  }

  void changeLanguage(String newLanguage) {
    locale = Locale(newLanguage);
    notifyListeners(); // Notify listeners of the change

    // Call the callback function when the language changes
    _onLanguageChangeCallback?.call();
  }

  String translate(String key) {
    return _localizedStrings?[key] ?? key;
  }

  Future<void> _loadTranslations() async {
    String jsonString =
    await rootBundle.loadString('assets/i18n/${_locale.languageCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedStrings =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    print(
        "rebuild in ===> ${_locale.languageCode};");
  }
}
