import 'package:flutter/material.dart';
import 'package:pokemen_api/core/services/http_service.dart';

import 'package:pokemen_api/repositories/pokemon_repository.dart';
import 'package:pokemen_api/viewmodels/pokemon_state.dart';

class PokemonViewmodel extends ChangeNotifier {
  final PokemonRepository _pokemonRepository = PokemonRepository(HttpService());
  PokemonState _state = PokemonState();

  PokemonState get state => _state;

  Future<void> fetchPokemon(String name) async {
    _state = _state.copyWith(
      status: LoadStatus.loading,
      error: "",
      pokemon: null,
    );
    notifyListeners();

    try {
      final pokemon = await _pokemonRepository.getPokemon(name);
      _state = _state.copyWith(status: LoadStatus.success, pokemon: pokemon);
    } catch (e) {
      _state = _state.copyWith(status: LoadStatus.error, error: e.toString());
    } finally {
      notifyListeners();
    }
  }
}
