import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_api_controller.dart';

void main() {
  final PokeApiController pokeApiController = Get.put(PokeApiController());
  test('Get pokemon list', () async {
    await pokeApiController.fetchPokemonList();
    final pokeList = pokeApiController.pokeList;
    expect(pokeList.isNotEmpty, equals(true));
  });

  test('Get Bulbasaur name in the first pokemon list object', () async {
    await pokeApiController.fetchPokemonList();
    final pokeList = pokeApiController.pokeList;
    expect(pokeList.first.name, equals('Bulbasaur'));
  });
}
