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
    final pokeList = await loadPokeApi();
    pokeApi = pokeList;
  }

  Future<dynamic> loadPokeApi() async {
    try {
      final response = await http.get(Uri.parse(ConstantsApp.baseURL));
      final dynamic decodeJson = jsonDecode(response.body);
      return PokeApi.fromJson(decodeJson);
    } on Exception catch (error) {
      print('Ocorreu um erro: $error');
      return null;
    }
  }
}
