// lib/features/account/domain/repositories/user_profile_cache_repository.dart

import '../../../../core/result/result.dart';
import '../models/user.dart';

/// Контракт репозитория для работы с кэшем профиля пользователя.
///
/// [UserProfileCacheRepository] — это интерфейс уровня Domain-слоя, который
/// объявляет операции для получения/создания локального профиля (гостевого
/// или авторизованного пользователя), но не содержит никакой реализации,
/// связанной с конкретной БД (Drift).
///
/// Реализация находится в Data-слое как `DriftUserProfileCacheRepository`,
/// работающая с локальной SQLite-таблицей `user_profile_cache`.
///
/// ## Обработка ошибок
/// Все методы возвращают `Result<T>` (docs/architecture.md, раздел 3.4 —
/// Result / Envelope Pattern, пункт А). Это означает, что вызывающий код
/// обязан явно обработать оба исхода: успех (`Result.success`) или ошибку
/// (`Result.failure` с `errorCode` и `errorMessage`). Исключения не
/// выбрасываются на границах слоёв use case — любые ошибки Drift должны
/// быть перехвачены в Data-слое и завёрнуты в `Result.failure`.
///
/// ## Singleton-кэш
/// В MVP предполагается ровно одна активная запись профиля на устройство
/// (гостевой режим или единственный авторизованный пользователь). Метод
/// [getOrCreateGuestProfile] спроектирован с учётом этого ограничения:
/// он либо возвращает существующий профиль, либо создаёт новый гостевой,
/// если записей ещё нет.
abstract class UserProfileCacheRepository {
  /// Возвращает существующий профиль пользователя или создаёт новый
  /// гостевой профиль, если записей ещё нет.
  ///
  /// В MVP `id = 1` жёстко зашит как идентификатор единственной активной
  /// записи кэша (см. `user_profile_cache_table.dart` — `id` как
  /// `autoIncrement`, но в реализации всегда `1`).
  ///
  /// Возвращает `Result.success` с доменной моделью [User] или
  /// `Result.failure` с кодом ошибки (например, 'profile_creation_failed',
  /// если не удалось создать гостевой профиль).
  Future<Result<User>> getOrCreateGuestProfile();
}