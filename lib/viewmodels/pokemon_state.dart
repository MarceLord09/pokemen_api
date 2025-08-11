import 'package:pokemen_api/models/pokemon.dart';

enum LoadStatus { initial, loading, success, error }

class PokemonState {
  final LoadStatus status;
  final Pokemon? pokemon;
  final String error;

  PokemonState({
    this.status = LoadStatus.initial,
    this.pokemon,
    this.error = '',
  });

  PokemonState copyWith({LoadStatus? status, Pokemon? pokemon, String? error}) {
    return PokemonState(
      status: status ?? this.status,
      pokemon: pokemon ?? this.pokemon,
      error: error ?? this.error,
    );
  }
}
