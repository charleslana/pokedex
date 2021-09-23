import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:pokedex/src/controllers/poke_home_controller.dart';

void main() {
  final PokeHomeController pokeHomeController = Get.put(PokeHomeController());
  test('Get pokemon list', () async {
    await pokeHomeController.fetchPokemonList();
    final pokeList = pokeHomeController.pokeList;
    expect(pokeList.isNotEmpty, equals(true));
  });

  test('Get Bulbasaur name in the first pokemon list object', () async {
    await pokeHomeController.fetchPokemonList();
    final pokeList = pokeHomeController.pokeList;
    expect(pokeList.first.name, equals('Bulbasaur'));
  });
}
