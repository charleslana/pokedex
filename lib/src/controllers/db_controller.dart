import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/db_service.dart';
import 'package:pokedex/src/services/theme_service.dart';

class DBController extends GetxController {
  final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
  DBService dbService = DBService();
  RxList<Pokemon> favoriteList = <Pokemon>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  Future<void> init() async {
    final dataList = await dbService.getData();
    final List<Pokemon> listPokemon = [];

    for (final data in dataList) {
      listPokemon.addAll(pokeHomeController.pokeList
          .where((Pokemon content) => content.id == data['pokemon_id'])
          .toList());
    }

    favoriteList
      ..clear()
      ..addAll(listPokemon);

    isLoading.value = false;
  }

  Future<List<Map<String, dynamic>>> findFavoriteById(int pokemonId) async {
    return dbService.getDataById(pokemonId);
  }

  Future<void> addFavorite(int pokemonId) async {
    final List<Map<String, dynamic>>? getDataById =
        await findFavoriteById(pokemonId);

    if (getDataById!.isEmpty) {
      await dbService.insert({'pokemon_id': pokemonId});

      favoriteList.addAll(pokeHomeController.pokeList
          .where((Pokemon content) => content.id == pokemonId)
          .toList());

      Get.snackbar<dynamic>(
        'favoritesSnackBarTitle'.tr,
        'favoritesSnackBarAdd'.tr,
        backgroundColor: ThemeService().theme == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        colorText: ThemeService().theme == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      await removeFavorite(pokemonId);

      Get.snackbar<dynamic>(
        'favoritesSnackBarTitle'.tr,
        'favoritesSnackBarRemove'.tr,
        backgroundColor: ThemeService().theme == ThemeMode.dark
            ? Colors.black
            : Colors.white,
        colorText: ThemeService().theme == ThemeMode.dark
            ? Colors.white
            : Colors.black,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> removeFavorite(int pokemonId) async {
    await dbService.remove(pokemonId);

    favoriteList.removeWhere((Pokemon content) => content.id == pokemonId);
  }
}
