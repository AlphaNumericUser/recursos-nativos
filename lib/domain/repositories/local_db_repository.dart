import '../domain.dart';

abstract class LocalDbRepository{

  Future<List<Pokemon>> loadPokemons();

  Future<int> pokemonCount();

  Future<void> insertPokemon( Pokemon pokemon );

}