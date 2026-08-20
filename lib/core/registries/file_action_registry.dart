// lib/core/registries/file_action_registry.dart

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/storage/domain/models/file.dart';
import 'file_action.dart';

part 'file_action_registry.g.dart';

/// Реестр действий контекстного меню файла.
///
/// Этот класс реализует паттерн Registry из architectural.md (раздел 5.2):
/// вместо "зашитого" в разметку экрана контекстного меню используется
/// программно генерируемый список действий, к которому в будущем плагины
/// могут добавлять свои действия без изменения кода UI.
///
/// ## Как использовать:
/// 1. Модуль регистрирует действие:
///    ```dart
///    registry.registerAction(FileAction(
///      id: 'rename',
///      label: 'Переименовать',
///      icon: Icons.edit,
///      isAvailable: (file) => true,
///      execute: (file) async {
///        // Логика переименования
///      },
///    ));
///    ```
/// 2. Presentation-слой получает доступные действия:
///    ```dart
///    final actions = registry.getActionsFor(file);
///    for (final action in actions) {
///      ListTile(
///        leading: action.icon != null ? Icon(action.icon) : null,
///        title: Text(action.label),
///        onTap: () => action.execute(file),
///      );
///    }
///    ```
///
/// ## Обработка действий:
/// - [getActionsFor] возвращает только действия, у которых
///   [FileAction.isAvailable] возвращает `true` для данного файла.
/// - Это гарантирует, что меню не покажет недоступные пользователю пункты.
/// - В [isAvailable] может быть заложена проверка прав через
///   EntitlementChecker для платных функций плагинов.
class FileActionRegistry {
  /// Внутреннее хранилище зарегистрированных действий.
  final List<FileAction> _actions = [];

  /// Регистрирует действие в реестре.
  ///
  /// [action] — модель действия с метаданными и логикой выполнения.
  ///
  /// Если действие с таким [id] уже зарегистрировано, оно будет добавлено
  /// повторно (дублирование допускается для переопределения порядка).
  void registerAction(FileAction action) {
    _actions.add(action);
  }

  /// Возвращает список действий, доступных для указанного файла.
  ///
  /// [file] — доменная модель файла.
  ///
  /// Фильтрует зарегистрированные действия через [FileAction.isAvailable]
  /// и возвращает только те, которые возвращают `true` для данного файла.
  ///
  /// Это гарантирует, что контекстное меню не покажет недоступные
  /// пользователю пункты (например, платные функции без лицензии).
  List<FileAction> getActionsFor(File file) {
    return _actions.where((action) => action.isAvailable(file)).toList();
  }

  /// Проверяет, зарегистрировано ли действие с указанным идентификатором.
  bool hasAction(String actionId) {
    return _actions.any((action) => action.id == actionId);
  }

  /// Возвращает действие по идентификатору.
  ///
  /// [actionId] — уникальный идентификатор действия.
  ///
  /// Возвращает [FileAction] если найдено, иначе null.
  FileAction? getActionById(String actionId) {
    try {
      return _actions.firstWhere((action) => action.id == actionId);
    } on StateError {
      return null;
    }
  }

  /// Возвращает список всех зарегистрированных действий.
  ///
  /// Используйте с осторожностью — в реальном приложении это может
  /// раскрыть действия, недоступные для конкретного файла/пользователя.
  List<FileAction> getAllActions() => List.unmodifiable(_actions);
}

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
@Riverpod(keepAlive: true)
FileActionRegistry fileActionRegistry(Ref ref) {
  return FileActionRegistry();
}