// lib/data/local/mappers/user_profile_cache_mapper.dart

import 'package:drift/drift.dart'; // <-- добавлено

import '../../../features/account/domain/models/user.dart';
import '../../../core/database/database.dart'; // <-- импортируем database.dart, а не database.g.dart

/// Маппер между storage-моделью [UserProfileCacheData] (Drift) и
/// доменной моделью [User].
///
/// Разделение маппинга и репозитория соответствует правилу
/// docs/architecture.md, раздел 3.7 — Domain Model vs Storage Model vs
/// DTO vs View Model: преобразование между формами — только через
/// отдельные функции/классы-мапперы, никогда не «одна структура на всё».
class UserProfileCacheMapper {
  /// Преобразует storage-модель [UserProfileCacheData] в доменную [User].
  ///
  /// [storage] — запись из таблицы `user_profile_cache`.
  /// Возвращает [User] с полями `id` (как строка), `displayName`,
  /// `isGuest`.
  static User toDomain(UserProfileCacheData storage) {
    return User(
      id: storage.id.toString(),
      displayName: storage.displayName,
      isGuest: storage.isGuest,
    );
  }

  /// Преобразует доменную [User] в storage-компаньон для вставки/обновления.
  ///
  /// [domain] — доменная модель пользователя.
  /// Возвращает `UserProfileCacheCompanion` для использования в
  /// `db.into(db.userProfileCache).insert()` или `.update()`.
  static UserProfileCacheCompanion toStorageCompanion(User domain) {
    return UserProfileCacheCompanion(
      displayName: Value(domain.displayName),
      isGuest: Value(domain.isGuest),
      // entitlementsCache оставляем null в MVP — зарезервировано на будущее
    );
  }
}