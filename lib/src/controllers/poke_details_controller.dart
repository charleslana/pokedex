import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/db_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';

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
  final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
  late Rx<Pokemon> targetPokemon;
  TextEditingController textEditingController = TextEditingController();
  RxBool notFoundPokemon = false.obs;
  RxBool isSelected = true.obs;
  RxBool isVisible = false.obs;
  RxDouble chancePokemon = 0.0.obs;
  RxDouble chanceTargetPokemon = 0.0.obs;

  @override
  void onInit() {
    tabController = TabController(length: 6, vsync: this);
    tabController.animateTo(0);
    index = arguments ?? 0;
    initFavorite();
    targetPokemon = pokeHomeController.pokeList[index].obs;
    super.onInit();
  }

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

  void toComparePokemon(Pokemon pokemon) {
    if (pokemon.id == targetPokemon.value.id) {
      chancePokemon.value = 50;
      chanceTargetPokemon.value = 50;
    } else {
      const double maxScore = 3;
      double scorePokemon = 3;
      double scoreTargetPokemon = 3;

      if (pokemon.maxCp > targetPokemon.value.maxCp) {
        scoreTargetPokemon--;
      } else if (pokemon.maxCp < targetPokemon.value.maxCp) {
        scorePokemon--;
      }

      final List<dynamic> pokemonResistant = pokemon.resistant.en
          .where((String element) =>
              element == targetPokemon.value.type.en[0] ||
              targetPokemon.value.type.en.length > 1 &&
                  element == targetPokemon.value.type.en[1])
          .toList();

      if (pokemonResistant.isNotEmpty) {
        scoreTargetPokemon--;
      }

      final List<dynamic> targetPokemonResistant = targetPokemon
          .value.resistant.en
          .where((String element) =>
              element == pokemon.type.en[0] ||
              pokemon.type.en.length > 1 && element == pokemon.type.en[1])
          .toList();

      if (targetPokemonResistant.isNotEmpty) {
        scorePokemon--;
      }

      final List<dynamic> pokemonWeaknesses = pokemon.weaknesses.en
          .where((String element) =>
              element == targetPokemon.value.type.en[0] ||
              targetPokemon.value.type.en.length > 1 &&
                  element == targetPokemon.value.type.en[1])
          .toList();

      if (pokemonWeaknesses.isNotEmpty) {
        scorePokemon--;
      }

      final List<dynamic> targetPokemonWeaknesses = targetPokemon
          .value.weaknesses.en
          .where((String element) =>
              element == pokemon.type.en[0] ||
              pokemon.type.en.length > 1 && element == pokemon.type.en[1])
          .toList();

      if (targetPokemonWeaknesses.isNotEmpty) {
        scoreTargetPokemon--;
      }

      if (scorePokemon == scoreTargetPokemon) {
        chancePokemon.value = 50;
        chanceTargetPokemon.value = 50;
      } else {
        chancePokemon.value = scorePokemon * 100 / maxScore;
        chanceTargetPokemon.value = scoreTargetPokemon * 100 / maxScore;
      }
    }
    isVisible.value = true;
  }
}
