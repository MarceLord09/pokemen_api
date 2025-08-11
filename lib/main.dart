import 'package:flutter/material.dart';
import 'package:pokemen_api/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PokemonViewmodel(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: PokemonViewScreen(),
      ),
    );
  }
}

class PokemonViewScreen extends StatefulWidget {
  const PokemonViewScreen({super.key});

  @override
  State<PokemonViewScreen> createState() => _PokemonViewScreenState();
}

class _PokemonViewScreenState extends State<PokemonViewScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final viewmodel = Provider.of<PokemonViewmodel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Viewer')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            spacing: 12,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Ingresa tu pokémon',
                  border: OutlineInputBorder(),
                ),
                controller: _controller,
              ),
              ElevatedButton(
                onPressed: () {
                  viewmodel.fetchPokemon(_controller.text);
                },
                child: const Text('Buscar'),
              ),
              if (viewmodel.isLoading)
                const CircularProgressIndicator()
              else if (viewmodel.error.isNotEmpty)
                Column(
                  spacing: 15,
                  children: [
                    Icon(Icons.not_listed_location_sharp, size: 90),
                    Text('No encontramos el pokemon'),
                  ],
                )
              else if (viewmodel.pokemon.name != null)
                Column(
                  children: [
                    Text(
                      '${viewmodel.pokemon.name}',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Image.network(
                      viewmodel.pokemon.sprites?.frontdefault ?? '',
                      scale: 0.5,
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
