import 'package:get/state_manager.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/services/poke_api_service.dart';

class PokeApiController extends GetxController {
  RxList<Pokemon> pokeList = <Pokemon>[].obs;

  @override
  void onInit() {
    fetchPokemonList();
    super.onInit();
  }

  Future<void> fetchPokemonList() async {
    final pokeApi = await PokeApiService().getPokeApi();
    pokeList.value = pokeApi.pokemon;
  }
}
