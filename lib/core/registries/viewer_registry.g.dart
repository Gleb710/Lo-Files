// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'viewer_registry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton-провайдер реестра просмотрщиков.
///
/// `keepAlive: true` обязателен: [ViewerRegistry] должен жить на весь
/// жизненный цикл приложения, чтобы модули могли регистрировать свои
/// просмотрщики при старте, а Presentation-слой мог получить к ним
/// доступ в любой момент.
///
/// ## Пример использования:
/// ```dart
/// // Регистрация (в модуле-плагине):
/// final registry = ref.read(viewerRegistryProvider);
/// registry.register(FileType.txt, (file) => TextViewer(file: file));
///
/// // Получение (в Presentation-слое):
/// final viewer = ref.watch(viewerRegistryProvider).getViewerFor(file);
/// ```

@ProviderFor(viewerRegistry)
final viewerRegistryProvider = ViewerRegistryProvider._();

/// Singleton-провайдер реестра просмотрщиков.
///
/// `keepAlive: true` обязателен: [ViewerRegistry] должен жить на весь
/// жизненный цикл приложения, чтобы модули могли регистрировать свои
/// просмотрщики при старте, а Presentation-слой мог получить к ним
/// доступ в любой момент.
///
/// ## Пример использования:
/// ```dart
/// // Регистрация (в модуле-плагине):
/// final registry = ref.read(viewerRegistryProvider);
/// registry.register(FileType.txt, (file) => TextViewer(file: file));
///
/// // Получение (в Presentation-слое):
/// final viewer = ref.watch(viewerRegistryProvider).getViewerFor(file);
/// ```

final class ViewerRegistryProvider
    extends $FunctionalProvider<ViewerRegistry, ViewerRegistry, ViewerRegistry>
    with $Provider<ViewerRegistry> {
  /// Singleton-провайдер реестра просмотрщиков.
  ///
  /// `keepAlive: true` обязателен: [ViewerRegistry] должен жить на весь
  /// жизненный цикл приложения, чтобы модули могли регистрировать свои
  /// просмотрщики при старте, а Presentation-слой мог получить к ним
  /// доступ в любой момент.
  ///
  /// ## Пример использования:
  /// ```dart
  /// // Регистрация (в модуле-плагине):
  /// final registry = ref.read(viewerRegistryProvider);
  /// registry.register(FileType.txt, (file) => TextViewer(file: file));
  ///
  /// // Получение (в Presentation-слое):
  /// final viewer = ref.watch(viewerRegistryProvider).getViewerFor(file);
  /// ```
  ViewerRegistryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'viewerRegistryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$viewerRegistryHash();

  @$internal
  @override
  $ProviderElement<ViewerRegistry> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  ViewerRegistry create(Ref ref) {
    return viewerRegistry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ViewerRegistry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ViewerRegistry>(value),
    );
  }
}

String _$viewerRegistryHash() => r'f8bae91c146845ad27b4e549829e977568171ca7';
