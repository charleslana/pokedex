import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PokeAnimatedController extends GetxController
    with SingleGetTickerProviderMixin {
  late AnimationController animationController;

  @override
  void onInit() {
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat();
    super.onInit();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
