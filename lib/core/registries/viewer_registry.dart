// lib/core/registries/viewer_registry.dart

import 'package:flutter/widgets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/storage/domain/models/file.dart';
import '../../features/storage/domain/models/file_type.dart';

part 'viewer_registry.g.dart';

/// Тип функции-билдера для создания виджета-просмотрщика.
///
/// Принимает доменную модель [File] и возвращает готовый виджет
/// для отображения содержимого файла. Это позволяет реестру
/// не зависеть от конкретных реализаций просмотрщиков.
typedef ViewerBuilder = Widget Function(File file);

/// Расширение для получения строкового представления формата из FileType.
///
/// Используется реестром для маппинга enum на строковые ключи.
extension FileTypeX on FileType {
  /// Возвращает строковое представление формата (расширение файла).
  ///
  /// Например: FileType.txt → 'txt', FileType.jpeg → 'jpeg'
  String get extension => name;
}

/// Реестр соответствий "формат файла → виджет-просмотрщик".
///
/// Этот класс реализует паттерн Registry из architectural.md (раздел 5.1):
/// вместо условных конструкций "если TXT — открыть текстовый экран,
/// если JPEG — открыть просмотрщик картинок" используется таблица
/// соответствий, к которой в будущем плагины просто добавляют новые
/// записи без изменения кода экрана просмотра.
///
/// ## Как использовать:
/// 1. Модуль-плагин регистрирует свой просмотрщик:
///    ```dart
///    registry.register(FileType.txt, (file) => TextViewer(file: file));
///    registry.register(FileType.jpeg, (file) => ImageViewer(file: file));
///    ```
/// 2. Presentation-слой получает просмотрщик:
///    ```dart
///    final viewer = registry.getViewerFor(file);
///    if (viewer != null) {
///      Navigator.push(context, MaterialPageRoute(builder: (_) => viewer));
///    }
///    ```
///
/// ## Обработка форматов:
/// - Ключи регистрацию приводятся к нижнему регистру ('TXT' → 'txt')
/// - Поддерживаются как расширения ('txt', 'pdf'), так и MIME-типы ('image/jpeg')
/// - Если для формата нет зарегистрированного просмотрщика, возвращается null
class ViewerRegistry {
  /// Внутреннее хранилище соответствий "формат → билдер".
  final Map<FileType, ViewerBuilder> _viewers = {};

  /// Регистрирует просмотрщик для указанного формата файла.
  ///
  /// [fileType] — тип файла из enum [FileType].
  ///
  /// [builder] — функция, которая принимает [File] и возвращает виджет.
  ///
  /// Если для формата уже был зарегистрирован просмотрщик, он будет заменён.
  void register(FileType fileType, ViewerBuilder builder) {
    _viewers[fileType] = builder;
  }

  /// Возвращает билдер просмотрщика для указанного формата.
  ///
  /// [fileType] — тип файла из enum [FileType].
  ///
  /// Возвращает [ViewerBuilder] если просмотрщик зарегистрирован,
  /// иначе null.
  ViewerBuilder? getViewerForFormat(FileType fileType) {
    return _viewers[fileType];
  }

  /// Возвращает билдер просмотрщика для конкретного файла.
  ///
  /// [file] — доменная модель файла.
  ///
  /// Использует [File.type] для определения формата и поиска
  /// соответствующего просмотрщика в реестре.
  ///
  /// Возвращает готовый виджет если просмотрщик найден, иначе null.
  Widget? getViewerFor(File file) {
    final builder = getViewerForFormat(file.type);
    if (builder == null) return null;
    return builder(file);
  }

  /// Проверяет, зарегистрирован ли просмотрщик для указанного формата.
  bool hasViewerFor(FileType fileType) {
    return _viewers.containsKey(fileType);
  }

  /// Возвращает список всех зарегистрированных форматов.
  Iterable<FileType> get registeredFormats => _viewers.keys;
}

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
@Riverpod(keepAlive: true)
ViewerRegistry viewerRegistry(Ref ref) {
  return ViewerRegistry();
}