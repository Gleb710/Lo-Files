// lib/features/recent_favorites/domain/models/favorite_entry.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sync_status.dart';

part 'favorite_entry.freezed.dart';

/// Domain-модель записи избранного файла.
///
/// Обслуживает модуль Recent & Favorites (неделя 5), но проектируется
/// вместе с остальными доменными сущностями для консистентности (см.
/// docs/architecture.md, раздел 3.7 — Domain vs Storage vs DTO vs View).
///
/// Соответствие Storage-слою (docs/architecture.md, раздел 9.1):
/// таблица `favorites` (id, fileId, addedAt, sync_status). Маппинг между
/// Storage-моделью и этой доменной моделью выполняется отдельным маппером
/// в Data-слое.
@freezed
abstract class FavoriteEntry with _$FavoriteEntry {
  const factory FavoriteEntry({
    /// Идентификатор записи (первичный ключ таблицы `favorites`).
    required int id,

    /// Идентификатор файла (`local_files.id`), добавленного в избранное.
    required int fileId,

    /// Момент, когда файл был добавлен в избранное.
    required DateTime addedAt,

    /// Статус синхронизации записи с backend-модулем Sync.
    ///
    /// Задел под будущий модуль синхронизации (см. [SyncStatus]). В MVP
    /// это поле всегда `null` и НЕ ДОЛЖНО использоваться в бизнес-логике.
    SyncStatus? syncStatus,
  }) = _FavoriteEntry;
}