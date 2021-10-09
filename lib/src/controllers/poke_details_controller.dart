import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/db_controller.dart';

class PokeDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final int? arguments = Get.arguments;
  final RxInt _index = 0.obs;
  Rx<PageController> pageController = PageController().obs;
  RxDouble progress = 0.0.obs;
  RxDouble opacity = 1.0.obs;
  RxDouble opacityAppBarTitle = 0.0.obs;
  late TabController tabController;
  final DBController dbController = Get.put(DBController());
  RxBool isFavorite = false.obs;

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

  void changeSlidingSheet(double stateProgress) {
    progress.value = stateProgress;
    opacity.value = 1 - _interval(0, 0.6, progress.value);
    opacityAppBarTitle.value = _interval(0.55, 0.8, progress.value);
  }

  Future<void> initFavorite() async {
    final findFavoriteById = await dbController.findFavoriteById(index + 1);

    if (findFavoriteById.isNotEmpty) {
      isFavorite.value = true;
    } else {
      isFavorite.value = false;
    }

    if (Get.isSnackbarOpen == true) {
      Get.back<dynamic>();
    }
  }

  Future<void> switchFavorite(int pokemonId) async {
    await dbController.addFavorite(pokemonId);
    isFavorite.value = !isFavorite.value;
  }

  @override
  void onInit() {
    tabController = TabController(length: 6, vsync: this);
    tabController.animateTo(0);
    index = arguments ?? 0;
    initFavorite();
    super.onInit();
  }
}
