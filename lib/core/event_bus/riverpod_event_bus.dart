// lib/core/event_bus/riverpod_event_bus.dart

import 'dart:async';

import '../events/app_event.dart';
import 'event_bus.dart';

/// In-process реализация [EventBus] на клиенте.
///
/// Хранит единственный broadcast [StreamController] на весь жизненный
/// цикл приложения. `broadcast()` обязателен: без него второй вызов
/// [on] упал бы с ошибкой, так как single-subscription
/// `StreamController` допускает только одного слушателя, а шине нужно
/// поддерживать произвольное число независимых подписчиков (см.
/// docs/architecture.md, раздел 3.2).
///
/// Закрывать [_controller] должен вызывающий код через [dispose] —
/// см. `eventBusProvider`, где вызывается `ref.onDispose(dispose)`,
/// чтобы поток закрывался при полном завершении работы приложения и
/// не оставался утечкой памяти.
class RiverpodEventBus implements EventBus {
  final StreamController<AppEvent> _controller =
      StreamController<AppEvent>.broadcast();

  @override
  void publish(AppEvent event) {
    _controller.add(event);
  }

  @override
  Stream<T> on<T extends AppEvent>() {
    return _controller.stream.where((event) => event is T).cast<T>();
  }

  /// Закрывает внутренний поток. Вызывается только через
  /// `ref.onDispose` в `eventBusProvider` — не вызывать вручную из
  /// кода модулей.
  void dispose() {
    _controller.close();
  }
}
