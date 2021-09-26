import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class PokeDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final RxInt _index = 0.obs;
  Rx<PageController> pageController = PageController().obs;
  late AnimationController animationController;
  RxDouble progress = 0.0.obs;
  RxDouble opacity = 1.0.obs;
  RxDouble opacityAppBarTitle = 0.0.obs;

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
    pageController.value = PageController(
      initialPage: value,
      viewportFraction: 0.6,
    );
  }

  double _interval(double lower, double upper, double progress) {
    assert(lower < upper);

    if (progress > upper) {
      return 1;
    }
    if (progress < lower) {
      return 0;
    }

    return (progress - lower) / (upper - lower).clamp(0, 1);
  }

  void changeSlidingSheet(dynamic state) {
    progress.value = state.progress;
    opacity.value = 1 - _interval(0, 0.6, progress.value);
    opacityAppBarTitle.value = _interval(0.55, 0.8, progress.value);
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
