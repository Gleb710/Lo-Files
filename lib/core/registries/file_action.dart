// lib/core/registries/file_action.dart

import 'package:flutter/material.dart';

import '../../features/storage/domain/models/file.dart';

/// Модель действия в контекстном меню файла.
///
/// [FileAction] представляет один пункт меню, который может быть
/// выполнен над файлом. Реестр действий (FileActionRegistry) хранит
/// список зарегистрированных действий и возвращает только те,
/// которые доступны для конкретного файла.
///
/// ## Поля:
/// - [id] — уникальный идентификатор действия (например, 'rename', 'delete').
/// - [label] — текст пункта меню, отображаемый пользователю.
/// - [icon] — иконка действия (опционально).
/// - [isAvailable] — предикат, определяющий, доступно ли действие для файла.
/// - [execute] — функция выполнения действия над файлом.
///
/// ## Интеграция с EntitlementChecker:
/// В [isAvailable] может быть заложена проверка прав доступа через
/// EntitlementChecker для платных функций плагинов. В MVP это не
/// активируется — заглушка всегда возвращает true.
///
/// ## Пример использования:
/// ```dart
/// final renameAction = FileAction(
///   id: 'rename',
///   label: 'Переименовать',
///   icon: Icons.edit,
///   isAvailable: (file) => true,
///   execute: (file) async {
///     // Логика переименования
///   },
/// );
/// ```
class FileAction {
  /// Уникальный идентификатор действия.
  final String id;

  /// Текст пункта меню.
  final String label;

  /// Иконка действия (опционально).
  final IconData? icon;

  /// Предикат доступности действия для конкретного файла.
  ///
  /// Возвращает `true`, если действие должно отображаться в меню
  /// для указанного файла, и `false` в противном случае.
  ///
  /// В этом предикате может быть заложена проверка прав доступа
  /// через EntitlementChecker для платных функций плагинов.
  final bool Function(File file) isAvailable;

  /// Функция выполнения действия над файлом.
  ///
  /// Принимает доменную модель [File] и выполняет асинхронную
  /// операцию (переименование, удаление, перемещение и т.д.).
  final Future<void> Function(File file) execute;

  const FileAction({
    required this.id,
    required this.label,
    this.icon,
    required this.isAvailable,
    required this.execute,
  });
}