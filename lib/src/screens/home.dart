import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/src/bloc/pokemon_bloc.dart';
import 'package:pokemons/src/bloc/pokemon_state.dart';

class Pokedex extends StatefulWidget {
  const Pokedex({Key? key}) : super(key: key);
  @override
  State<Pokedex> createState() => _PokedexState();
}

class _PokedexState extends State<Pokedex> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pokedex"),
      ),
      body: BlocBuilder<PokemonBloc, PokemonState>(builder: (context, state) {
        if (state is PokemonLoadInProgress) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is PokemonPageLoadSuccess) {
          return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1.5),
              itemCount: state.pokemonListings.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green,
                  child: Stack(children: [
                    Image.asset(
                      "assets/images/pokeball.png",
                      height: 100,
                      fit: BoxFit.fitHeight,
                    ),
                    Column(children: [
                      Image.network(state.pokemonListings[index].imageUrl),
                      Text(
                        state.pokemonListings[index].name,
                        style: const TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ]),
                  ]),
                );
              });
        } else if (state is PokemonPageLoadFailed) {
          return Center(
            child: Text(state.error.toString()),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}
