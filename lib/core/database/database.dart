import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

part 'database.g.dart';

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

class Favorites extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer()();
  DateTimeColumn get addedAt => dateTime()();
}

class RecentEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get fileId => integer()();
  DateTimeColumn get openedAt => dateTime()();
}

@DriftDatabase(tables: [LocalFiles, Favorites, RecentEntries])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  static QueryExecutor _openConnection() {
    return driftDatabase(name: 'lo_files_db');
  }
}