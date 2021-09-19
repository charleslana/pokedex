// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'poke_api_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$PokeApiStore on _PokeApiStoreBase, Store {
  final _$pokeApiAtom = Atom(name: '_PokeApiStoreBase.pokeApi');

  @override
  PokeApi? get pokeApi {
    _$pokeApiAtom.reportRead();
    return super.pokeApi;
  }

  @override
  set pokeApi(PokeApi? value) {
    _$pokeApiAtom.reportWrite(value, super.pokeApi, () {
      super.pokeApi = value;
    });
  }

  final _$fetchPokemonListAsyncAction =
      AsyncAction('_PokeApiStoreBase.fetchPokemonList');

  @override
  Future<void> fetchPokemonList() {
    return _$fetchPokemonListAsyncAction.run(() => super.fetchPokemonList());
  }

  final _$_PokeApiStoreBaseActionController =
      ActionController(name: '_PokeApiStoreBase');

  @override
  Pokemon getPokemon(int index) {
    final _$actionInfo = _$_PokeApiStoreBaseActionController.startAction(
        name: '_PokeApiStoreBase.getPokemon');
    try {
      return super.getPokemon(index);
    } finally {
      _$_PokeApiStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pokeApi: ${pokeApi}
    ''';
  }
}
