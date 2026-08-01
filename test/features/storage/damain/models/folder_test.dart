import 'package:flutter_test/flutter_test.dart';
import 'package:lo_files/features/storage/domain/models/folder.dart';

void main() {
  group('Folder', () {
    test('creates 3-level hierarchy using parentId', () {
      final root = Folder(
        id: 1,
        name: 'Root',
        parentId: null,
        createdAt: DateTime.parse('2026-08-01T10:00:00Z'),
      );

      final child = Folder(
        id: 2,
        name: 'Child',
        parentId: root.id,
        createdAt: DateTime.parse('2026-08-01T10:05:00Z'),
      );

      final grandChild = Folder(
        id: 3,
        name: 'GrandChild',
        parentId: child.id,
        createdAt: DateTime.parse('2026-08-01T10:10:00Z'),
      );

      expect(root.parentId, isNull);
      expect(child.parentId, root.id);
      expect(grandChild.parentId, child.id);

      expect(root.name, 'Root');
      expect(child.name, 'Child');
      expect(grandChild.name, 'GrandChild');
    });

    test('copyWith creates updated folder', () {
      final folder = Folder(
        id: 1,
        name: 'Root',
        parentId: null,
        createdAt: DateTime.parse('2026-08-01T10:00:00Z'),
      );

      final updated = folder.copyWith(name: 'RootRenamed');

      expect(updated.name, 'RootRenamed');
      expect(updated.id, folder.id);
      expect(updated.parentId, folder.parentId);
      expect(updated.createdAt, folder.createdAt);
      expect(identical(updated, folder), isFalse);
    });
  });
}