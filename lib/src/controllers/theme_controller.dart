import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/services/theme_service.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;
  ThemeService themeService = ThemeService();

  @override
  void onInit() {
    isDarkMode.value = themeService.theme == ThemeMode.dark
        ? !isDarkMode.value
        : isDarkMode.value;
    super.onInit();
  }

  void changeThemeMode() {
    isDarkMode.value = !isDarkMode.value;
    themeService
      ..isDarkMode = isDarkMode.value
      ..switchTheme();
  }
}
