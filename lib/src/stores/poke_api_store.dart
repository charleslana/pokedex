import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:pokedex/src/constants/constants_app.dart';
import 'package:pokedex/src/models/poke_api.dart';
part 'poke_api_store.g.dart';

class PokeApiStore = _PokeApiStoreBase with _$PokeApiStore;

abstract class _PokeApiStoreBase with Store {
  @observable
  PokeApi? pokeApi;

  @action
  Future<void> fetchPokemonList() async {
    final pokeList = await getPokeApi();
    pokeApi = pokeList;
  }

  Future<PokeApi> getPokeApi() async {
    try {
      final response = await http.get(Uri.parse(ConstantsApp.baseURL));
      if (response.statusCode == 200) {
        final dynamic decodeJson = jsonDecode(response.body);
        return PokeApi.fromJson(decodeJson);
      }
      throw Exception('Response status was not 200.');
    } on Exception catch (error) {
      throw Exception('Error finding url $error');
    }
  }
}
