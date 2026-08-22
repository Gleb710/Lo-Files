// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_bus_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

@ProviderFor(eventBus)
final eventBusProvider = EventBusProvider._();

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

final class EventBusProvider
    extends $FunctionalProvider<EventBus, EventBus, EventBus>
    with $Provider<EventBus> {
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
  EventBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'eventBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$eventBusHash();

  @$internal
  @override
  $ProviderElement<EventBus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  EventBus create(Ref ref) {
    return eventBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EventBus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EventBus>(value),
    );
  }
}

String _$eventBusHash() => r'04f582b91be286c2467f43bacd43b47d7123ce9f';
