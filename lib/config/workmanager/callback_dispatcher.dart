
import 'package:workmanager/workmanager.dart';

import '../../infrastructure/infrastructure.dart';

const fetchBackgroundTaskKey = 'com.alfredodiaz.miscelaneos.fetch-background-pokemon';
const fetchPeriodicBackgroundTaskKey = 'com.alfredodiaz.miscelaneos.fetch-background-pokemon';

@pragma('vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {

    switch ( task ){

      case fetchBackgroundTaskKey:
        await loadNextPokemon();
      break;

      case fetchPeriodicBackgroundTaskKey:
        await loadNextPokemon();
      break;

      case Workmanager.iOSBackgroundTask:
        print('Workmanager.iOSBackgroundTask');
        break;

    }

    return true;



    // print("Native: called background task: $task"); //simpleTask will be emitted here.
    // return Future.value(true);
  });
}

Future loadNextPokemon() async {

  final localDbRepository = LocalDbRepositoryImpl();
  final pokemonRepository = PokemonsRepositoryImpl();

  final lastPokemonId = await localDbRepository.pokemonCount() + 1;

  try {

    final (pokemon, message) = await pokemonRepository.getPokemon('$lastPokemonId');
    if( pokemon == null ) throw message;
    await localDbRepository.insertPokemon(pokemon);
    print('Pokemon inserted: ${ pokemon.name } !!');

  } catch (e) {

    print('error: $e');

  }

}