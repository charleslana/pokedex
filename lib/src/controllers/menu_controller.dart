import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  RxString selectedLanguage = Get.locale!.languageCode.obs;
  RxInt selectedIndex = 0.obs;

  void changeLanguage(String language, int index) {
    selectedIndex.value = index;
    final Locale locale = Locale(language);
    Get.updateLocale(locale);
    selectedLanguage.value = language;
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(0);
    if (selectedLanguage.value == 'en' || selectedLanguage.value == 'en_US') {
      selectedIndex.value = 0;
    } else {
      selectedIndex.value = 1;
    }
    super.onInit();
  }
}
