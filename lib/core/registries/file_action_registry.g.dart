// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'file_action_registry.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Singleton-провайдер реестра действий файла.
///
/// `keepAlive: true` обязателен: [FileActionRegistry] должен жить на весь
/// жизненный цикл приложения, чтобы модули могли регистрировать свои
/// действия при старте, а Presentation-слой мог получить к ним
/// доступ в любой момент.
///
/// ## Пример использования:
/// ```dart
/// // Регистрация (в модуле):
/// final registry = ref.read(fileActionRegistryProvider);
/// registry.registerAction(renameAction);
///
/// // Получение (в Presentation-слое):
/// final actions = ref.watch(fileActionRegistryProvider).getActionsFor(file);
/// ```

@ProviderFor(fileActionRegistry)
final fileActionRegistryProvider = FileActionRegistryProvider._();

/// Singleton-провайдер реестра действий файла.
///
/// `keepAlive: true` обязателен: [FileActionRegistry] должен жить на весь
/// жизненный цикл приложения, чтобы модули могли регистрировать свои
/// действия при старте, а Presentation-слой мог получить к ним
/// доступ в любой момент.
///
/// ## Пример использования:
/// ```dart
/// // Регистрация (в модуле):
/// final registry = ref.read(fileActionRegistryProvider);
/// registry.registerAction(renameAction);
///
/// // Получение (в Presentation-слое):
/// final actions = ref.watch(fileActionRegistryProvider).getActionsFor(file);
/// ```

final class FileActionRegistryProvider
    extends
        $FunctionalProvider<
          FileActionRegistry,
          FileActionRegistry,
          FileActionRegistry
        >
    with $Provider<FileActionRegistry> {
  /// Singleton-провайдер реестра действий файла.
  ///
  /// `keepAlive: true` обязателен: [FileActionRegistry] должен жить на весь
  /// жизненный цикл приложения, чтобы модули могли регистрировать свои
  /// действия при старте, а Presentation-слой мог получить к ним
  /// доступ в любой момент.
  ///
  /// ## Пример использования:
  /// ```dart
  /// // Регистрация (в модуле):
  /// final registry = ref.read(fileActionRegistryProvider);
  /// registry.registerAction(renameAction);
  ///
  /// // Получение (в Presentation-слое):
  /// final actions = ref.watch(fileActionRegistryProvider).getActionsFor(file);
  /// ```
  FileActionRegistryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fileActionRegistryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fileActionRegistryHash();

  @$internal
  @override
  $ProviderElement<FileActionRegistry> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FileActionRegistry create(Ref ref) {
    return fileActionRegistry(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FileActionRegistry value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FileActionRegistry>(value),
    );
  }
}

String _$fileActionRegistryHash() =>
    r'0968a8ec9da095c7be10d018774abbb14bac137d';
