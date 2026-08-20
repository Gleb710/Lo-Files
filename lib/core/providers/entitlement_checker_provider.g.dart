// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entitlement_checker_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Глобальный singleton-провайдер [EntitlementChecker].
///
/// `keepAlive: true` обязателен по той же причине, что и для
/// `databaseProvider`: `EntitlementChecker` — core-сервис уровня
/// приложения, а не state конкретного экрана, и не должен пересоздаваться
/// при потере последнего слушателя (см. docs/architecture.md, раздел 3.5 —
/// DI через Riverpod).
///
/// Сейчас возвращает [StubEntitlementChecker] (MVP-заглушка, всегда
/// `false`). После MVP здесь будет подменена конкретная реализация,
/// обращающаяся к backend'у — вызывающий код (Viewer Registry, File
/// Action Registry) от этой замены не изменится, так как зависит только
/// от интерфейса [EntitlementChecker].

@ProviderFor(entitlementChecker)
final entitlementCheckerProvider = EntitlementCheckerProvider._();

/// Глобальный singleton-провайдер [EntitlementChecker].
///
/// `keepAlive: true` обязателен по той же причине, что и для
/// `databaseProvider`: `EntitlementChecker` — core-сервис уровня
/// приложения, а не state конкретного экрана, и не должен пересоздаваться
/// при потере последнего слушателя (см. docs/architecture.md, раздел 3.5 —
/// DI через Riverpod).
///
/// Сейчас возвращает [StubEntitlementChecker] (MVP-заглушка, всегда
/// `false`). После MVP здесь будет подменена конкретная реализация,
/// обращающаяся к backend'у — вызывающий код (Viewer Registry, File
/// Action Registry) от этой замены не изменится, так как зависит только
/// от интерфейса [EntitlementChecker].

final class EntitlementCheckerProvider
    extends
        $FunctionalProvider<
          EntitlementChecker,
          EntitlementChecker,
          EntitlementChecker
        >
    with $Provider<EntitlementChecker> {
  /// Глобальный singleton-провайдер [EntitlementChecker].
  ///
  /// `keepAlive: true` обязателен по той же причине, что и для
  /// `databaseProvider`: `EntitlementChecker` — core-сервис уровня
  /// приложения, а не state конкретного экрана, и не должен пересоздаваться
  /// при потере последнего слушателя (см. docs/architecture.md, раздел 3.5 —
  /// DI через Riverpod).
  ///
  /// Сейчас возвращает [StubEntitlementChecker] (MVP-заглушка, всегда
  /// `false`). После MVP здесь будет подменена конкретная реализация,
  /// обращающаяся к backend'у — вызывающий код (Viewer Registry, File
  /// Action Registry) от этой замены не изменится, так как зависит только
  /// от интерфейса [EntitlementChecker].
  EntitlementCheckerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'entitlementCheckerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$entitlementCheckerHash();

  @$internal
  @override
  $ProviderElement<EntitlementChecker> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  EntitlementChecker create(Ref ref) {
    return entitlementChecker(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(EntitlementChecker value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<EntitlementChecker>(value),
    );
  }
}

String _$entitlementCheckerHash() =>
    r'1d0f000ca7a5500b825017e54ac7e5cadee98e98';
