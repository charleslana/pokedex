import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class PokeDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final RxInt _index = 0.obs;
  Rx<PageController> pageController = PageController().obs;
  late AnimationController animationController;

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
    pageController.value = PageController(initialPage: value);
  }

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
