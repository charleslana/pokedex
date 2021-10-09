import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LanguageService {
  final GetStorage _box = GetStorage();
  final String _key = 'languageCode';

  Locale? get locale =>
      _loadLanguageFromBox() != null ? Locale(_loadLanguageFromBox()!) : null;

  String? _loadLanguageFromBox() => _box.read(_key);

  void _saveLanguageToBox(String languageCode) =>
      _box.write(_key, languageCode);

  void changeLanguage(Locale locale) {
    Get.updateLocale(locale);
    _saveLanguageToBox(locale.languageCode);
  }
}
