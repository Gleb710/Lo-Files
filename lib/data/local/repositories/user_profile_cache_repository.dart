// lib/data/local/repositories/user_profile_cache_repository.dart

import '../../../core/database/database.dart';
import '../../../core/result/result.dart';
import '../../../features/account/domain/models/user.dart';
import '../../../features/account/domain/repositories/user_profile_cache_repository.dart';
import '../mappers/user_profile_cache_mapper.dart';

// Удалён импорт 'package:drift/drift.dart' — больше не используется

/// Data-репозиторий для работы с кэшем профиля пользователя.
///
/// Реализует интерфейс [UserProfileCacheRepository] (Domain-слой) и
/// работает с локальной SQLite-таблицей `user_profile_cache` через Drift.
///
/// ## Singleton-кэш
/// В MVP предполагается ровно одна активная запись профиля на устройство.
/// Метод [getOrCreateGuestProfile] либо возвращает существующий профиль
/// (по `id = 1`), либо создаёт новый гостевой, если записей ещё нет.
class DriftUserProfileCacheRepository implements UserProfileCacheRepository {
  final AppDatabase db;

  DriftUserProfileCacheRepository(this.db);

  @override
  Future<Result<User>> getOrCreateGuestProfile() async {
    try {
      // Пробуем получить существующую запись с id = 1
      final existing = await (db.select(db.userProfileCache)
            ..where((t) => t.id.equals(1)))
          .getSingleOrNull();

      if (existing != null) {
        return Result.success(UserProfileCacheMapper.toDomain(existing));
      }

      // Записи нет — создаём гостевой профиль
      final id = await db.into(db.userProfileCache).insert(
            UserProfileCacheMapper.toStorageCompanion(
              User(
                id: '1',
                displayName: 'Guest',
                isGuest: true,
              ),
            ),
          );

      final created = await (db.select(db.userProfileCache)
            ..where((t) => t.id.equals(id)))
          .getSingle();

      return Result.success(UserProfileCacheMapper.toDomain(created));
    } catch (e) {
      // Любая ошибка Drift оборачивается в Result.failure
      return Result.failure(
        errorCode: 'profile_creation_failed',
        errorMessage: 'Failed to get or create guest profile: $e',
      );
    }
  }
}