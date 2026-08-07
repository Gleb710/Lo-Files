import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/providers/database_provider.dart';
import 'features/storage/providers/storage_label_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lo-Files',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 37, 126, 138),
        ),
      ),
      home: const DiCheckScreen(),
    );
  }
}

class DiCheckScreen extends ConsumerWidget {
  const DiCheckScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final database = ref.watch(databaseProvider);
    final storageLabel = ref.watch(storageLabelProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DI check'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Database type: ${database.runtimeType}'),
            const SizedBox(height: 12),
            Text('Feature provider: $storageLabel'),
          ],
        ),
      ),
    );
  }
}