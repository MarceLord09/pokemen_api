import 'dart:convert';

import 'package:pokemen_api/core/services/http_service.dart' show HttpService;
import 'package:pokemen_api/models/pokemon.dart';

class PokemonRepository {
  final HttpService httpService;

  PokemonRepository(this.httpService);

  Future<Pokemon?> getPokemon(String name) async {
    final response = await httpService.get('pokemon/$name');

    if (response.statusCode == 200) {
      final pokemon = Pokemon.fromJson(jsonDecode(response.body));
      return pokemon;
    } else {
      throw Exception('Failed to load Pokemon');
    }
  }
}
