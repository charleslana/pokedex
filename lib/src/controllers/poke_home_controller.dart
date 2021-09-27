import 'package:get/state_manager.dart';
import 'package:http/http.dart';
import 'package:pokedex/src/models/poke_model.dart';
import 'package:pokedex/src/services/poke_api_service.dart';

class PokeHomeController extends GetxController {
  RxList<Pokemon> pokeList = <Pokemon>[].obs;

  Client client = Client();

  @override
  void onInit() {
    fetchPokemonList();
    super.onInit();
  }

  Future<void> fetchPokemonList() async {
    final PokeModel pokeModel = await PokeApiService(client).getPokemon();
    pokeList.value = pokeModel.pokemon;
  }
}
