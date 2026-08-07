import 'package:drift/drift.dart';

class LocalFiles extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  TextColumn get extension => text().nullable()();
  IntColumn get sizeInBytes => integer()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get modifiedAt => dateTime()();
  BoolColumn get isFolder => boolean().withDefault(const Constant(false))();
  IntColumn get parentId => integer().nullable()();
}