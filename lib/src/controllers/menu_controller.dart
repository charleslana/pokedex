import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MenuController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  RxString selectedLanguage = Get.locale!.languageCode.obs;
  RxList<bool> selected = [false, false].obs;

  void changeLanguage(String language, int index) {
    selected.value = [false, false];
    selected[index] = true;
    final Locale locale = Locale(language);
    Get.updateLocale(locale);
    selectedLanguage.value = language;
  }

  @override
  void onInit() {
    tabController = TabController(length: 3, vsync: this);
    tabController.animateTo(0);
    if (selectedLanguage.value == 'en' || selectedLanguage.value == 'en_US') {
      selected[0] = true;
    } else {
      selected[1] = true;
    }
    super.onInit();
  }
}
