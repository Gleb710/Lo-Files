import 'package:drift/drift.dart';

import '../../../core/database/database.dart';

class UserProfileCacheRepository {
  final AppDatabase db;

  UserProfileCacheRepository(this.db);

  Future<UserProfileCacheData> getOrCreateGuestProfile() async {
    final existing = await (db.select(db.userProfileCache)
          ..where((t) => t.id.equals(1)))
        .getSingleOrNull();

    if (existing != null) {
      return existing;
    }

    final id = await db.into(db.userProfileCache).insert(
          UserProfileCacheCompanion.insert(
            id: const Value(1),
            displayName: 'Guest',
            isGuest: true,
          ),
        );

    return (await (db.select(db.userProfileCache)
          ..where((t) => t.id.equals(id)))
        .getSingle());
  }
}