# Miscelaneos

Renombrar App ID
```
flutter pub run change_app_package_name:main com.alfredodiaz.miscelaneos
```

sha-256
```
cd android
./gradlew signingReport
```


## Pruebas IOS
```
xcrun simctl openurl booted https://pokemon-deep-linking.up.railway.app/pokemons/1/

xcrun simctl openurl booted https://pokemon-deep-linking.up.railway.app/pokemons
```

## Cambiar API Keys de Google Maps

## Generador de codigo ( Isar, Riverpod )
'''
flutter pub run build_runner build
flutter pub run build_runner watch
'''