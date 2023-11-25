import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class BiometricsScreen extends ConsumerWidget {
  const BiometricsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final canCheckBiometrics = ref.watch( canCheckBiometricsProvider );
    final localAuthState = ref.watch( localAuthProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometric Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton.tonal(
              onPressed: () {
                ref.read( localAuthProvider.notifier )
                  .authenticateUser( biometricOnly: true );
              }, 
              child: const Text('Autenticar')
            ),

            const SizedBox(height: 40),
            canCheckBiometrics.when(
              data: ( canCheck ) => Text('Puede revisar biométricos: $canCheck', style: const TextStyle(fontSize: 17)), 
              error: (error, _ ) => Text('Error: $error'), 
              loading: () => const SizedBox(), // No mostramos nada porque es muy rápido
            ),

            const SizedBox(height: 30),
            const Text('Estado del biométrico', style: TextStyle(fontSize: 25)),
            const SizedBox(height: 30),
            Text('Estado: $localAuthState', style: const TextStyle(fontSize: 17)),
          ],
        ),
      ),
    );
  }
}