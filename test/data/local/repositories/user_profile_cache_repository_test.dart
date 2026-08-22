import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lo_files/core/database/database.dart';
import 'package:lo_files/data/local/repositories/user_profile_cache_repository.dart';

void main() {
  late AppDatabase db;
  late DriftUserProfileCacheRepository repository; // <-- изменили тип

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = DriftUserProfileCacheRepository(db); // <-- изменили конструктор
  });

  tearDown(() async {
    await db.close();
  });

test('creates guest profile by default when cache is empty', () async {
  final result = await repository.getOrCreateGuestProfile();
  final profile = result.data!; // <-- используем data вместо getOrNull()

  expect(profile.id, 1);
  expect(profile.displayName, 'Guest');
  expect(profile.isGuest, isTrue);

  final count = await db.select(db.userProfileCache).get();
  expect(count.length, 1);
});
}