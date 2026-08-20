import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../database/database.dart';

part 'database_provider.g.dart';

/// Глобальный singleton-провайдер локальной Drift-базы данных.
///
/// `keepAlive: true` обязателен: [AppDatabase] должен жить на весь
/// жизненный цикл приложения, а не пересоздаваться при потере последнего
/// слушателя (см. docs/architecture.md, раздел 3.5 — DI через Riverpod).
/// Если убрать эту аннотацию (оставить просто `@riverpod`), провайдер
/// станет autoDispose по умолчанию — это тихо изменит поведение и создаст
/// новый экземпляр `AppDatabase` при каждом временном отсутствии слушателей.
@Riverpod(keepAlive: true)
AppDatabase database(Ref ref) {
  return AppDatabase();
}
