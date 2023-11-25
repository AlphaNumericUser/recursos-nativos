
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/config/config.dart';
import 'package:workmanager/workmanager.dart';

class BackgroundFetchNotifier extends StateNotifier<bool?> {

  final String processKeyName;

  // ! Por defecto va a estar en false
  BackgroundFetchNotifier({
    required this.processKeyName
  }) :super(false) {
    checkCurrentStatus();
  }

  toggleProcess(){
    if( state == true ){
      deactivateProcess();
    } else {
      activateProcess();
    }
  }

  checkCurrentStatus() async {
    state = await SharePreferencesPlugin.getBool(processKeyName) ?? false;
  }

  activateProcess() async {
    // La primera vez es de inmediato
    await Workmanager().registerPeriodicTask(
      processKeyName, 
      processKeyName,
      frequency: const Duration(seconds: 10), // despues cada 15 minutos aprox
      constraints: Constraints(
        networkType: NetworkType.connected
      ),
      tag: processKeyName
    );

    await SharePreferencesPlugin.setBool(processKeyName, true);
    state =true;
  }

  deactivateProcess() async {
    await Workmanager().cancelByTag(processKeyName);
    await SharePreferencesPlugin.setBool(processKeyName, false);
    state = false;
  }

}

final backgroundPokemonFetchProvider = StateNotifierProvider<BackgroundFetchNotifier, bool?>((ref) {
  return BackgroundFetchNotifier(processKeyName: fetchPeriodicBackgroundTaskKey);
});