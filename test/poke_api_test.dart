import 'package:flutter_test/flutter_test.dart';
import 'package:pokedex/src/models/poke_api.dart';
import 'package:pokedex/src/stores/poke_api_store.dart';

void main() {
  final PokeApiStore pokeApiStore = PokeApiStore();
  test('Get a list of pokemons', () async {
    await pokeApiStore.fetchPokemonList();
    final PokeApi? pokeApi = pokeApiStore.pokeApi;

    expect(pokeApi!.pokemon.isNotEmpty, equals(true));
    expect(pokeApi.pokemon.first.name, equals('Bulbasaur'));
  });
}
