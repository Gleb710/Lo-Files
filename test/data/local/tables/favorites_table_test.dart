import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:lo_files/core/database/database.dart';

void main() {
  late AppDatabase database;

  setUp(() {
    database = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await database.close();
  });

  test('Вставка и удаление записи избранного', () async {
    final fileId = await database.into(database.localFiles).insert(
          LocalFilesCompanion.insert(
            name: 'test.txt',
            path: '/root/test.txt',
            sizeInBytes: 10,
            createdAt: DateTime.now(),
            modifiedAt: DateTime.now(),
          ),
        );

    final favoriteId = await database.into(database.favorites).insert(
          FavoritesCompanion.insert(
            fileId: fileId,
            addedAt: DateTime.now(),
          ),
        );

    expect(favoriteId, isNonZero);

    await (database.delete(database.favorites)
          ..where((tbl) => tbl.id.equals(favoriteId)))
        .go();

    final remaining = await database.select(database.favorites).get();
    expect(remaining, isEmpty);
  });

  test('Дублирование fileId в избранном должно падать', () async {
    final fileId = await database.into(database.localFiles).insert(
          LocalFilesCompanion.insert(
            name: 'duplicate.txt',
            path: '/root/duplicate.txt',
            sizeInBytes: 20,
            createdAt: DateTime.now(),
            modifiedAt: DateTime.now(),
          ),
        );

    await database.into(database.favorites).insert(
          FavoritesCompanion.insert(
            fileId: fileId,
            addedAt: DateTime.now(),
          ),
        );

    expect(
      () => database.into(database.favorites).insert(
            FavoritesCompanion.insert(
              fileId: fileId,
              addedAt: DateTime.now(),
            ),
          ),
      throwsA(isA<Exception>()),
    );
  });
}