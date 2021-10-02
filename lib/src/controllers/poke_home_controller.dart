import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/poke_api_service.dart';

class PokeHomeController extends GetxController {
  RxList<Pokemon> pokeList = <Pokemon>[].obs;
  RxBool isLoading = true.obs;
  RxList<Pokemon> filterPokeList = <Pokemon>[].obs;
  Client client = Client();

  @override
  void onInit() {
    fetchPokemonList();
    super.onInit();
  }

  Future<void> fetchPokemonList() async {
    await PokeApiService(client).getPokemon().then((pokeApi) {
      if (pokeApi != null) {
        pokeList.value = pokeApi.pokemon;
        filterPokeList.value = pokeApi.pokemon;
      } else {
        Get.defaultDialog<dynamic>(
          barrierDismissible: false,
          title: 'Error',
          middleText:
              'Failed connection to server.\nPlease check your internet connection.',
        );
      }
      isLoading.value = false;
    });
  }

  void filterPokemon(Pokemon pokemon) {
    filterPokeList
      ..clear()
      ..add(pokemon);
  }
}
