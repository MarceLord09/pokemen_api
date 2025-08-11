import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pokemen_api/viewmodels/pokemon_state.dart';
import 'package:pokemen_api/viewmodels/pokemon_viewmodel.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
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
              Consumer<PokemonViewmodel>(
                builder: (context, viewmodel, child) {
                  final pokemon = viewmodel.state.pokemon;
                  final status = viewmodel.state;

                  switch (status.status) {
                    case LoadStatus.initial:
                      return const Text('Ingresa un Pokémon para comenzar.');
                    case LoadStatus.loading:
                      return const CircularProgressIndicator();
                    case LoadStatus.success:
                      if (pokemon != null) {
                        return Column(
                          children: [
                            Text(
                              '${pokemon.name ?? ""}',
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (pokemon.sprites?.frontdefault != null)
                              Image.network(
                                pokemon.sprites!.frontdefault,
                                scale: 0.5,
                              ),
                          ],
                        );
                      } else {
                        return Column(
                          children: [
                            Icon(Icons.error, color: Colors.red, size: 48),
                            Text(viewmodel.state.error),
                          ],
                        );
                      }
                    case LoadStatus.error:
                      return Column(
                        children: [
                          Icon(Icons.error, color: Colors.red, size: 48),
                          Text(status.error),
                        ],
                      );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
