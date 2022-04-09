import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pokemons/src/bloc/pokemon_events.dart';
import 'package:pokemons/src/bloc/pokemon_state.dart';
import 'package:pokemons/src/repositories/repositories.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final _pokemonRepository = PokemonRepository();
  PokemonBloc() : super(PokemonInitial()) {
    on<PokemonPageRequest>((event, emit) async {
      // emit(PokemonLoadInProgress());
      final pokemonPageResponse =
          await _pokemonRepository.getPokemonPage(event.page);
      print(pokemonPageResponse);
      try {
        emit(PokemonPageLoadSuccess(
            pokemonListings: pokemonPageResponse.pokemonListings,
            canLoadNextPage: pokemonPageResponse.canLoadNextPage));
      } catch (e) {
        emit(PokemonPageLoadFailed(error: e));
      }
    });
  }
}
