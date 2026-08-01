import 'package:flutter_test/flutter_test.dart';
import 'package:lo_files/features/storage/domain/models/file.dart';
import 'package:lo_files/features/storage/domain/models/file_type.dart';

void main() {
  group('File', () {
    test('creates object with correct fields', () {
      final file = File(
        id: 1,
        name: 'example.txt',
        path: '/docs/example.txt',
        type: FileType.txt,
        size: 1024,
        createdAt: DateTime.parse('2026-08-01T10:00:00Z'),
        extraMetadata: {'author': 'test'},
      );

      expect(file.id, 1);
      expect(file.name, 'example.txt');
      expect(file.path, '/docs/example.txt');
      expect(file.type, FileType.txt);
      expect(file.size, 1024);
      expect(file.createdAt, DateTime.parse('2026-08-01T10:00:00Z'));
      expect(file.extraMetadata?['author'], 'test');
    });

    test('copyWith changes only requested field', () {
      final original = File(
        id: 1,
        name: 'example.txt',
        path: '/docs/example.txt',
        type: FileType.txt,
        size: 1024,
        createdAt: DateTime.parse('2026-08-01T10:00:00Z'),
        extraMetadata: {'author': 'test'},
      );

      final updated = original.copyWith(name: 'updated.txt');

      expect(updated.name, 'updated.txt');
      expect(updated.id, original.id);
      expect(updated.path, original.path);
      expect(updated.type, original.type);
      expect(updated.size, original.size);
      expect(updated.createdAt, original.createdAt);
      expect(updated.extraMetadata, original.extraMetadata);
      expect(identical(updated, original), isFalse);
    });
  });
}