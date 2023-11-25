import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:miscelaneos/presentation/providers/providers.dart';

class LocationScreen extends ConsumerWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final userLocationAsync = ref.watch( userLocationProvider );
    final watchLocationAsync = ref.watch( watchLocationProvider );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubicación'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // * Current Location
            const Text('Ubicación Actual', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),

            userLocationAsync.when(
              data: (data) => Text('$data', style: const TextStyle(fontSize: 18)), 
              error: (error, stackTrace) => Text('Error: $error'), 
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
            ),

            const SizedBox(height: 30),
            const Text('Seguimiento De Ubicación', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 30),

            watchLocationAsync.when(
              data: (data) => Text('$data', style: const TextStyle(fontSize: 18)), 
              error: (error, stackTrace) => Text('Error: $error'), 
              loading: () => const CircularProgressIndicator(strokeWidth: 2),
            ),

          ],
        ),
      ),
    );
  }
}