import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class PokeDetailsController extends GetxController {
  final RxInt _index = 0.obs;
  Rx<PageController> pageController = PageController().obs;

  int get index => _index.value;

  set index(int value) {
    _index.value = value;
    pageController.value = PageController(initialPage: value);
  }
}
