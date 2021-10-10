import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/poke_api_service.dart';

class PokeHomeController extends GetxController {
  RxList<Pokemon> pokeList = <Pokemon>[].obs;
  RxBool isLoading = true.obs;
  RxList<Pokemon> filterPokeList = <Pokemon>[].obs;
  Client client = Client();
  TextEditingController textEditingController = TextEditingController();
  RxBool notFoundPokemon = false.obs;
  RxInt selectedIndex = 0.obs;
  RxBool isSearch = true.obs;

  @override
  void onInit() {
    fetchPokemonList();
    super.onInit();
  }

  @override
  void onClose() {
    textEditingController.dispose();
    super.onClose();
  }

  Future<void> fetchPokemonList() async {
    await PokeApiService(client).getPokemon().then((pokeApi) {
      if (pokeApi != null) {
        pokeList.value = pokeApi.pokemon;
        filterPokeList.addAll(pokeList);
      } else {
        Get.defaultDialog<Future<dynamic>>(
          barrierDismissible: false,
          onWillPop: () async {
            await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
            return false;
          },
          title: 'pokeHomeNoConnectionTitle'.tr,
          middleText: 'pokeHomeNoConnectionDescription'.tr,
        );
      }
      isLoading.value = false;
    });
  }

  void filterPokemon(Pokemon pokemon) {
    filterPokeList
      ..clear()
      ..add(pokemon);
    selectedIndex.value = 0;
  }

  void changeFilter(int index, String filter) {
    selectedIndex.value = index;
    isSearch.value = true;

    if (index == 0) {
      filterPokeList
        ..clear()
        ..addAll(pokeList);
    } else {
      List<Pokemon> listPokemon = [];

      if ('languageCode'.tr == 'en') {
        listPokemon = pokeList
            .where((Pokemon content) =>
                content.type.en[0]
                    .toLowerCase()
                    .startsWith(filter.toLowerCase()) ||
                content.type.en.length > 1 &&
                    content.type.en[1]
                        .toLowerCase()
                        .startsWith(filter.toLowerCase()))
            .toList();
      } else {
        listPokemon = pokeList
            .where((Pokemon content) =>
                content.type.ptBr[0]
                    .toLowerCase()
                    .startsWith(filter.toLowerCase()) ||
                content.type.ptBr.length > 1 &&
                    content.type.ptBr[1]
                        .toLowerCase()
                        .startsWith(filter.toLowerCase()))
            .toList();
      }

      filterPokeList
        ..clear()
        ..addAll(listPokemon);
    }
  }
}
