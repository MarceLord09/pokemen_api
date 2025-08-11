import 'package:flutter/material.dart';
import 'package:pokemen_api/core/services/http_service.dart';
import 'package:pokemen_api/models/pokemon.dart';
import 'package:pokemen_api/repositories/pokemon_repository.dart';

class PokemonViewmodel extends ChangeNotifier {
  final PokemonRepository _pokemonRepository = PokemonRepository(HttpService());
  Pokemon _pokemon = Pokemon();
  bool _isLoading = false;
  String _error = "";

  Pokemon get pokemon => _pokemon;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchPokemon(String name) async {
    _isLoading = true;
    _error = "";
    notifyListeners();

    try {
      final pokemon = await _pokemonRepository.getPokemon(name);
      _pokemon = pokemon ?? Pokemon();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
