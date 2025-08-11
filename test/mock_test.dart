import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:pokemen_api/core/services/http_service.dart';
import 'package:pokemen_api/repositories/pokemon_repository.dart';

import 'mock_test.mocks.dart';

@GenerateMocks([HttpService])
void main() {
  group("PokemonRepository", () {
    final url = 'https://pokeapi.co/api/v2/pokemon/pikachu';
    test("Retornar Pokemon si http funciona correctamente", () async {
      final mockService = MockHttpService();
      when(
        mockService.get(url),
      ).thenAnswer((_) async => http.Response('{"name": "Pikachu"}', 200));
      final repository = PokemonRepository(mockService);
      final pokemon = await repository.getPokemon('pikachu');

      expect(pokemon, isNotNull);
      expect(pokemon?.name, 'Pikachu');
    });

    test("Lanzar una excepción si falla la llamada http", () async {
      final mockService = MockHttpService();
      when(
        mockService.get(url),
      ).thenAnswer((_) async => http.Response('Not Found', 404));
      final repository = PokemonRepository(mockService);
      expect(
        () async => await repository.getPokemon('pikachu'),
        throwsException,
      );
    });
  });
}
