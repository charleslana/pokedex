import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/db_controller.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/best_poke_model.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

class PokeDetailsController extends GetxController
    with SingleGetTickerProviderMixin {
  final int? arguments = Get.arguments;
  final RxInt _index = 0.obs;
  Rx<PageController> pageController = PageController().obs;
  RxDouble progress = 0.0.obs;
  RxDouble opacity = 1.0.obs;
  RxDouble opacityAppBarTitle = 0.0.obs;
  SheetController sheetController = SheetController();
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
  RxList<BestPokeModel> toCompareList = <BestPokeModel>[].obs;

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

  double comparePokemon(Pokemon pokemon, Pokemon target) {
    final int targePokemonType = target.type.en.length;

    final List<dynamic> pokemonResistant = pokemon.resistant.en
        .where((String element) =>
            element == target.type.en[0] ||
            target.type.en.length > 1 && element == target.type.en[1])
        .toList();

    final List<dynamic> pokemonWeaknesses = pokemon.weaknesses.en
        .where((String element) =>
            element == target.type.en[0] ||
            target.type.en.length > 1 && element == target.type.en[1])
        .toList();

    final int pokemonComum =
        targePokemonType - pokemonResistant.length - pokemonWeaknesses.length;

    final double pokemonVulnerability =
        pokemonWeaknesses.length.toDouble() * 2 +
            pokemonComum +
            pokemonResistant.length * 0.5;

    final double pokemonEffectiveValue = pokemon.maxCp.toDouble() *
        pokemon.maxCp.toDouble() /
        pokemonVulnerability;

    return pokemonEffectiveValue;
  }

  void toComparePokemon(Pokemon pokemon, Pokemon target) {
    final double pokemonEffectiveValue = comparePokemon(pokemon, target);
    final double targetPokemonEffectiveValue = comparePokemon(target, pokemon);

    chancePokemon.value = chanceComparePokemon(
        pokemonEffectiveValue, targetPokemonEffectiveValue);

    chanceTargetPokemon.value = chanceComparePokemon(
        targetPokemonEffectiveValue, pokemonEffectiveValue);

    targetPokemon.value = target;
    isVisible.value = true;
  }

  double chanceComparePokemon(
      double pokemonEffectiveValue, double targetPokemonEffectiveValue) {
    return pokemonEffectiveValue /
        (pokemonEffectiveValue + targetPokemonEffectiveValue) *
        100;
  }

  void toComparePokemonAll(Pokemon pokemon, List<Pokemon> pokeList) {
    final List<BestPokeModel> reversedList = [];
    toCompareList.clear();

    for (final poke in pokeList) {
      if (poke != targetPokemon.value) {
        final double pokemonEffectiveValue = comparePokemon(pokemon, poke);
        final double targetPokemonEffectiveValue =
            comparePokemon(poke, pokemon);

        reversedList.add(BestPokeModel(
          poke.name,
          poke.img,
          chanceComparePokemon(
              pokemonEffectiveValue, targetPokemonEffectiveValue),
        ));
      }
    }

    reversedList.sort((BestPokeModel a, BestPokeModel b) =>
        a.percentage.compareTo(b.percentage));

    toCompareList.value = reversedList.reversed.toList();
  }
}
