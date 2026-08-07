import 'package:freezed_annotation/freezed_annotation.dart';

part 'folder.freezed.dart';

/// Доменная модель папки виртуального хранилища Lo-Files.
///
/// Важно: `parentId == null` означает корневую папку именно виртуального
/// пространства Lo-Files, а не корень системной файловой системы.
/// Виртуальное хранилище изолировано от системного дерева.
@freezed
abstract class Folder with _$Folder {
  const factory Folder({
    required int id,
    required String name,
    int? parentId,
    required DateTime createdAt,
  }) = _Folder;
}