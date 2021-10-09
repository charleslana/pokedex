import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/services/language_service.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  RxString selectedLanguage = Get.locale!.languageCode.obs;
  RxInt selectedIndex = 0.obs;
  LanguageService languageService = LanguageService();

  void changeLanguage(String language, int index) {
    selectedIndex.value = index;
    languageService.changeLanguage(Locale(language));
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(0);
    selectedLanguage.value = languageService.locale == null
        ? selectedLanguage.value
        : languageService.locale!.languageCode;

    if (selectedLanguage.value == 'en' || selectedLanguage.value == 'en_US') {
      selectedIndex.value = 0;
    } else {
      selectedIndex.value = 1;
    }
    super.onInit();
  }
}
