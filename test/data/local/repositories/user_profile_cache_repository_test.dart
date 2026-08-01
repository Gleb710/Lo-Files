import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lo_files/core/database/database.dart';
import 'package:lo_files/data/local/repositories/user_profile_cache_repository.dart';

void main() {
  late AppDatabase db;
  late UserProfileCacheRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = UserProfileCacheRepository(db);
  });

  tearDown(() async {
    await db.close();
  });

  test('creates guest profile by default when cache is empty', () async {
    final profile = await repository.getOrCreateGuestProfile();

    expect(profile.id, 1);
    expect(profile.displayName, 'Guest');
    expect(profile.isGuest, isTrue);

    final count = await db.select(db.userProfileCache).get();
    expect(count.length, 1);
  });
}