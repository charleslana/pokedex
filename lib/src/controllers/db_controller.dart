import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/db_service.dart';

class DBController extends GetxController {
  final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
  DBService dbService = DBService();
  RxList<Pokemon> favoriteList = <Pokemon>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    removeFavorite(1);
    removeFavorite(151);
    addFavorite(1);
    addFavorite(151);
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

  Future<void> addFavorite(int pokemonId) async {
    await dbService.insert({'pokemon_id': pokemonId});

    favoriteList.addAll(pokeHomeController.pokeList
        .where((Pokemon content) => content.id == pokemonId)
        .toList());
  }

  Future<void> removeFavorite(int pokemonId) async {
    await dbService.remove(pokemonId);

    favoriteList.removeWhere((Pokemon content) => content.id == pokemonId);
  }
}
