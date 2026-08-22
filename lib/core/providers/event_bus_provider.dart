// lib/core/providers/event_bus_provider.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../event_bus/event_bus.dart';
import '../event_bus/riverpod_event_bus.dart';

part 'event_bus_provider.g.dart';

/// Глобальный singleton-провайдер [EventBus].
///
/// `keepAlive: true` обязателен по той же причине, что и для
/// `databaseProvider`/`entitlementCheckerProvider`: шина — core-сервис
/// уровня приложения, который не должен пересоздаваться при потере
/// последнего слушателя (см. docs/architecture.md, раздел 3.5, и план
/// задачи 5 — «не autoDispose, чтобы шина не пересоздавалась при
/// каждой пересборке виджета»).
///
/// `ref.onDispose` закрывает внутренний `StreamController` у
/// [RiverpodEventBus] при полном завершении работы приложения — без
/// этого поток остался бы открытым до сборки мусора, что является
/// утечкой памяти.
@Riverpod(keepAlive: true)
EventBus eventBus(Ref ref) {
  final bus = RiverpodEventBus();
  ref.onDispose(bus.dispose);
  return bus;
}
