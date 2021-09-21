import 'dart:convert';

import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/models/poke_api.dart';

class PokeApiController extends GetxController {
  RxList<Pokemon> pokeList = <Pokemon>[].obs;

  @override
  void onInit() {
    fetchPokemonList();
    super.onInit();
  }

  Future<void> fetchPokemonList() async {
    final pokeApi = await getPokeApi();
    pokeList.value = pokeApi.pokemon;
  }

  Future<dynamic> getPokeApi() async {
    try {
      final response = await http.get(Uri.parse(ConstantsApp.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeApi.fromJson(decodeJson);
      }
      return null;
    } on Exception {
      return null;
    }
  }
}
