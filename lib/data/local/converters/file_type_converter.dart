import 'package:drift/drift.dart';

import '../../../features/storage/domain/models/file_type.dart';

class FileTypeConverter extends TypeConverter<FileType, String> {
  const FileTypeConverter();

  @override
  FileType fromSql(String fromDb) {
    return FileType.values.byName(fromDb);
  }

  @override
  String toSql(FileType value) {
    return value.name;
  }
}