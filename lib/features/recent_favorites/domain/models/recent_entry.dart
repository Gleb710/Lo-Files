// lib/features/recent_favorites/domain/models/recent_entry.dart

import 'package:freezed_annotation/freezed_annotation.dart';

import 'sync_status.dart';

part 'recent_entry.freezed.dart';

/// Domain-модель записи о недавно открытом файле.
///
/// Обслуживает модуль Recent & Favorites (неделя 5), но проектируется
/// вместе с остальными доменными сущностями для консистентности (см.
/// docs/architecture.md, раздел 3.7 — Domain vs Storage vs DTO vs View).
///
/// Соответствие Storage-слою (docs/architecture.md, раздел 9.1):
/// таблица `recent_entries` (id, fileId, openedAt, sync_status). Маппинг
/// между Storage-моделью и этой доменной моделью выполняется отдельным
/// маппером в Data-слое.
@freezed
abstract class RecentEntry with _$RecentEntry {
  const factory RecentEntry({
    /// Идентификатор записи (первичный ключ таблицы `recent_entries`).
    required int id,

    /// Идентификатор файла (`local_files.id`), к которому относится запись.
    required int fileId,

    /// Момент, когда файл был открыт пользователем.
    required DateTime openedAt,

    /// Статус синхронизации записи с backend-модулем Sync.
    ///
    /// Задел под будущий модуль синхронизации (см. [SyncStatus]). В MVP
    /// это поле всегда `null` и НЕ ДОЛЖНО использоваться в бизнес-логике.
    SyncStatus? syncStatus,
  }) = _RecentEntry;
}