abstract class PokemonEvent {}

class PokemonPageRequest extends PokemonEvent {
  final int page;
  PokemonPageRequest({required this.page});
}

class PokemonPageFailed extends PokemonEvent {
  final Object err;
  PokemonPageFailed({required this.err});
}
