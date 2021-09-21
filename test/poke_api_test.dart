import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_api_controller.dart';

void main() {
  final PokeApiController pokeApiController = Get.put(PokeApiController());
  test('Get a list of pokemons', () async {
    await pokeApiController.fetchPokemonList();
    final pokeList = pokeApiController.pokeList;
    expect(pokeList.isNotEmpty, equals(true));
  });

  test('Match the first name on the list', () async {
    await pokeApiController.fetchPokemonList();
    final pokeList = pokeApiController.pokeList;
    expect(pokeList.first.name, equals('Bulbasaur'));
  });
}
