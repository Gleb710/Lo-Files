import 'package:freezed_annotation/freezed_annotation.dart';

import 'file_type.dart';

part 'file.freezed.dart';

@freezed
abstract class File with _$File {
  const factory File({
    required int id,
    required String name,
    required String path,
    required FileType type,
    required int size,
    required DateTime createdAt,
    /// Дополнительные метаданные объекта.
    ///
    /// Задел под будущую систему плагинов (docs/architecture.md, раздел 9.1).
    /// В MVP не используется активно — поле физически существует, чтобы
    /// избежать изменения сигнатуры [File] после того, как на неё уже
    /// будет ссылаться код остальных модулей (Storage, Viewer, Search,
    /// Recent & Favorites).
    Map<String, dynamic>? extraMetadata,
  }) = _File;
}